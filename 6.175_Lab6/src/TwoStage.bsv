// TwoStage.bsv
//
// This is a two stage pipelined implementation of the RISC-V processor.

import FIFOF::*;
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
import Ehr::*;
import GetPut::*;

typedef struct{
    Addr pc;
    Addr  ppc;
    Data  inst;
    Bool epoch;
} Fetch2Execute deriving(Eq, Bits, FShow);

function Addr nextAddrPredictor(Addr pc);
    return pc + 4;
endfunction
 
(*synthesize*)
module mkProc(Proc);
    Reg#(Addr) pc <- mkRegU;
    RFile     rf <- mkRFile;
    IMemory  iMem <- mkIMemory;
    DMemory  dMem <- mkDMemory;
    CsrFile  csrf <- mkCsrFile;

    FIFOF#(Fetch2Execute) f2d <- mkSizedFIFOF(3);
    FIFOF#(Addr) execRedirect <- mkSizedFIFOF(3);
    Reg#(Bool) fEpoch <- mkReg(False);
    Reg#(Bool) eEpoch <- mkReg(False);

    Bool memReady = iMem.init.done() && dMem.init.done();
    rule test (!memReady);
        let e = tagged InitDone;
        iMem.init.request.put(e);
        dMem.init.request.put(e);
    endrule
    

    rule doFetch(csrf.started);
        let inst = iMem.req(pc);
        if (execRedirect.notEmpty) begin
            fEpoch <= !fEpoch; 
            pc <= execRedirect.first;
            execRedirect.deq;
        end
        else begin
            let ppc = nextAddrPredictor(pc);
            pc <= ppc;
            f2d.enq(Fetch2Execute{pc:pc, ppc:ppc, inst:inst, epoch:fEpoch});
        end
    endrule
    
    rule doExecute(csrf.started);
        let x = f2d.first;
        if (x.epoch == eEpoch) begin
            let dInst = decode(x.inst);
            Data rVal1 = rf.rd1(fromMaybe(?, dInst.src1));
            Data rVal2 = rf.rd2(fromMaybe(?, dInst.src2));
            Data csrVal = csrf.rd(fromMaybe(?, dInst.csr));

            ExecInst eInst = exec(dInst, rVal1, rVal2, x.pc, x.ppc, csrVal);

            if (eInst.mispredict) begin
                execRedirect.enq(eInst.addr);
                eEpoch <= !eEpoch;
            end

            if(eInst.iType == Ld) begin
                eInst.data <- dMem.req(MemReq{op: Ld, addr: eInst.addr, data: ?});
            end else if(eInst.iType == St) begin
                let d <- dMem.req(MemReq{op: St, addr: eInst.addr, data: eInst.data});
            end

            $display("pc: %h inst: (%h) expanded: ", x.pc, x.inst, showInst(x.inst));
            $fflush(stdout);

            if(eInst.iType == Unsupported) begin
                $fwrite(stderr, "ERROR: Executing unsupported instruction at pc: %x. Exiting\n", x.pc);
                $finish;
            end

            if(isValid(eInst.dst)) begin
                rf.wr(fromMaybe(?, eInst.dst), eInst.data);
            end

            csrf.wr(eInst.iType == Csrw ? eInst.csr : Invalid, eInst.data);
        end
        f2d.deq;
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