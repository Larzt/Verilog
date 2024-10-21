module fa(output wire c_out, output wire sum, input wire a, b, input wire c_in);
    assign sum = a ^ b ^ c_in;
    assign c_out = (a & b) | (c_in & (a ^ b));
endmodule
