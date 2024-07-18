import CacheTypes::*;
import MemUtil::*;
import Fifo::*;
import Vector::*;
import Types::*;
import CMemTypes::*;


// ================ without cache ================

// translation from MemReq to requests to DDR3 (WideMemReq if using WideMem interfaces) 
// and translation from responses from DDR3 (CacheLine if using WideMem interfaces) to MemResp
module mkTranslator(WideMem wideMem, Cache ifc);
    Fifo#(2, MemReq) reqFifo <- mkCFFifo;

    method Action req(MemReq r);
        if (r.op == Ld) reqFifo.enq(r);
        wideMem.req(toWideMemReq(r));
    endmethod

    method ActionValue#(MemResp) resp;
        let req = reqFifo.first;
        reqFifo.deq;

        let cacheLine <- wideMem.resp;
        CacheWordSelect offset = truncate(req.addr >> 2);
        
        return cacheLine[offset];
    endmethod
endmodule

typedef enum { 
    Ready, 
    StartMiss, 
    SendFillReq, 
    WaitFillResp 
} CacheStatus deriving (Eq, Bits);

module mkCache(WideMem wideMem, Cache ifc);
    Vector#(CacheRows, Reg#(CacheLine))         dataArray <- replicateM(mkRegU);
    Vector#(CacheRows, Reg#(Maybe#(CacheTag)))   tagArray <- replicateM(mkReg(Invalid));
    Vector#(CacheRows, Reg#(Bool))             dirtyArray <- replicateM(mkReg(False));

    Fifo#(1, Data)    hitQ <- mkBypassFifo;
    Reg#(MemReq)   missReq <- mkRegU;
    Reg#(CacheStatus) mshr <- mkReg(Ready);

    function CacheIndex getIndex(Addr addr);
        return truncate(addr >> 6);
    endfunction

    function CacheTag getTag(Addr addr);
        return truncateLSB(addr);
    endfunction

    function CacheWordSelect getOffset(Addr addr);
        return truncate(addr >> 2);
    endfunction

    rule startMiss(mshr == StartMiss);
        let idx   = getIndex(missReq.addr);
        let tag   = tagArray[idx];
        let dirty = dirtyArray[idx];

        // the cache clock is dirty, which means it should be written back to memory
        if(isValid(tag) && dirty) begin
            let addr = {fromMaybe(?, tag), idx, 6'b0};
            let data = dataArray[idx];
            wideMem.req(WideMemReq{
                write_en: '1, 
                addr: addr, 
                data: data});
        end

        mshr <= SendFillReq;
    endrule

    rule sendFillReq (mshr == SendFillReq);
        WideMemReq request = toWideMemReq(missReq);
        request.write_en = 0;
        wideMem.req(request);
        
        mshr <= WaitFillResp;
    endrule

    rule waitFillResp (mshr == WaitFillResp);
        let idx    = getIndex(missReq.addr);
        let tag    = getTag(missReq.addr);
        let offset = getOffset(missReq.addr);
        let data  <- wideMem.resp;

        tagArray[idx] <= tagged Valid tag;

        if(missReq.op == Ld) begin
            dirtyArray[idx] <= False;
            dataArray[idx]  <= data;
            hitQ.enq(data[offset]);
        end
        else begin
            data[offset]     = missReq.data;
            dirtyArray[idx] <= True;
            dataArray[idx]  <= data;
        end

        mshr <= Ready;
    endrule

    method Action req(MemReq r) if (mshr == Ready);
        let idx      = getIndex(r.addr);
        let curTag   = tagArray[idx];
        let tag      = getTag(r.addr);
        let hit      = isValid(curTag) ? fromMaybe(?, curTag) == tag : False;
        let offset   = getOffset(r.addr);

        if(hit) begin
            let cacheLine = dataArray[idx];
            if(r.op == Ld) begin
                hitQ.enq(cacheLine[offset]);
            end
            else begin
                cacheLine[offset] = r.data;
                dataArray[idx]   <= cacheLine;
                dirtyArray[idx]  <= True;
            end
        end
        else begin
            missReq <= r;
            mshr <= StartMiss;
        end
    endmethod

    method ActionValue#(MemResp) resp;
        hitQ.deq;
        return hitQ.first;
    endmethod
endmodule