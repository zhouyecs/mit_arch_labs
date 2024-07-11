import Vector::*;
import Types::*;
import ProcTypes::*;

interface Ras#(numeric type indexSize);
    method ActionValue#(Maybe#(Addr)) pop;
    method Action push(Addr pc);
endinterface

module mkRas(Ras#(indexSize));
    Vector#(indexSize, Reg#(Maybe#(Addr))) rasArr <- replicateM(mkReg(tagged Invalid));
    Reg#(Bit#(TLog#(TAdd#(indexSize, indexSize)))) sp <- mkReg(0);

    method ActionValue#(Maybe#(Addr)) pop;
        let r = rasArr[sp];
        rasArr[sp] <= tagged Invalid;
        if (sp > 0) begin
            sp <= sp - 1;
        end else begin 
            sp <= fromInteger(valueOf(indexSize) - 1);
        end
        return r;
    endmethod

    method Action push(Addr pc);
        if (sp == fromInteger(valueOf(indexSize) - 1)) begin
            sp <= 0;
            rasArr[0] <= tagged Valid pc;
        end else begin 
            sp <= sp + 1;
            rasArr[sp + 1] <= tagged Valid pc;
        end
    endmethod
endmodule