`timescale 1ns / 10ps
module microc_tb;
// declaracion de variables
reg t_wez, t_we, t_s_inc, t_s_inm, t_clk, t_reset;
reg [2:0] t_ALUOp;
wire [5:0] t_Opcode;
wire t_zero;

// instanciacion del camino de datos
microc microc(t_Opcode, t_zero, t_clk, t_reset, t_s_inc, t_s_inm, t_we, t_wez, t_ALUOp);

// generación de reloj clk
always
begin
    t_clk = 1;
    #15;
    t_clk = 0;
    #15;
end

// Reseteo y configuracion de salidas del testbench
initial
begin
    $dumpfile("cpu_tb.vcd");
    $dumpvars;
    // ... señal de reset
    t_reset = 1;
    #5
    t_reset = 0;
end

// bloque de simulacion señales control por ciclo
initial
begin
    // CICLO 0 LI #3 R3
    #15
    t_wez = 1'b0;
    t_we = 1'b1;
    t_s_inm = 1'b1;
    t_s_inc = 1'b1;
    t_ALUOp = 3'b000;
    #30

    // CICLO 1 LI #1 R5
    t_wez = 1'b0;
    t_we = 1'b1;
    t_s_inm = 1'b1;
    t_s_inc = 1'b1;
    t_ALUOp = 3'b000;
    #30

    // CICLO 2 SUB R2 R2 R2
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b011;
    #30

    // CICLO 3 MOV R3 R4 -> ADD R0 R3 R4
    t_wez = 1;
    t_we = 1;
    t_s_inm = 0;
    t_s_inc = 1;
    t_ALUOp = 3'b010;
    #30

    // CICLO 4 AND R4 R5 R4
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