// Problem 4
import ClientServer::*;
import GetPut::*;

import AudioProcessorTypes::*;
import Chunker::*;
import FFT::*;
import FIRFilter::*;
import FilterCoefficients::*;
import Splitter::*;
import FixedPoint::*;
import OverSampler::*;
import Convertor::*;
import PitchAdjust::*;
import Overlayer::*;
import Vector::*;

typedef 8 N;
typedef 2 S;
typedef 16 I_SIZE;
typedef 16 F_SIZE;
typedef 16 P_SIZE;

module mkAudioPipeline(AudioProcessor);

    AudioProcessor fir <- mkFIRFilter(c);

    Chunker#(S, Sample) chunker <- mkChunker();

    OverSampler#(S, N, Sample) overSampler <- mkOverSampler(replicate(0));

    FFT#(N, FixedPoint#(I_SIZE, P_SIZE)) fft <- mkFFT();

    ToMP#(N, I_SIZE, F_SIZE, P_SIZE) toMp <- mkToMP();

    FixedPoint#(I_SIZE, P_SIZE) factor = 2.0;
    PitchAdjust#(N, I_SIZE, F_SIZE, P_SIZE) pitchAdjust <- mkPitchAdjust(valueOf(S), factor);

    FromMP#(N, I_SIZE, F_SIZE, P_SIZE) fromMp <- mkFromMP();

    FFT#(N, FixedPoint#(I_SIZE, P_SIZE)) ifft <- mkIFFT();

    Overlayer#(N, S, Sample) overLayer <- mkOverlayer(replicate(0));

    Splitter#(S, Sample) splitter <- mkSplitter();


    rule fir_to_chunker (True);
        let x <- fir.getSampleOutput();
        chunker.request.put(x);
    endrule

    rule chunker_to_oversampler (True);
        let x <- chunker.response.get();
        overSampler.request.put(x);
    endrule

    rule oversampler_to_fft (True);
        let x <- overSampler.response.get();
        Vector#(N, ComplexSample) y = replicate(0);
        for(Integer i = 0; i < valueOf(N); i = i + 1)
            y[i] = tocmplx(x[i]);
        fft.request.put(y);
    endrule

    rule fft_to_tomp (True);
        let x <- fft.response.get();
        toMp.request.put(x);
    endrule

    rule tomp_to_pitchadjust (True);
        let x <- toMp.response.get();
        pitchAdjust.request.put(x);
    endrule
    
    rule pitchadjust_to_frommp (True);
        let x <- pitchAdjust.response.get();
        fromMp.request.put(x);
    endrule

    rule frommp_to_ifft (True);
        let x <- fromMp.response.get();
        ifft.request.put(x);
    endrule

    rule ifft_to_overlayer (True);
        let x <- ifft.response.get();
        Vector#(N, Sample) y = replicate(0);
        for(Integer i = 0; i < valueOf(N); i = i + 1)
            y[i] = frcmplx(x[i]);
        overLayer.request.put(y);
    endrule

    rule overlayer_to_splitter (True);
        let x <- overLayer.response.get();
        splitter.request.put(x);
    endrule
    
    method Action putSampleInput(Sample x);
        fir.putSampleInput(x);
    endmethod

    method ActionValue#(Sample) getSampleOutput();
        let x <- splitter.response.get();
        return x;
    endmethod

endmodule

