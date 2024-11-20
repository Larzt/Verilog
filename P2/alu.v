module alu(
    output reg [7:0] res, // Resultado de la operación
    output reg z,         // Flag de cero
    input [7:0] a, b,     // Operandos
    input [2:0] op        // Código de operación
);

    always @(*) begin
        case (op)
            3'b000: res = a + b;  // Suma
            3'b001: res = a - b;  // Resta
            3'b010: res = a & b;  // AND
            3'b011: res = a | b;  // OR
            3'b100: res = a ^ b;  // XOR
            3'b101: res = ~a;     // NOT
            default: res = 8'b0;  // Operación no válida
        endcase

        // Actualizar el flag de cero
        z = (res == 8'b0);
    end

endmodule
