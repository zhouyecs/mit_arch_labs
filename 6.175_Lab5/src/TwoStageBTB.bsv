// TwoStageBTB.bsv
//
// This is a two stage pipelined (with BTB) implementation of the RISC-V processor.

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
import Btb::*;
import GetPut::*;

typedef struct {
	DecodedInst dInst;
	Addr pc;
	Addr predPc;
    Bool epoch;
} Fe2Ex deriving (Bits, Eq, FShow);

(* synthesize *)
module mkProc(Proc);
    Reg#(Addr)           pc <- mkRegU;
    RFile                rf <- mkRFile;
	IMemory            iMem <- mkIMemory;
    DMemory            dMem <- mkDMemory;
    CsrFile            csrf <- mkCsrFile;
    Fifo#(2, Fe2Ex)     d2e <- mkCFFifo;
    Reg#(Bool)       fEpoch <- mkReg(False);
    Reg#(Bool)       eEpoch <- mkReg(False);
    Fifo#(2, Addr) redirect <- mkCFFifo;
    Btb#(8)             btb <- mkBtb;

    Bool memReady = iMem.init.done() && dMem.init.done();
    rule test (!memReady);
    let e = tagged InitDone;
    iMem.init.request.put(e);
    dMem.init.request.put(e);
    endrule    

    rule doFetch(csrf.started && memReady);
        let inst = iMem.req(pc);
        if(redirect.notEmpty) begin
            fEpoch <= !fEpoch;
            pc <= redirect.first;
            redirect.deq;
        end
        else begin
            let ppc = btb.predPc(pc);
            pc <= ppc;
            let dInst = decode(inst);
            d2e.enq(Fe2Ex{ pc: pc, predPc: ppc, dInst: dInst, epoch: fEpoch });
        end

        $display("pc: %h inst: (%h) expanded: ", pc[0], inst, showInst(inst));
		$fflush(stdout);
    endrule

    rule doExecute(csrf.started && memReady);
        let x = d2e.first;
        if(x.epoch == eEpoch) begin
            let inpc   = x.pc;
            let dInst  = x.dInst;
            let ppc    = x.predPc;
            let rVal1  = rf.rd1(fromMaybe(?, dInst.src1));
            let rVal2  = rf.rd2(fromMaybe(?, dInst.src2));
            let csrVal = csrf.rd(fromMaybe(?, dInst.csr));
            let eInst  = exec(dInst, rVal1, rVal2, inpc, ppc, csrVal);
            
            if (eInst.mispredict) begin
                btb.update(inpc, eInst.addr);
                redirect.enq(eInst.addr);
                eEpoch <= !eEpoch;
                d2e.clear;
            end

            if(eInst.iType == Ld) begin
                eInst.data <- dMem.req(MemReq{op: Ld, addr: eInst.addr, data: ?});
            end else if(eInst.iType == St) begin
                let d <- dMem.req(MemReq{op: St, addr: eInst.addr, data: eInst.data});
            end

            if(eInst.iType == Unsupported) begin
                $fwrite(stderr, "ERROR: Executing unsupported instruction at pc: %x. Exiting\n", inpc);
                $finish;
            end

            if(isValid(eInst.dst)) begin
                rf.wr(fromMaybe(?, eInst.dst), eInst.data);
            end

            csrf.wr(eInst.iType == Csrw ? eInst.csr : Invalid, eInst.data);
        end
        d2e.deq;
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
    endmethod

	interface iMemInit = iMem.init;
    interface dMemInit = dMem.init;
endmodule
