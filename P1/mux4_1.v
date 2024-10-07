module mux4_1 (output reg out, input wire a, b, c, d, input wire [1:0] S);
    always @(S or a or b or c or d) begin
        case (S)
            'b00: out = a;
            'b01: out = b;
            'b10: out = c;
            'b11: out = d;
        endcase
    end
endmodule