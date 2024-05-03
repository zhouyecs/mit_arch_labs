
import ClientServer::*;
import GetPut::*;
import Vector::*;
import PitchAdjust::*;
import FixedPoint::*;
import FShow::*;
import ComplexMP::*;

// Unit test for PitchAdjust
(* synthesize *)
module mkPitchAdjustTest (Empty);

    // For nbins = 8, S = 2, pitch factor = 2.0
    // PitchAdjust#(8, 16, 16, 16) adjust <- mkPitchAdjust(2, 2);
    // Problem 4
    SettablePitchAdjust#(8, 16, 16, 16) pitch <- mkPitchAdjust(2);
    PitchAdjust#(8, 16, 16, 16) adjust = pitch.pitchAdjust;

    Reg#(Bool) passed <- mkReg(True);
    Reg#(Bit#(32)) feed <- mkReg(0);
    Reg#(Bit#(32)) check <- mkReg(0);
    Reg#(Bool) setFactor <- mkReg(False);
    // pitch.setFactor.put(2.0);

    rule setFactor (setFactor == False);
        pitch.setFactor.put(2.0);
        setFactor <= True;
    endrule
    
    function Action dofeed(Vector#(8, ComplexMP#(16, 16, 16)) x);
        action
        adjust.request.put(x);
            feed <= feed+1;
        endaction
    endfunction

    function Action docheck(Vector#(8, ComplexMP#(16, 16, 16)) wnt);
        action
            let x <- adjust.response.get();
            if (x != wnt) begin
                $display("wnt: ", fshow(wnt));
                $display("got: ", fshow(x));
                passed <= False;
            end
            check <= check+1;
        endaction
    endfunction

    // rule setFactor (setFactor == False);
    //     pitch.setFactor.put(2.0);
    //     setFactor <= True;
    // endrule;
    
    // Vector#(8, ComplexMP#(16, 16, 16)) ti1 = newVector;
    // ti1[0] = cmplxmp(1.000000, tophase(3.141593));
    // ti1[1] = cmplxmp(1.000000, tophase(-1.570796));
    // ti1[2] = cmplxmp(1.000000, tophase(0.000000));
    // ti1[3] = cmplxmp(1.000000, tophase(1.570796));
    // ti1[4] = cmplxmp(1.000000, tophase(3.141593));
    // ti1[5] = cmplxmp(1.000000, tophase(-1.570796));
    // ti1[6] = cmplxmp(1.000000, tophase(0.000000));
    // ti1[7] = cmplxmp(1.000000, tophase(1.570796));

    // Vector#(8, ComplexMP#(16, 16, 16)) to1 = newVector;
    // to1[0] = cmplxmp(1.000000, tophase(-0.000000));
    // to1[1] = cmplxmp(0.000000, tophase(0.000000));
    // to1[2] = cmplxmp(1.000000, tophase(-3.141593));
    // to1[3] = cmplxmp(0.000000, tophase(0.000000));
    // to1[4] = cmplxmp(1.000000, tophase(0.000000));
    // to1[5] = cmplxmp(0.000000, tophase(0.000000));
    // to1[6] = cmplxmp(1.000000, tophase(3.141593));
    // to1[7] = cmplxmp(0.000000, tophase(0.000000));

    // Vector#(8, ComplexMP#(16, 16, 16)) ti2 = newVector;
    // ti2[0] = cmplxmp(1.000000, tophase(3.141593));
    // ti2[1] = cmplxmp(1.000000, tophase(0.000000));
    // ti2[2] = cmplxmp(1.000000, tophase(3.141593));
    // ti2[3] = cmplxmp(1.000000, tophase(0.000000));
    // ti2[4] = cmplxmp(1.000000, tophase(3.141593));
    // ti2[5] = cmplxmp(1.000000, tophase(0.000000));
    // ti2[6] = cmplxmp(1.000000, tophase(3.141593));
    // ti2[7] = cmplxmp(1.000000, tophase(0.000000));

    // Vector#(8, ComplexMP#(16, 16, 16)) to2 = newVector;
    // to2[0] = cmplxmp(1.000000, tophase(-0.000000));
    // to2[1] = cmplxmp(0.000000, tophase(0.000000));
    // to2[2] = cmplxmp(1.000000, tophase(0.000000));
    // to2[3] = cmplxmp(0.000000, tophase(0.000000));
    // to2[4] = cmplxmp(1.000000, tophase(-0.000000));
    // to2[5] = cmplxmp(0.000000, tophase(0.000000));
    // to2[6] = cmplxmp(1.000000, tophase(0.000000));
    // to2[7] = cmplxmp(0.000000, tophase(0.000000));

    // Vector#(8, ComplexMP#(16, 16, 16)) ti3 = newVector;
    // ti3[0] = cmplxmp(0.000000, tophase(0.000000));
    // ti3[1] = cmplxmp(6.395666, tophase(2.455808));
    // ti3[2] = cmplxmp(9.899495, tophase(-2.356194));
    // ti3[3] = cmplxmp(14.801873, tophase(-1.229828));
    // ti3[4] = cmplxmp(14.000000, tophase(0.000000));
    // ti3[5] = cmplxmp(14.801873, tophase(1.229828));
    // ti3[6] = cmplxmp(9.899495, tophase(2.356194));
    // ti3[7] = cmplxmp(6.395666, tophase(-2.455808));

    // Vector#(8, ComplexMP#(16, 16, 16)) to3 = newVector;
    // to3[0] = cmplxmp(0.000000, tophase(0.000000));
    // to3[1] = cmplxmp(0.000000, tophase(0.000000));
    // to3[2] = cmplxmp(6.395666, tophase(-1.371570));
    // to3[3] = cmplxmp(0.000000, tophase(0.000000));
    // to3[4] = cmplxmp(9.899495, tophase(1.570796));
    // to3[5] = cmplxmp(0.000000, tophase(0.000000));
    // to3[6] = cmplxmp(14.801873, tophase(-2.4597));
    // to3[7] = cmplxmp(0.000000, tophase(0.000000));

    Vector#(8, ComplexMP#(16, 16, 16)) ti1 = newVector;
    ti1[0] = cmplxmp(273.000000, tophase(0.000000 ));
    ti1[1] = cmplxmp(13.480010 , tophase(1.894905 ));
    ti1[2] = cmplxmp(6.403124  , tophase(2.245537 ));
    ti1[3] = cmplxmp(6.347387  , tophase(2.688567 ));
    ti1[4] = cmplxmp(5.000000  , tophase(3.141593 ));
    ti1[5] = cmplxmp(6.347387  , tophase(-2.688567));
    ti1[6] = cmplxmp(6.403124  , tophase(-2.245537));
    ti1[7] = cmplxmp(13.480010 , tophase(-1.894905));

    Vector#(8, ComplexMP#(16, 16, 16)) to1 = newVector;
    to1[0] = cmplxmp(273.000000, tophase(0.000000 ));
    to1[1] = cmplxmp(0.000000  , tophase(0.000000 ));
    to1[2] = cmplxmp(13.480010 , tophase(-2.493376));
    to1[3] = cmplxmp(0.000000  , tophase(0.000000 ));
    to1[4] = cmplxmp(6.403124  , tophase(-1.792111));
    to1[5] = cmplxmp(0.000000  , tophase(0.000000 ));
    to1[6] = cmplxmp(6.347387  , tophase(-0.906051));
    to1[7] = cmplxmp(0.000000  , tophase(0.000000 ));

    Vector#(8, ComplexMP#(16, 16, 16)) ti2 = newVector;
    ti2[0] = cmplxmp(168.000000, tophase(0.000000 ));
    ti2[1] = cmplxmp(19.235570 , tophase(2.099765 ));
    ti2[2] = cmplxmp(13.038405 , tophase(2.574863 ));
    ti2[3] = cmplxmp(9.486457  , tophase(2.634546 ));
    ti2[4] = cmplxmp(6.000000  , tophase(3.141593 ));
    ti2[5] = cmplxmp(9.486457  , tophase(-2.634546));
    ti2[6] = cmplxmp(13.038405 , tophase(-2.574863));
    ti2[7] = cmplxmp(19.235570 , tophase(-2.099765));

    Vector#(8, ComplexMP#(16, 16, 16)) to2 = newVector;
    to2[0] = cmplxmp(168.000000, tophase(0.000000 ));
    to2[1] = cmplxmp(0.000000  , tophase(0.000000 ));
    to2[2] = cmplxmp(19.235570 , tophase(-2.083655));
    to2[3] = cmplxmp(0.000000  , tophase(0.000000 ));
    to2[4] = cmplxmp(13.038405 , tophase(-1.133458));
    to2[5] = cmplxmp(0.000000  , tophase(0.000000 ));
    to2[6] = cmplxmp(9.486457  , tophase(-1.014094));
    to2[7] = cmplxmp(0.000000  , tophase(0.000000 ));

    Vector#(8, ComplexMP#(16, 16, 16)) ti3 = newVector;
    ti3[0] = cmplxmp(45.000000, tophase(0.000000 ));
    ti3[1] = cmplxmp(14.628566, tophase(1.847761 ));
    ti3[2] = cmplxmp(8.544004 , tophase(1.929567 ));
    ti3[3] = cmplxmp(4.000631 , tophase(3.123828 ));
    ti3[4] = cmplxmp(7.000000 , tophase(3.141593 ));
    ti3[5] = cmplxmp(4.000631 , tophase(-3.123828));
    ti3[6] = cmplxmp(8.544004 , tophase(-1.929567));
    ti3[7] = cmplxmp(14.628566, tophase(-1.847761));

    Vector#(8, ComplexMP#(16, 16, 16)) to3 = newVector;
    to3[0] = cmplxmp(45.000000, tophase(0.000000 ));
    to3[1] = cmplxmp(0.000000 , tophase(0.000000 ));
    to3[2] = cmplxmp(14.628566, tophase(-2.587663));
    to3[3] = cmplxmp(0.000000 , tophase(0.000000 ));
    to3[4] = cmplxmp(8.544004 , tophase(-2.424051));
    to3[5] = cmplxmp(0.000000 , tophase(0.000000 ));
    to3[6] = cmplxmp(4.000631 , tophase(-0.035530));
    to3[7] = cmplxmp(0.000000 , tophase(0.000000 ));

    rule f0 (feed == 0 && setFactor == True); dofeed(ti1); endrule
    rule f1 (feed == 1 && setFactor == True); dofeed(ti2); endrule
    rule f2 (feed == 2 && setFactor == True); dofeed(ti3); endrule
    
    rule c0 (check == 0 && setFactor == True); docheck(to1); endrule
    rule c1 (check == 1 && setFactor == True); docheck(to2); endrule
    rule c2 (check == 2 && setFactor == True); docheck(to3); endrule

    rule finish (feed == 3 && check == 3);
        if (passed) begin
            $display("PASSED");
        end else begin
            $display("FAILED");
        end
        $finish();
    endrule

endmodule


