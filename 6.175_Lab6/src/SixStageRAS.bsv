import Types::*;
import ProcTypes::*;
import CMemTypes::*;
import RFile::*;
import FPGAMemory::*;
import Decode::*;
import Exec::*;
import CsrFile::*;
import Vector::*;
import Fifo::*;
import Ehr::*;
import GetPut::*;
import Btb::*;
import Scoreboard::*;
import Bht::*;
import Ras::*;

typedef struct {
    Addr pc;
    Addr predPc;
	Bool eEpoch;
    Bool dEpoch;
    Bool rEpoch;
} IF2D deriving (Bits, Eq);

typedef struct {
    Addr pc;
    Addr predPc;
    DecodedInst dInst;
	Bool eEpoch;
    Bool rEpoch;
} D2RF deriving (Bits, Eq);

typedef struct {
    Addr pc;
    Addr predPc;
	DecodedInst dInst;
	Data rVal1;
    Data rVal2;
    Data csrVal;
    Bool eEpoch;
} RF2E deriving (Bits, Eq);

typedef struct {
    Addr pc;
    Addr nextPc;
    Bool eEpoch;
    Bool rEpoch;
} DecRedirect deriving (Bits, Eq);

typedef struct {
	Addr pc;
	Addr nextPc;
    Bool eEpoch;
} RefRedirect deriving (Bits, Eq);

typedef struct {
	Addr pc;
	Addr nextPc;
} ExeRedirect deriving (Bits, Eq);

