// TwoStage.bsv
//
// This is a two stage pipelined implementation of the RISC-V processor.

import Types::*;
import ProcTypes::*;
import CMemTypes::*;
import MemInit::*;
import RFile::*;
import DMemory::*;
import IMemory::*;
import Decode::*;
import Exec::*;
import CsrFile::*;
import Vector::*;
import Fifo::*;
import Ehr::*;
import GetPut::*;

typedef struct {
	DecodedInst dInst;
	Addr pc;
} Fe2Ex deriving (Bits, Eq, FShow);

(* synthesize *)
module mkProc(Proc);
    Ehr#(2, Addr)    pc <- mkEhrU;
    RFile            rf <- mkRFile;
	IMemory        iMem <- mkIMemory;
    DMemory        dMem <- mkDMemory;
    CsrFile        csrf <- mkCsrFile;
    Fifo#(2, Fe2Ex) d2e <- mkCFFifo;

    Bool memReady = iMem.init.done() && dMem.init.done();

    rule test (!memReady);
        let e = tagged InitDone;
        iMem.init.request.put(e);
        dMem.init.request.put(e);
    endrule

    rule doFetch(csrf.started && memReady);
        let inst = iMem.req(pc[0]);
        let ppc = pc[0] + 4;
        pc[0] <= ppc;
        let dInst = decode(inst);
        d2e.enq(Fe2Ex{ pc: pc[0], dInst: dInst });

        $display("pc: %h inst: (%h) expanded: ", pc[0], inst, showInst(inst));
		$fflush(stdout);
    endrule

    rule doExecute(csrf.started && memReady);
        let bundle = d2e.first;
        let inpc   = bundle.pc;
        let dInst  = bundle.dInst;
        let rVal1  = rf.rd1(fromMaybe(?, dInst.src1));
        let rVal2  = rf.rd2(fromMaybe(?, dInst.src2));
        let csrVal = csrf.rd(fromMaybe(?, dInst.csr));
        let eInst  = exec(dInst, rVal1, rVal2, inpc, inpc + 4, csrVal);

        if(eInst.iType == Ld) begin
            eInst.data <- dMem.req(MemReq{ op: Ld, addr: eInst.addr, data: ? });
        end else if(eInst.iType == St) begin
            let d <- dMem.req(MemReq{ op: St, addr: eInst.addr, data: eInst.data });
        end

        if(eInst.iType == Unsupported) begin
            $fwrite(stderr, "ERROR: Executing unsupported instruction at pc: %x. Exiting\n", inpc);
            $finish;
        end

        if(isValid(eInst.dst)) begin
            rf.wr(fromMaybe(?, eInst.dst), eInst.data);
        end

        csrf.wr(eInst.iType == Csrw ? eInst.csr : Invalid, eInst.data);

        if (eInst.mispredict) begin
            pc[1] <= eInst.addr;
            d2e.clear;
        end
        else begin
            d2e.deq;
        end
    endrule


    method ActionValue#(CpuToHostData) cpuToHost;
        let ret <- csrf.cpuToHost;
        return ret;
    endmethod

    method Action hostToCpu(Bit#(32) startpc) if ( !csrf.started && memReady );
        csrf.start(0); // only 1 core, id = 0
        $display("Start at pc 200\n");
		$fflush(stdout);
        pc[0] <= startpc;
    endmethod

	interface iMemInit = iMem.init;
    interface dMemInit = dMem.init;
endmodule
