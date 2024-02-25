import Multiplexer :: *;

function Bit#(1) fa_sum(Bit#(1) a, Bit#(1) b, Bit#(1) c);
    return a ^ b ^ c;
endfunction

function Bit#(1) fa_carry(Bit#(1) a, Bit#(1) b, Bit#(1) c);
    return (a & b) | (a & c) | (b & c);
endfunction

// Exercise 4

function Bit#(5) add4(Bit#(4) a, Bit#(4) b, Bit#(1) cin);
    Bit#(4) sum;
    Bit#(5) c = 0;
    c[0] = cin;
    for(Integer i = 0; i < 4; i = i + 1) begin
        sum[i] = fa_sum(a[i],b[i],c[i]);
        c[i+1] = fa_carry(a[i],b[i],c[i]);
    end
    return {c[4],sum};
endfunction

interface Adder8;
    method ActionValue#(Bit#(9)) sum(Bit#(8) a,Bit#(8) b,Bit#(1) c_in);
endinterface

module mkRCAdder(Adder8);
    method ActionValue#(Bit#(9)) sum(Bit#(8) a,Bit#(8) b,Bit#(1) c_in);
        Bit#(5) low=add4(a[3:0],b[3:0],c_in);
        Bit#(5) high=add4(a[7:4],b[7:4],low[4]);
        return {high,low[3:0]};
    endmethod
endmodule

// Exercise 5

module mkCSAdder(Adder8);
    method ActionValue#(Bit#(9)) sum(Bit#(8) a,Bit#(8) b,Bit#(1) c_in);
        let low = add4(a[3:0], b[3:0], c_in);
        let low_bits = low[3:0];
        Bool sel = unpack(low[4]);
        let high_high = add4(a[7:4], b[7:4], 1'b1);
        let high_low = add4(a[7:4], b[7:4], 1'b0);
        Bit#(9) out;
        if (sel) begin
            out = {high_high, low_bits};
        end else begin
            out = {high_low, low_bits};
        end
        return out;
    endmethod
endmodule