(* synthesize *)
module mkProc(Proc);
    Ehr#(2, Addr)    pcReg <- mkEhr(?);
    RFile               rf <- mkRFile;
	Scoreboard#(6)      sb <- mkCFScoreboard;
	FPGAMemory        iMem <- mkFPGAMemory;
    FPGAMemory        dMem <- mkFPGAMemory;
    CsrFile           csrf <- mkCsrFile;
    Btb#(6)            btb <- mkBtb; // 64-entry BTB
    Bht#(8)            bht <- mkBht; // 256-entry BHT
	Ras#(8)            ras <- mkRas; // 8-entry RAS

	Reg#(Bool) exeEpoch <- mkReg(False);
    Reg#(Bool) decEpoch <- mkReg(False);
    Reg#(Bool) refEpoch <- mkReg(False);

    Ehr#(2, Maybe#(DecRedirect)) decRedirect <- mkEhr(Invalid);
	Ehr#(2, Maybe#(ExeRedirect)) exeRedirect <- mkEhr(Invalid);
    Ehr#(2, Maybe#(RefRedirect)) refRedirect <- mkEhr(Invalid);

	Fifo#(6, IF2D)     if2dFifo <- mkCFFifo;
	Fifo#(6, D2RF)     d2rfFifo <- mkCFFifo;
	Fifo#(6, RF2E)     rf2eFifo <- mkCFFifo;
	Fifo#(6, ExecInst)  e2mFifo <- mkCFFifo;
	Fifo#(6, ExecInst) m2wbFifo <- mkCFFifo;

    Bool memReady = iMem.init.done && dMem.init.done;

    rule test (!memReady);
        let e = tagged InitDone;
        iMem.init.request.put(e);
        dMem.init.request.put(e);
    endrule

	rule doInstructionFetch(csrf.started && memReady);
		iMem.req(MemReq{op: Ld, addr: pcReg[0], data: ?});
		Addr predPc = btb.predPc(pcReg[0]);
		if2dFifo.enq(IF2D{pc: pcReg[0], predPc: predPc, eEpoch: exeEpoch, dEpoch: decEpoch, rEpoch: refEpoch});
		pcReg[0] <= predPc;

		$display("InstructionFetch: PC = %x", pcReg[0]);
	endrule

	rule doDecode(csrf.started && memReady);
		IF2D if2d = if2dFifo.first;
		Data inst <- iMem.resp;

        if(if2d.eEpoch == exeEpoch && if2d.dEpoch == decEpoch && if2d.rEpoch == refEpoch) begin
            DecodedInst dInst = decode(inst);
            let src1 = fromMaybe(?, dInst.src1);
            let dst  = fromMaybe(?, dInst.dst);
            Bool popValid = False;
            Addr predPc = if2d.predPc;
            Addr popAddr = 0;

            // RAS push and pop
            if((dInst.iType == Jr || dInst.iType == J) && dst == 1) begin
                ras.push(if2d.predPc + 4);
                $display("function call, RAS push: PC = %x, inst = %x, expanded = ", if2d.pc, inst, showInst(inst));
            end
            else if(dInst.iType == Jr && dst == 0 && src1 == 1) begin
                let popMaybeAddr <- ras.pop;
                popValid = isValid(popMaybeAddr);
                popAddr  = fromMaybe(?, popMaybeAddr);
                $display("return from function call: PC = %x, inst = %x, expanded = ", if2d.pc, inst, showInst(inst));
            end

            if(dInst.iType == Br) begin
                predPc = if2d.pc + fromMaybe(?, dInst.imm);
                predPc = bht.predPc(if2d.pc, dInst);
            end
            else if(dInst.iType == J) begin
                predPc = if2d.pc + fromMaybe(?, dInst.imm);
            end
            else if(dInst.iType == Jr && dst == 0 && src1 == 1) begin
                if(popValid) begin
                    predPc = popAddr;
                end
            end
        end
        else begin
            if(if2d.eEpoch != exeEpoch) begin
                $display("kill instruction, exeEpoch not match: PC = %x, inst = %x, expanded = ", if2d.pc, inst, showInst(inst));
            end
            else if(if2d.dEpoch != decEpoch) begin
                $display("kill instruction, decEpoch not match: PC = %x, inst = %x, expanded = ", if2d.pc, inst, showInst(inst));
            end
            else begin
                $display("kill instruction, refEpoch not match: PC = %x, inst = %x, expanded = ", if2d.pc, inst, showInst(inst));
            end
        end

		if2dFifo.deq;	
		$display("Decode: PC = %x, inst = %x, expanded = ", if2d.pc, inst, showInst(inst));
	endrule

	rule doRegisterFetch(csrf.started && memReady);
		D2RF d2rf = d2rfFifo.first;
		DecodedInst dInst = d2rf.dInst;
        Data rVal1 = rf.rd1(fromMaybe(?, dInst.src1));
        Data rVal2 = rf.rd2(fromMaybe(?, dInst.src2));
        Data csrVal = csrf.rd(fromMaybe(?, dInst.csr));
        Addr predPc = d2rf.predPc;

        if(d2rf.eEpoch != exeEpoch) begin
            $display("kill instruction, exeEpoch not match: PC = %x", d2rf.pc);
            d2rfFifo.deq;
        end
        else if(d2rf.rEpoch != refEpoch) begin
            $display("kill instruction, refEpoch not match: PC = %x", d2rf.pc);
            d2rfFifo.deq;
        end
        else begin
            if(!sb.search1(dInst.src1) && !sb.search2(dInst.src2)) begin
                if(dInst.iType == Jr) begin
                    let imm = fromMaybe(?, dInst.imm);
                    Addr jrPredPc = {truncateLSB(rVal1 + imm), 1'b0};
                    if(jrPredPc != predPc) begin
                        $display("Jr mirpredict: PC = %x", d2rf.pc);
                        refRedirect[0] <= Valid (RefRedirect {
                            pc: d2rf.pc,
                            nextPc: jrPredPc,
                            eEpoch: d2rf.eEpoch
                        });
                    end
                    else begin
                        $display("Jr right predict: PC = %x", d2rf.pc);
                    end
                end
                d2rfFifo.deq;
                sb.insert(dInst.dst);
                rf2eFifo.enq(RF2E{pc: d2rf.pc, predPc: d2rf.predPc, dInst: d2rf.dInst, 
                rVal1: rVal1, rVal2: rVal2, csrVal: csrVal, eEpoch: d2rf.eEpoch});
                $display("RegisterFetch: PC = %x", d2rf.pc);
            end
            else begin
                $display("RegisterFetch Stalled: PC = %x", d2rf.pc);
            end
        end
	endrule

	rule doExecute(csrf.started && memReady);
		RF2E rf2e = rf2eFifo.first;
		rf2eFifo.deq;

		if(rf2e.eEpoch != exeEpoch) begin
			$display("Execute: Kill instruction: PC = %x", rf2e.pc);
			e2mFifo.enq(ExecInst{iType: Alu, dst:Invalid, csr:Invalid, data: ?,
			 addr: ?, mispredict:False, brTaken:False});
		end
		else begin
			ExecInst eInst = exec(rf2e.dInst, rf2e.rVal1, rf2e.rVal2, rf2e.pc, 
			rf2e.predPc, rf2e.csrVal);
			if(eInst.mispredict) begin
				$display("Execute finds misprediction: PC = %x", rf2e.pc);
				exeRedirect[0] <= Valid (ExeRedirect {
					pc: rf2e.pc,
					nextPc: eInst.addr
				});
			end
			else begin
				$display("Execute: PC = %x", rf2e.pc);
			end
			e2mFifo.enq(eInst);

			if(eInst.iType == Unsupported) begin
				$fwrite(stderr, "ERROR: Executing unsupported instruction at pc: %x. Exiting\n", rf2e.pc);
				$finish;
			end

            if(eInst.iType == J || eInst.iType == Jr || eInst.iType == Br) begin
                bht.updateBht(rf2e.pc, eInst.brTaken);
            end
		end
	endrule

	rule doMemory(csrf.started && memReady);
		e2mFifo.deq;
		ExecInst eInst = e2mFifo.first;

		if(eInst.iType == Ld) begin
			dMem.req(MemReq{op: Ld, addr: eInst.addr, data: ?});
		end else if(eInst.iType == St) begin
			dMem.req(MemReq{op: St, addr: eInst.addr, data: eInst.data});
		end

		m2wbFifo.enq(eInst);
	endrule

	rule doWriteBack(csrf.started && memReady);
		m2wbFifo.deq;
		ExecInst eInst = m2wbFifo.first;
		if(eInst.iType == Ld) begin
			Data dmres <- dMem.resp;
			if(isValid(eInst.dst)) begin
				rf.wr(fromMaybe(?, eInst.dst), dmres);
			end
			csrf.wr(eInst.iType == Csrw ? eInst.csr : Invalid, dmres);
			sb.remove;
		end 
		else begin
			if(isValid(eInst.dst)) begin
				rf.wr(fromMaybe(?, eInst.dst), eInst.data);
			end
			csrf.wr(eInst.iType == Csrw ? eInst.csr : Invalid, eInst.data);
			sb.remove;
		end
	endrule

	(* fire_when_enabled *)
	(* no_implicit_conditions *)
	rule cononicalizeRedirect(csrf.started);
		if(exeRedirect[1] matches tagged Valid .r) begin
			// fix mispred
			pcReg[1] <= r.nextPc;
			exeEpoch <= !exeEpoch; // flip epoch
			btb.update(r.pc, r.nextPc); // train BTB
			$display("Fetch: Mispredict, redirected by Execute");
		end
        else if(refRedirect[1] matches tagged Valid .r) begin
            pcReg[1] <= r.nextPc;
            refEpoch <= !refEpoch;
            btb.update(r.pc, r.nextPc);
            $display("Fetch: Redirected by Reference");
        end
        else if(decRedirect[1] matches tagged Valid .r) begin
            pcReg[1] <= r.nextPc;
            decEpoch <= !decEpoch;
            btb.update(r.pc, r.nextPc);
            $display("Fetch: Redirected by Decode");
        end
		// reset EHR
		exeRedirect[1] <= Invalid;
        refRedirect[1] <= Invalid;
        decRedirect[1] <= Invalid;
	endrule

    method ActionValue#(CpuToHostData) cpuToHost;
        let ret <- csrf.cpuToHost;
        return ret;
    endmethod

    method Action hostToCpu(Bit#(32) startpc) if ( !csrf.started && memReady );
		csrf.start(0); // only 1 core, id = 0
		// $display("Start at pc 200\n");
		// $fflush(stdout);
        pcReg[0] <= startpc;
    endmethod

	interface iMemInit = iMem.init;
    interface dMemInit = dMem.init;
endmodule
