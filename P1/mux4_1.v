module mux4_1 (output reg [3:0] out, input wire A, B, C, D, input wire [1:0] s);
    always @(s or A or B or C or D) begin
        case (s)
            'b00: out = A;
            'b01: out = B;
            'b10: out = C;
            'b11: out = D;
        endcase
    end
endmodule