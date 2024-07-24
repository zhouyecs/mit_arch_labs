// modified from SixStageBHT.bsv

import Types::*;
import ProcTypes::*;
import CMemTypes::*;
import RFile::*;
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
import Cache::*;
import CacheTypes::*;
import WideMemInit::*;
import MemUtil::*;


typedef struct {
    Addr pc;
    Addr predPc;
	Bool eEpoch;
    Bool dEpoch;
} IF2D deriving (Bits, Eq);

typedef struct {
    Addr pc;
    Addr predPc;
    DecodedInst dInst;
	Bool eEpoch;
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
} DecRedirect deriving (Bits, Eq);

typedef struct {
	Addr pc;
	Addr nextPc;
} ExeRedirect deriving (Bits, Eq);

// (* synthesize *)
module mkProc#(Fifo#(2,DDR3_Req) ddr3ReqFifo, Fifo#(2,DDR3_Resp) ddr3RespFifo)(Proc);
    Ehr#(2, Addr)    pcReg <- mkEhr(?);
    RFile               rf <- mkRFile;
	Scoreboard#(6)      sb <- mkCFScoreboard;
    CsrFile           csrf <- mkCsrFile;
    Btb#(6)            btb <- mkBtb; // 64-entry BTB
    Bht#(8)            bht <- mkBht; // 256-entry BHT

	Reg#(Bool) exeEpoch <- mkReg(False);
    Reg#(Bool) decEpoch <- mkReg(False);

    Ehr#(2, Maybe#(DecRedirect)) decRedirect <- mkEhr(Invalid);
	Ehr#(2, Maybe#(ExeRedirect)) exeRedirect <- mkEhr(Invalid);

	Fifo#(6, IF2D)     if2dFifo <- mkCFFifo;
	Fifo#(6, D2RF)     d2rfFifo <- mkCFFifo;
	Fifo#(6, RF2E)     rf2eFifo <- mkCFFifo;
	Fifo#(6, ExecInst)  e2mFifo <- mkCFFifo;
	Fifo#(6, ExecInst) m2wbFifo <- mkCFFifo;

    Bool memReady = True;

	WideMem wideMemWrapper <- mkWideMemFromDDR3(ddr3ReqFifo, ddr3RespFifo);
	Vector#(2, WideMem) wideMems <- mkSplitWideMem(memReady && csrf.started, wideMemWrapper);

	rule drainMemResponses(!csrf.started);
		$display("drain!");
		ddr3RespFifo.deq;
	endrule

	Cache iMem <- mkTranslator(wideMems[0]);
	Cache dMem <- mkTranslator(wideMems[1]);

	rule doInstructionFetch(csrf.started);
		iMem.req(MemReq{op: Ld, addr: pcReg[0], data: ?});
		Addr predPc = btb.predPc(pcReg[0]);
		if2dFifo.enq(IF2D{pc: pcReg[0], predPc: predPc, eEpoch: exeEpoch, dEpoch: decEpoch});
		pcReg[0] <= predPc;

		$display("InstructionFetch: PC = %x", pcReg[0]);
	endrule

	rule doDecode(csrf.started);
		IF2D if2d = if2dFifo.first;
		Data inst <- iMem.resp;

        if(if2d.dEpoch == decEpoch) begin
            DecodedInst dInst = decode(inst);
            Addr predPc = dInst.iType == J || dInst.iType == Br ? bht.predPc(if2d.pc, dInst) : if2d.predPc;
            if(if2d.predPc != predPc) begin
                $display("killing wrong path in instruction decode stage");
                decRedirect[0] <= Valid (DecRedirect{
                    pc: if2d.pc, 
                    nextPc: predPc,
                    eEpoch: if2d.eEpoch
                });
                d2rfFifo.enq(D2RF{pc: if2d.pc, predPc: predPc, dInst: dInst, eEpoch: if2d.eEpoch});
            end
            else begin
                d2rfFifo.enq(D2RF{pc: if2d.pc, predPc: if2d.predPc, dInst: dInst, eEpoch: if2d.eEpoch});
            end
        end
        else begin
            $display("kill instruction, decEpoch not match: PC = %x, inst = %x, expanded = ", if2d.pc, inst, showInst(inst));
        end

		if2dFifo.deq;	
		$display("Decode: PC = %x, inst = %x, expanded = ", if2d.pc, inst, showInst(inst));
	endrule

	rule doRegisterFetch(csrf.started);
		D2RF d2rf = d2rfFifo.first;

		DecodedInst dInst = d2rf.dInst;

		if(!sb.search1(dInst.src1) && !sb.search2(dInst.src2)) begin
			d2rfFifo.deq;
			sb.insert(dInst.dst);
			
			Data rVal1 = rf.rd1(fromMaybe(?, dInst.src1));
			Data rVal2 = rf.rd2(fromMaybe(?, dInst.src2));
			Data csrVal = csrf.rd(fromMaybe(?, dInst.csr));

			rf2eFifo.enq(RF2E{pc: d2rf.pc, predPc: d2rf.predPc, dInst: d2rf.dInst, 
			rVal1: rVal1, rVal2: rVal2, csrVal: csrVal, eEpoch: d2rf.eEpoch});

			$display("RegisterFetch: PC = %x", d2rf.pc);
		end
		else begin
			$display("RegisterFetch Stalled: PC = %x", d2rf.pc);
		end
	endrule

	rule doExecute(csrf.started);
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

            if(rf2e.dInst.iType == J || rf2e.dInst.iType == Br) begin
                bht.updateBht(rf2e.pc, eInst.brTaken);
            end
		end
	endrule

	rule doMemory(csrf.started);
		e2mFifo.deq;
		ExecInst eInst = e2mFifo.first;

		if(eInst.iType == Ld) begin
			dMem.req(MemReq{op: Ld, addr: eInst.addr, data: ?});
		end else if(eInst.iType == St) begin
			dMem.req(MemReq{op: St, addr: eInst.addr, data: eInst.data});
		end

		m2wbFifo.enq(eInst);
	endrule

	rule doWriteBack(csrf.started);
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
        else if(decRedirect[1] matches tagged Valid .r) begin
			if(r.eEpoch == exeEpoch) begin
				pcReg[1] <= r.nextPc;
				decEpoch <= !decEpoch;
				$display("Fetch: Redirected by Decode");
			end
        end
		// reset EHR
		exeRedirect[1] <= Invalid;
        decRedirect[1] <= Invalid;
	endrule

    method ActionValue#(CpuToHostData) cpuToHost;
        let ret <- csrf.cpuToHost;
        return ret;
    endmethod

    method Action hostToCpu(Bit#(32) startpc) if (!csrf.started && memReady && !ddr3RespFifo.notEmpty);
		csrf.start(0); // only 1 core, id = 0
		// $display("Start at pc 200\n");
		// $fflush(stdout);
        pcReg[0] <= startpc;
    endmethod
endmodule