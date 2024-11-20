module microc(output wire [5:0] Opcode, output wire z, input wire clk, reset, s_inc, s_inm, we3, wez, input wire [2:0] Op);
//Microcontrolador sin memoria de datos de un solo ciclo
 // Señales internas
    wire [9:0] pc_in, pc_out, sum_out;                  // Señales para el PC
    wire [15:0] instr;                                  // Instrucción desde la memoria
    wire [7:0] rd1, rd2, alu_out, imm, wd3, mux2_out;   // Datos intermedios
    wire z_next;                                        // Próximo valor del flag `z`
    wire [3:0] mux1_out;                                // Datos intermedios

    // Instancia del Contador de Programa (PC)
    registro #(10) pc (pc_out, clk, reset, pc_in); // Salida `pc_out`, Entrada `pc_in`

    // Sumador simple
    sum sumador(sum_out, pc_out, 1);

    // Multiplexor PC
    mux2 #(10) mux_pc (pc_in, sum_out, instr[9:0], s_inc); 

    // Instancia de la Memoria de Programa
    memprog mem (pc_out, clk, instr); // Dirección `pc_out`, Salida `instr`

    // Instancia del Banco de Registros
    regfile banco_registros (
        rd1, rd2,       // Salidas `rd1` y `rd2`
        clk, we3,       // Señales de reloj y escritura
        instr[11:8],    // Dirección de lectura 1 (RA1)
        mux1_out,       // Dirección de lectura 2 (RA2)
        instr[3:0],     // Dirección de escritura (WA3)
        wd3             // Datos de entrada para escritura
    );

    // Instancia de la ALU
    alu alu_inst (
        wd3, z_next, // Resultado y flag `z`
        mux2_1, rd2,        // Operandos `rd1` y `rd2`
        Op               // Operación
    );

    // Instancia del Flip-Flop del Flag de Cero
    ffd zero_flag (z, z_next, clk, wez, reset); // Salida `z`, Entrada `z_next`

    // Instancia del Multiplexor para el Banco de Registros
    mux2 #(4) mux_bc (
        mux1_out,         // Salida del mux
       instr[7:4],    // Entrada 0: RA2
        instr[3:0],    // Entrada 1: WA3
        s_inm          // Señal de selección
    );

    // Instancia del Multiplexor para la Entrada de la ALU
    mux2 #(8) mux_alu (
        mux2_out,         // Salida del mux
        instr[11:8],      // Entrada 0: RA1
        instr[11:4],      // Entrada 1: Valor inmediato
        s_inm             // Señal de selección
    );

    // Extraer el Opcode de la instrucción
    assign Opcode = instr[15:10];

endmodule
