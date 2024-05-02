// Problem 3
import Cordic::*;
import GetPut::*;
import Vector::*;
import Complex::*;
import ComplexMP::*;
import FIFO::*;
import ClientServer::*;
import FixedPoint::*;


typedef Server#(
    Vector#(nbins, Complex#(FixedPoint#(isize, fsize))),
    Vector#(nbins, ComplexMP#(isize, fsize, psize))
) ToMP#(numeric type nbins, numeric type isize, numeric type fsize, numeric type psize);

typedef Server#(
    Vector#(nbins, ComplexMP#(isize, fsize, psize)),
    Vector#(nbins, Complex#(FixedPoint#(isize, fsize)))
) FromMP#(numeric type nbins, numeric type isize, numeric type fsize, numeric type psize);

module mkToMP(ToMP#(nbins, isize, fsize, psize) ifc);
    FIFO#(Vector#(nbins, Complex#(FixedPoint#(isize, fsize)))) inFifo <- mkFIFO();
    FIFO#(Vector#(nbins, ComplexMP#(isize, fsize, psize))) outFifo <- mkFIFO();

    Vector#(nbins, ToMagnitudePhase#(isize, fsize, psize)) toMP <- replicateM(mkCordicToMagnitudePhase());

    rule in;
        Vector#(nbins, Complex#(FixedPoint#(isize, fsize))) in_data = inFifo.first();
        inFifo.deq();
        for(Integer i = 0; i < valueOf(nbins); i = i + 1) begin
            toMP[i].request.put(in_data[i]);
        end
    endrule

    rule out;
        Vector#(nbins, ComplexMP#(isize, fsize, psize)) out_data;
        for(Integer i = 0; i < valueOf(nbins); i = i + 1) begin
            out_data[i] <- toMP[i].response.get();
        end
        outFifo.enq(out_data);
    endrule

    interface Put request = toPut(inFifo);
    interface Get response = toGet(outFifo);
endmodule

module mkFromMP(FromMP#(nbins, isize, fsize, psize) ifc);
    FIFO#(Vector#(nbins, Complex#(FixedPoint#(isize, fsize)))) outFifo <- mkFIFO();
    FIFO#(Vector#(nbins, ComplexMP#(isize, fsize, psize))) inFifo <- mkFIFO();

    Vector#(nbins, FromMagnitudePhase#(isize, fsize, psize)) fromMP <- replicateM(mkCordicFromMagnitudePhase());

    rule in;
        Vector#(nbins, ComplexMP#(isize, fsize, psize)) in_data = inFifo.first();
        inFifo.deq();
        for(Integer i = 0; i < valueOf(nbins); i = i + 1) begin
            fromMP[i].request.put(in_data[i]);
        end
    endrule

    rule out;
        Vector#(nbins, Complex#(FixedPoint#(isize, fsize))) out_data;
        for(Integer i = 0; i < valueOf(nbins); i = i + 1) begin
            out_data[i] <- fromMP[i].response.get();
        end
        outFifo.enq(out_data);
    endrule

    interface Put request = toPut(inFifo);
    interface Get response = toGet(outFifo);
endmodule