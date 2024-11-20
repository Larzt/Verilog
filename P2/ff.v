module ff(output reg q, input d, clk, we);

    always @(posedge clk) begin
        if (we)
            q <= d; // Actualizar el valor de `z` cuando `we` está habilitado
    end

endmodule
