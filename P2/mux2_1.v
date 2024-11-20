module mux2_1 #(parameter WIDTH = 8)(
    output wire [WIDTH-1:0] y, // Salida
    input [WIDTH-1:0] a, b,    // Entradas
    input sel                  // Señal de selección
);

    assign y = sel ? b : a;

endmodule
