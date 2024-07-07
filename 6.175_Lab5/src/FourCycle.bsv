// FourCycle.bsv
//
// This is a four cycle implementation of the RISC-V processor.

import Types::*;
import ProcTypes::*;
import CMemTypes::*;
import RFile::*;
import DelayedMemory::*;
import Decode::*;
import Exec::*;
import CsrFile::*;
import Vector::*;
import Fifo::*;
import Ehr::*;
import GetPut::*;

typedef enum {
	Fetch,
	Decode,
	Execute,
	WriteBack
} State deriving(Bits, Eq, FShow);

(* synthesize *)
module mkProc(Proc);
    Reg#(Addr)		pc   <- mkRegU;
    RFile			rf   <- mkRFile;
    DelayedMemory 	iMem <- mkDelayedMemory;
    DelayedMemory 	dMem <- mkDelayedMemory;
    CsrFile			csrf <- mkCsrFile;
    
	Reg#(State)		state <- mkReg(Fetch);
    Reg#(DecodedInst) d2e <- mkRegU;
	Reg#(ExecInst)    e2w <- mkRegU;

	Bool memReady = iMem.init.done() && dMem.init.done();

	rule test (!memReady);
		let e = tagged InitDone;
        iMem.init.request.put(e);
        dMem.init.request.put(e);
	endrule

	rule doFetch (state == Fetch && csrf.started && memReady);
		iMem.req(MemReq{op: Ld, addr: pc, data: ?});
		state <= Decode;
	endrule

	rule doDecode (state == Decode && csrf.started && memReady);
		let inst <- iMem.resp();
		let d2e_tmp = decode(inst);
		d2e <= d2e_tmp;
		state <= Execute;

		$display("pc: %h inst: (%h) expanded: ", pc, inst, showInst(inst));
		$fflush(stdout);
	endrule

	rule doExecute (state == Execute && csrf.started && memReady);
		let rVal1   = rf.rd1(fromMaybe(?, d2e.src1));
		let rVal2   = rf.rd2(fromMaybe(?, d2e.src2));
		let csrVal  = csrf.rd(fromMaybe(?, d2e.csr));
		let e2w_tmp = exec(d2e, rVal1, rVal2, pc, ?, csrVal);

		if(e2w_tmp.iType == Ld) begin
			dMem.req(MemReq{op: Ld, addr: e2w_tmp.addr, data: ?});
		end else if(e2w_tmp.iType == St) begin
			dMem.req(MemReq{op: St, addr: e2w_tmp.addr, data: e2w_tmp.data});
		end

        if(e2w_tmp.iType == Unsupported) begin
            $fwrite(stderr, "ERROR: Executing unsupported instruction at pc: %x. Exiting\n", pc);
            $finish;
        end

		e2w <= e2w_tmp;
		state <= WriteBack;
	endrule

	rule doWriteback (state == WriteBack && csrf.started && memReady);
		let e2w_tmp = e2w;

		if(e2w_tmp.iType == Ld) begin
			e2w_tmp.data <- dMem.resp;
		end

		if(isValid(e2w_tmp.dst)) begin
			rf.wr(fromMaybe(?, e2w_tmp.dst), e2w_tmp.data);
		end

		pc <= e2w_tmp.brTaken ? e2w_tmp.addr : pc + 4;
		csrf.wr(e2w_tmp.iType == Csrw ? e2w_tmp.csr : Invalid, e2w_tmp.data);
		state <= Fetch;
	endrule

    method ActionValue#(CpuToHostData) cpuToHost;
        let ret <- csrf.cpuToHost;
        return ret;
    endmethod

    method Action hostToCpu(Bit#(32) startpc) if ( !csrf.started && memReady );
        csrf.start(0); // only 1 core, id = 0
		$display("Start at pc 200\n");
		$fflush(stdout);
        pc <= startpc;
        state <= Fetch;
    endmethod

	interface iMemInit = iMem.init;
    interface dMemInit = dMem.init;
endmodule


