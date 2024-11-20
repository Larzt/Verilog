module reg10(output reg [9:0] q, input [9:0] d, input clk, reset);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 10'b0; // Reinicia el PC a 0
        else
            q <= d; // Carga el nuevo valor del PC
    end

endmodule
