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

// Problem 2
(* synthesize *)
module mkAudioPipelineFFT(FFT#(N, FixedPoint#(I_SIZE, P_SIZE)));
    FFT#(N, FixedPoint#(I_SIZE, P_SIZE)) fft <- mkFFT();
    return fft;
endmodule

(* synthesize *)
module mkAudioPipelineIFFT(FFT#(N, FixedPoint#(I_SIZE, P_SIZE)));
    FFT#(N, FixedPoint#(I_SIZE, P_SIZE)) fft <- mkIFFT();
    return fft;
endmodule

(* synthesize *)
module mkAudioPipelineToMP(ToMP#(N, I_SIZE, F_SIZE, P_SIZE));
    ToMP#(N, I_SIZE, F_SIZE, P_SIZE) toMp <- mkToMP();
    return toMp;
endmodule

(* synthesize *)
module mkAudioPipelineFromMP(FromMP#(N, I_SIZE, F_SIZE, P_SIZE));
    FromMP#(N, I_SIZE, F_SIZE, P_SIZE) fromMp <- mkFromMP();
    return fromMp;
endmodule

(* synthesize *)
module mkAudioPipelinePitchAdjust(SettablePitchAdjust#(N, I_SIZE, F_SIZE, P_SIZE));
    // FixedPoint#(I_SIZE, P_SIZE) factor = 2.0;
    SettablePitchAdjust#(N, I_SIZE, F_SIZE, P_SIZE) settablePitchAdjust <- mkPitchAdjust(valueOf(S));
    return settablePitchAdjust;
endmodule

(* synthesize *)
module mkAudioPipelineFIRFilter(AudioProcessor);
    AudioProcessor fir <- mkFIRFilter(c);
    return fir;
endmodule

module mkAudioPipeline(SettableAudioProcessor#(I_SIZE, F_SIZE));

    AudioProcessor fir <- mkAudioPipelineFIRFilter();

    Chunker#(S, Sample) chunker <- mkChunker();

    OverSampler#(S, N, Sample) overSampler <- mkOverSampler(replicate(0));

    FFT#(N, FixedPoint#(I_SIZE, P_SIZE)) fft <- mkAudioPipelineFFT();

    ToMP#(N, I_SIZE, F_SIZE, P_SIZE) toMp <- mkAudioPipelineToMP();

    // Problem 4
    SettablePitchAdjust#(N, I_SIZE, F_SIZE, P_SIZE) settablePitchAdjust <- mkAudioPipelinePitchAdjust();
    PitchAdjust#(N, I_SIZE, F_SIZE, P_SIZE) pitchAdjust = settablePitchAdjust.pitchAdjust;

    FromMP#(N, I_SIZE, F_SIZE, P_SIZE) fromMp <- mkAudioPipelineFromMP();

    FFT#(N, FixedPoint#(I_SIZE, P_SIZE)) ifft <- mkAudioPipelineIFFT();

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
    
    interface AudioProcessor audioProcessor;
        method Action putSampleInput(Sample x);
            fir.putSampleInput(x);
        endmethod

        method ActionValue#(Sample) getSampleOutput();
            let x <- splitter.response.get();
            return x;
        endmethod
    endinterface

    interface Put setFactor;
        method Action put(FixedPoint#(I_SIZE, F_SIZE) x);
            settablePitchAdjust.setFactor.put(x);
        endmethod
    endinterface
    
endmodule

