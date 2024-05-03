
import ClientServer::*;
import FIFO::*;
import GetPut::*;

import FixedPoint::*;
import Vector::*;

import ComplexMP::*;


typedef Server#(
    Vector#(nbins, ComplexMP#(isize, fsize, psize)),
    Vector#(nbins, ComplexMP#(isize, fsize, psize))
) PitchAdjust#(numeric type nbins, numeric type isize, numeric type fsize, numeric type psize);

// Problem 4
interface SettablePitchAdjust#(
        numeric type nbins, numeric type isize,
        numeric type fsize, numeric type psize
    );
    interface PitchAdjust#(nbins, isize, fsize, psize) pitchAdjust;
    interface Put#(FixedPoint#(isize, fsize)) setFactor;
endinterface

// s - the amount each window is shifted from the previous window.
//
// factor - the amount to adjust the pitch.
//  1.0 makes no change. 2.0 goes up an octave, 0.5 goes down an octave, etc...
// Problem 4
module mkPitchAdjust(Integer s, SettablePitchAdjust#(nbins, isize, fsize, psize) ifc) provisos (Add#(psize, a__, isize), Add#(psize, b__, TAdd#(isize, isize)));
    // Problem 1
    FIFO#(Vector#(nbins, ComplexMP#(isize, fsize, psize))) in  <- mkFIFO(); 
    FIFO#(Vector#(nbins, ComplexMP#(isize, fsize, psize))) out <- mkFIFO(); 

    Vector#(nbins, Reg#(Phase#(psize))) inphases  <- replicateM(mkReg(0));
    Vector#(nbins, Reg#(Phase#(psize))) outphases <- replicateM(mkReg(0));

    Reg#(FixedPoint#(isize, fsize)) factor <- mkRegU();
    // Reg#(FixedPoint#(isize, fsize)) factor <- mkReg(factor_init);
    Reg#(Bool) set_factor <- mkReg(False);

    rule adjust (set_factor == True);
        Vector#(nbins, ComplexMP#(isize, fsize, psize)) in_data = in.first();
        in.deq();
        FixedPoint#(isize, fsize) mag_0 = fromInteger(0);
        Phase#(psize) phase_0 = fromInteger(0);
        Vector#(nbins, ComplexMP#(isize, fsize, psize)) out_data = replicate(cmplxmp(mag_0, phase_0));

        for(Integer i = 0; i < valueOf(nbins); i = i + 1) begin
            Phase#(psize) phase                 = in_data[i].phase;
            FixedPoint#(isize, fsize) mag       = in_data[i].magnitude;
            Phase#(psize) dphase                = phase - inphases[i];
            FixedPoint#(isize, fsize) dphase_f  = fromInt(dphase);
            inphases[i] <= phase;

            FixedPoint#(isize, fsize) ph_i      = fromInteger(i);
            FixedPoint#(isize, fsize) ph_iplus1 = fromInteger(i + 1);

            let bin  = fxptGetInt(ph_i * factor);
            let nbin = fxptGetInt(ph_iplus1 * factor);
            if(bin != nbin && bin >= 0 && bin < fromInteger(valueOf(nbins))) begin
                Phase#(psize) shifted = truncate(fxptGetInt(fxptMult(dphase_f, factor)));
                out_data[bin] = cmplxmp(mag, outphases[bin] + shifted);
                outphases[bin] <= outphases[bin] + shifted;
            end
        end
        out.enq(out_data);
    endrule

    // interface Put request  = toPut(in);
    // interface Get response = toGet(out);
    // Problem 4
    interface PitchAdjust pitchAdjust;
        interface Put request = toPut(in);
        interface Get response = toGet(out);
    endinterface

    interface Put setFactor;
        method Action put(FixedPoint#(isize, fsize) x) if(set_factor == False);
            factor <= x;
            set_factor <= True;
        endmethod
    endinterface

endmodule