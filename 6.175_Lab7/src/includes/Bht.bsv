import Vector::*;
import Types::*;

interface Bht#(numeric type indexSize);
    method Addr predPc(Addr pc, Addr targetPc);
    method Action updateBht(Addr pc, Bool taken);
endinterface

module mkBht(Bht#(indexSize)) provisos(Add#(indexSize, a_, 32));
    Vector#(TExp#(indexSize), Reg#(Bit#(2))) bhtArr <- replicateM(mkReg(2'b01));

    function Bit#(indexSize) getBhtIndex(Addr pc);
         return truncate(pc >> 2);
    endfunction

    function Addr getTargetPc(Addr pc, Addr predPc, Bool taken);
        return taken ? predPc : pc + 4;
    endfunction

    function Bool predBrTaken(Bit#(2) bhtEntry);
        case(bhtEntry) matches
            2'b11: return True;
            2'b10: return True;
            2'b01: return False;
            2'b00: return False;
        endcase
    endfunction

    function Bit#(2) updateBhtEntry(Bit#(2) bhtEntry, Bool taken);
        if(taken) begin
            case(bhtEntry) matches
                2'b11: return 2'b11;
                2'b10: return 2'b11;
                2'b01: return 2'b10;
                2'b00: return 2'b01;
            endcase
        end
        else begin
            case(bhtEntry) matches
                2'b11: return 2'b10;
                2'b10: return 2'b01;
                2'b01: return 2'b00;
                2'b00: return 2'b00;
            endcase
        end
    endfunction

    method Action updateBht(Addr pc, Bool taken);
        Bit#(indexSize) index = getBhtIndex(pc);
        Bit#(2) bhtEntry = bhtArr[index];
        bhtArr[index] <= updateBhtEntry(bhtEntry, taken);
    endmethod

    method Addr predPc(Addr pc, Addr targetPc);
        Bool isTaken = predBrTaken(bhtArr[getBhtIndex(pc)]);
        return getTargetPc(pc, targetPc, isTaken);
    endmethod
endmodule