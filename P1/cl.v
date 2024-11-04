module cl(output wire out, input wire a, b, input wire [1:0] S);
    assign out = (S == 2'b00) ? (a & b) : // AND
                 (S == 2'b01) ? (a | b) : // OR
                 (S == 2'b10) ? (a ^ b) : // XOR
                 ~a;                     // NOT
endmodule
