module regfile(
    output reg [7:0] rd1, rd2, // Salidas de lectura
    input clk, we,            // Señal de escritura habilitada
    input [3:0] ra1, ra2, wa3, // Direcciones de lectura y escritura
    input [7:0] wd3            // Datos de entrada para escritura
);

    reg [7:0] regs [0:15]; // Banco de registros: 16 registros de 8 bits

    // Operaciones de lectura
    always @(*) begin
        rd1 = regs[ra1];
        rd2 = regs[ra2];
    end

    // Operación de escritura
    always @(posedge clk) begin
        if (we) begin
            regs[wa3] <= wd3;
        end
    end

endmodule
