import FIFO::*;
import FixedPoint::*;
import Vector::*;

import AudioProcessorTypes::*;
import FilterCoefficients::*;
import Multiplier::*;

// The FIR Filter Module Definition
// Problem 4
module mkFIRFilter (Vector#(tnp1, FixedPoint#(16, 16)) coeffs, AudioProcessor ifc);

    FIFO#(Sample) infifo <- mkFIFO();
    FIFO#(Sample) outfifo <- mkFIFO();
    // Vector#(8,Reg#(Sample)) r<-replicateM(mkReg(0));
    // Vector#(9,Multiplier) m<-replicateM(mkMultiplier());
    Vector#(TSub#(tnp1, 1), Reg#(Sample)) r <- replicateM(mkReg(0));
    Vector#(tnp1 , Multiplier) m <- replicateM(mkMultiplier());

    rule mult(True);
        Sample sample = infifo.first();
        infifo.deq();
        r[0] <= sample;
        for(Integer i = 0; i < valueOf(tnp1) - 2; i = i + 1) begin
            r[i + 1] <= r[i];
        end

        m[0].putOperands(coeffs[0], sample);
        for(Integer i = 1; i < valueOf(tnp1); i = i + 1) begin
            m[i].putOperands(coeffs[i], r[i - 1]);
        end
    endrule

    rule add(True);
        Vector#(tnp1,FixedPoint#(16, 16)) res;
        res[0] <- m[0].getResult();
        for(Integer i = 1; i < valueOf(tnp1); i = i + 1) begin
            let x <- m[i].getResult();
            res[i] = res[i -1 ] + x;
        end
        outfifo.enq(fxptGetInt(res[valueOf(tnp1) - 1]));
    endrule

    method Action putSampleInput(Sample in);
        infifo.enq(in);
    endmethod

    method ActionValue#(Sample) getSampleOutput();
        outfifo.deq();
        return outfifo.first();
    endmethod

endmodule
