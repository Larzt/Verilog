`timescale 1 ns / 10 ps
module microc_tb;

 // Declaración de señales
    reg t_clk, t_reset;
    reg t_s_inc, t_s_inm, t_we, t_wez;
    reg [2:0] t_ALUOp;
    wire [5:0] Opcode;
    wire z;

    // Instancia del módulo microc
    microc uut (
        Opcode,  // Salida del Opcode
        z,       // Flag de cero
        t_clk,     // Señal de reloj
        t_reset,   // Señal de t_reset
        t_s_inc,   // Señal de selección del multiplexor del PC
        t_s_inm,   // Señal de selección del multiplexor del banco de registros
        t_we,     // Habilitación de escritura del banco de registros
        t_wez,     // Habilitación de escritura del flag de cero
        t_ALUOp       // Código de operación para la ALU
    );

    // Generación del reloj
    always
begin
    t_clk = 1;
    #15;
    t_clk = 0;
    #15;
end

// Reseteo y configuración de salidas del testbench
initial
begin
  $dumpfile("microc_tb.vcd");
  $dumpvars;
  // Inicialización
        t_clk = 0;
        t_reset = 1; 
        t_s_inc = 0; 
        t_s_inm = 0; 
        t_we = 0; 
        t_wez = 0; 
        t_ALUOp = 3'b000;

        #10 reset = 0; // Liberar el reset
end

// Bloque simulación señales control por ciclo
initial
begin
   // CICLO 0 JMP START
    #15
    t_wez = 1'b0;
    t_we = 1'b0;
    t_s_inm = 1'b0;
    t_s_inc = 1'b0;
    t_ALUOp = 3'b000;
    #30

    // CICLO 1 LI #0 R1
    t_wez = 1'b0;
    t_we = 1'b1;
    t_s_inm = 1'b1;
    t_s_inc = 1'b1;
    t_ALUOp = 3'b000;
    #30

    // CICLO 2 LI #2 R2
    t_wez = 1'b0;
    t_we = 1'b1;
    t_s_inm = 1'b1;
    t_s_inc = 1'b1;
    t_ALUOp = 3'b000;
    #30

    // CICLO 3 LI #3 R3
    t_wez = 1'b0;
    t_we = 1'b1;
    t_s_inm = 1'b1;
    t_s_inc = 1'b1;
    t_ALUOp = 3'b000;
    #30

    // CICLO 4 sub R1 R2 R0 
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b011;
    #30

    // CICLO 5 jnz Fin
    t_wez = 1;
    t_we = 0;
    t_s_inm = 0;
    t_s_inc = z;
    t_ALUOp = 3'b000;
    #30

    // CICLO 6 add R3 R3 R3
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b010;
    #30

    // CICLO 7 addi 1 R1
    t_wez = 1;
    t_we = 1;
    t_s_inm = 1;
    t_s_inc = 1;
    t_ALUOp = 3'b010;
    #30

    // CICLO 8 nop
    //t_wez = 0;
    //t_we = 0;
    //t_s_inm = 0;
    //t_s_inc = 0;
    //t_ALUOp = 3'b000;
    //#30

    // CICLO 9  j Test
    t_wez = 1'b0;
    t_we = 1'b0;
    t_s_inm = 1'b0;
    t_s_inc = 1'b0;
    t_ALUOp = 3'b000;
    #30

    // CICLO 10 sub R1 R2 R0 
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b011;
    #30

    // CICLO 11 jnz Fin
    t_wez = 1;
    t_we = 0;
    t_s_inm = 0;
    t_s_inc = z;
    t_ALUOp = 3'b000;
    #30

    // CICLO 12 add R3 R3 R3
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b010;
    #30

    // CICLO 13 addi 1 R1
    t_wez = 1;
    t_we = 1;
    t_s_inm = 1;
    t_s_inc = 1;
    t_ALUOp = 3'b010;
    #30

    // CICLO 14 nop
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b010;
    #30

    // CICLO 15  j Test
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b100;
    #30

    // CICLO 16 sub R1 R2 R0 
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b011;
    #30

    // CICLO 17 jnz Fin *
    t_wez = 1;
    t_we = 0;
    t_s_inm = 0;
    t_s_inc = ~z;
    t_ALUOp = 3'b000;
    #30

    // CICLO 18 j Fin
    t_wez = 1'b0;
    t_we = 1'b0;
    t_s_inm = 1'b0;
    t_s_inc = 1'b0;
    t_ALUOp = 3'b000;
    #30

    // CICLO 19 j Fin
    t_wez = 1'b0;
    t_we = 1'b0;
    t_s_inm = 1'b0;
    t_s_inc = 1'b0;
    t_ALUOp = 3'b000;
    #30
  $finish;
end

endmodule
