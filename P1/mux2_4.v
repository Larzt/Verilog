module mux2_4 (output wire [3:0] out, input wire [3:0] A, input wire [3:0] B, input wire s);
    assign out = s ? B : A;
endmodule