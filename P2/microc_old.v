module microc(
    output wire [5:0] Opcode,
    output wire z,
    input wire clk, reset,
    input wire s_inc, s_inm, we3, wez,
    input wire [2:0] Op
);

    // Señales internas
    wire [9:0] pc_in, pc_out;               // Señales para el PC
    wire [15:0] instr;                      // Instrucción desde la memoria
    wire [7:0] rd1, rd2, alu_out, imm, wd3; // Datos intermedios
    wire z_next;                            // Próximo valor del flag `z`

    // Instancia del Contador de Programa (PC)
    reg10 pc (pc_out, pc_in, clk, reset); // Salida `pc_out`, Entrada `pc_in`

    // Instancia de la Memoria de Programa
    memprog mem (pc_out, instr); // Dirección `pc_out`, Salida `instr`

    // Instancia del Banco de Registros
    regfile banco_registros (
        rd1, rd2,       // Salidas `rd1` y `rd2`
        clk, we3,       // Señales de reloj y escritura
        instr[11:8],    // Dirección de lectura 1 (RA1)
        instr[7:4],     // Dirección de lectura 2 (RA2)
        instr[3:0],     // Dirección de escritura (WA3)
        wd3             // Datos de entrada para escritura
    );

    // Instancia de la ALU
    alu alu_inst (
        alu_out, z_next, // Resultado y flag `z`
        rd1, rd2,        // Operandos `rd1` y `rd2`
        Op               // Operación
    );

    // Instancia del Flip-Flop del Flag de Cero
    ff zero_flag (z, z_next, clk, wez); // Salida `z`, Entrada `z_next`

    // Instancia del Multiplexor para el PC
    mux2_1 #(10) mux_pc (
        pc_in,         // Salida del mux
        pc_out + 1,    // Entrada 0: PC + 1
        instr[9:0],    // Entrada 1: Dirección de salto
        s_inc          // Señal de selección
    );

    // Instancia del Multiplexor para la Entrada del Banco de Registros
    mux2_1 #(8) mux_wd3 (
        wd3,          // Salida del mux
        alu_out,      // Entrada 0: Salida de la ALU
        instr[11:4],  // Entrada 1: Valor inmediato
        s_inm         // Señal de selección
    );

    // Extraer el Opcode de la instrucción
    assign Opcode = instr[15:10];

endmodule

