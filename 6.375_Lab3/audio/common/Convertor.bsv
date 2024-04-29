// Problem 3
import Cordic::*;
import GetPut::*;
import Vector::*;
import Complex::*;
import ComplexMP::*;
import FIFO::*;
import ClientServer::*;


typedef Server#(
    Vector#(nbins, Complex#(FixedPoint#(isize, fsize))),
    Vector#(nbins, ComplexMP#(isize, fsize, psize))
) ToMP#(numeric type nbins, numeric type isize, numeric type fsize, numeric type psize);

typedef Server#(
    Vector#(nbins, ComplexMP#(isize, fsize, psize)),
    Vector#(nbins, Complex#(FixedPoint#(isize, fsize)))
) FromMP#(numeric type nbins, numeric type isize, numeric type fsize, numeric type psize);

module mkToMP(ToMP#(nbins, isize, fsize, psize) ifc);
    FIFO#(Vector#(nbins, Complex#(FixedPoint#(isize, fsize)))) input <- mkFIFO();
    FIFO#(Vector#(nbins, ComplexMP#(isize, fsize, psize))) output <- mkFIFO();

    Vector#(nbins, ToMagnitudePhase#(isize, fsize, psize)) toMP <- replicateM(mkCordicToMagnitudePhase());

    rule in;
        Vector#(nbins, Complex#(FixedPoint#(isize, fsize))) in_data = input.first();
        input.deq();
        for(Integer i = 0; i < valueOf(nbins); i = i + 1) begin
            toMP[i].request.put(in_data);
        end
    endrule

    rule out;
        Vector#(nbins, ComplexMP#(isize, fsize, psize)) out_data = replicateM(mkComplexMP(0, 0));
        for(Integer i = 0; i < valueOf(nbins); i = i + 1) begin
            out_data[i] = toMP[i].response.get();
        end
        output.enq(out_data);
    endrule

    interface Put request = toPut(input);
    interface Get response = toGet(output);
endmodule

module mkFromMP(FromMP#(nbins, isize, fsize, psize) ifc);
    FIFO#(Vector#(nbins, Complex#(FixedPoint#(isize, fsize)))) output <- mkFIFO();
    FIFO#(Vector#(nbins, ComplexMP#(isize, fsize, psize))) input <- mkFIFO();

    Vector#(nbins, FromMagnitudePhase#(isize, fsize, psize)) fromMP <- replicateM(mkCordicFromMagnitudePhase());

    rule in;
        Vector#(nbins, ComplexMP#(isize, fsize, psize)) in_data = input.first();
        input.deq();
        for(Integer i = 0; i < valueOf(nbins); i = i + 1) begin
            fromMP[i].request.put(in_data);
        end
    endrule

    rule out;
        Vector#(nbins, Complex#(FixedPoint#(isize, fsize))) out_data = replicateM(mkComplex(0, 0));
        for(Integer i = 0; i < valueOf(nbins); i = i + 1) begin
            out_data[i] = fromMP[i].response.get();
        end
        output.enq(out_data);
    endrule

    interface Put request = toPut(input);
    interface Get response = toGet(output);
endmodule