module c1 (output wire out, input wire a, b, input wire [1:0] S);
    wire and1, or1, xor1, inv1;
    assign and1 = a & b;
    assign or1 = a | b;
    assign xor1 = a ^ b;
    assign inv1 = ~| a;
    mux4_1 mux4_1(out, and1, or1, xor1, inv1, S);
endmodule