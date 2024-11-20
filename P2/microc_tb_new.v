`timescale 1ns / 1ps

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

    // Número de ciclos especificado por línea de comandos (+n=14)
    integer n;
    integer i;

    initial begin
        // Configuración del volcado de señales para GTKWave
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, microc_tb);

        // Leer número de ciclos desde la línea de comandos
        if (!$value$plusargs("n=%d", n)) begin
            n = 14; // Valor por defecto: 14 ciclos
        end

        // Inicialización
        clk = 0;
        reset = 1; 
        s_inc = 0; 
        s_inm = 0; 
        we3 = 0; 
        wez = 0; 
        Op = 3'b000;

        #10 reset = 0; // Liberar el reset

        // Simulación de ciclos
        for (i = 0; i < n; i = i + 1) begin
            // Generar señales de control para simular instrucciones
            case (i)
                0: begin s_inc = 1; we3 = 0; end // nop
                1: begin s_inm = 1; we3 = 1; end // li
                2: begin s_inc = 0; we3 = 0; end // j
                3: begin Op = 3'b000; s_inm = 0; we3 = 1; wez = 1; end // add
                4: begin Op = 3'b001; s_inm = 0; we3 = 1; wez = 1; end // sub
                5: begin s_inc = 1; we3 = 0; end // jnz
                default: begin s_inc = 1; end // Instrucciones posteriores
            endcase

            #10; // Esperar 10 ns para el siguiente ciclo
        end

        $finish; // Finalizar la simulación
    end

endmodule