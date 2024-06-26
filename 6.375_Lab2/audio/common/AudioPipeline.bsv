
import ClientServer::*;
import GetPut::*;

import AudioProcessorTypes::*;
import Chunker::*;
import FFT::*;
import FIRFilter::*;
import FilterCoefficients::*;
import Splitter::*;
import FixedPoint::*;

module mkAudioPipeline(AudioProcessor);

    // problem 1-3
    // AudioProcessor fir <- mkFIRFilter();
    // problem 4-7
    AudioProcessor fir <- mkFIRFilter(c);
    Chunker#(FFT_POINTS, ComplexSample) chunker <- mkChunker();
    // no polymorphic
    FFT fft <- mkFFT();
    FFT ifft <- mkIFFT();
    // polymorphic
    // FFT#(FFT_POINTS, FixedPoint#(16, 16)) fft <- mkFFT();
    // FFT#(FFT_POINTS, FixedPoint#(16, 16)) ifft <- mkIFFT();

    Splitter#(FFT_POINTS, ComplexSample) splitter <- mkSplitter();

    rule fir_to_chunker (True);
        let x <- fir.getSampleOutput();
        chunker.request.put(tocmplx(x));
    endrule

    rule chunker_to_fft (True);
        let x <- chunker.response.get();
        fft.request.put(x);
    endrule

    rule fft_to_ifft (True);
        let x <- fft.response.get();
        ifft.request.put(x);
    endrule

    rule ifft_to_splitter (True);
        let x <- ifft.response.get();
        splitter.request.put(x);
    endrule
    
    method Action putSampleInput(Sample x);
        fir.putSampleInput(x);
    endmethod

    method ActionValue#(Sample) getSampleOutput();
        let x <- splitter.response.get();
        return frcmplx(x);
    endmethod

endmodule

