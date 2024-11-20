`timescale 1 ns / 10 ps
module microc_tb;

 // Declaración de señales
    reg clk, reset;
    reg s_inc, s_inm, we3, wez;
    reg [2:0] Op;
    wire [5:0] Opcode;
    wire z;

    // Instancia del módulo microc
    microc uut (
        Opcode,  // Salida del Opcode
        z,       // Flag de cero
        clk,     // Señal de reloj
        reset,   // Señal de reset
        s_inc,   // Señal de selección del multiplexor del PC
        s_inm,   // Señal de selección del multiplexor del banco de registros
        we3,     // Habilitación de escritura del banco de registros
        wez,     // Habilitación de escritura del flag de cero
        Op       // Código de operación para la ALU
    );

    // Generación del reloj
    always #5 clk = ~clk; // Período del reloj: 10 ns

// Reseteo y configuración de salidas del testbench
initial
begin
  $dumpfile("microc_tb.vcd");
  $dumpvars;
  // Inicialización
        clk = 0;
        reset = 1; 
        s_inc = 0; 
        s_inm = 0; 
        we3 = 0; 
        wez = 0; 
        Op = 3'b000;

        #10 reset = 0; // Liberar el reset
end

// Bloque simulación señales control por ciclo
initial
begin
   // CICLO 0 JMP START
    #15
    t_wez = 1'b0;
    t_we = 1'b1;
    t_s_inm = 1'b1;
    t_s_inc = 1'b1;
    t_ALUOp = 3'b000;
    #30

    // CICLO 1 LI #0 R1
    t_wez = 1'b0;
    t_we = 1'b1
    t_s_inm = 1'b1;
    t_s_inc = 1'b1;
    t_ALUOp = 3'b000;
    #30

    // CICLO 2 TEST: sub R1 R2 R0
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b011;
    #30

    // CICLO 3 jnz Fin
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b010;
    #30

    // CICLO 4 add R3 R3 R3
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b100;
    #30

    // CICLO 5 SBI #1 R3
    t_wez = 1;
    t_we = 1;
    t_s_inm = 1;
    t_s_inc = 1;
    t_ALUOp = 3'b011;
    #30

    // CICLO 9 J CHECK
    t_wez = 0;
    t_we = 0;
    t_s_inm = 0;
    t_s_inc = 0;
    t_ALUOp = 3'b000;
    #30

    // CICLO 10 MOV R3 R4 -> ADD R0 R3 R4
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b010;
    #30

    // CICLO 11  AND R4 R5 R4
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b100;
    #30

    // CICLO 12 JZ PAR
    t_wez = 0;
    t_we = 0;
    t_s_inm = 0;
    t_s_inc = t_zero;
    t_ALUOp = 3'b000;
    #30

    // CICLO 13 ADI #1 R2
    t_wez = 1;
    t_we = 1;
    t_s_inm = 1;
    t_s_inc = 1;
    t_ALUOp = 3'b010;
    #30

    // CICLO 14 J NEXT
    t_wez = 0;
    t_we = 0;
    t_s_inm = 0;
    t_s_inc = 0;
    t_ALUOp = 3'b000;
    #30
    // CICLO 15 SBI #1 R3
    t_wez = 1;
    t_we = 1;
    t_s_inm = 1;
    t_s_inc = 1;
    t_ALUOp = 3'b011;
    #30

    // CICLO 16 J CHECK
    t_wez = 0;
    t_we = 0;
    t_s_inm = 0;
    t_s_inc = 0;
    t_ALUOp = 3'b000;
    #30

    // CICLO 17 MOV R3 R4 -> ADD R0 R3 R4
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b010;
    #30

    // CICLO 18  AND R4 R5 R4
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b100;
    #30

    // CICLO 19 SBI #1 R3
    t_wez = 1;
    t_we = 1;
    t_s_inm = 1;
    t_s_inc = 1;
    t_ALUOp = 3'b011;
    #30

    // CICLO 20 JZ END
    t_wez = 0;
    t_we = 0;
    t_s_inm = 0;
    t_s_inc = t_zero;
    t_ALUOp = 3'b000;
    #30

    // CICLO 21 J END
    t_wez = 0;
    t_we = 0;
    t_s_inm = 0;
    t_s_inc = 0;
    t_ALUOp = 3'b000;
    #30

    // CICLO 22 J END
    t_wez = 0;
    t_we = 0;
    t_s_inm = 0;
    t_s_inc = 0;
    t_ALUOp = 3'b000;
    #30
  $finish;
end

endmodule
