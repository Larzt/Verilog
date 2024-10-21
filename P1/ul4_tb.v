module tb_ul4;
  // Declaración de señales
  reg [3:0] A, B;
  reg [1:0] S;
  wire [3:0] Out;

  // Variable para el valor esperado
  reg [3:0] expected_Out;

  // Instanciamos el módulo ul4
  ul4 uut (
    .Out(Out),
    .A(A),
    .B(B),
    .S(S)
  );

  // Tarea para verificar el resultado
  task check_output;
    input [3:0] expected_Out;
    begin
      // Comparar el resultado con el valor esperado
      if (Out === expected_Out) begin
        $display("Time: %0d | S=%b | Out=%b (Expected: %b) | Ok", 
                 $time, S, Out, expected_Out);
      end else begin
        $display("Time: %0d | S=%b | Out=%b (Expected: %b) | Error", 
                 $time, S, Out, expected_Out);
      end
    end
  endtask

  // Bloque inicial para pruebas
  initial begin
    // Prueba 1: AND (S = 00) -> Out = A & B
    A = 4'b1010; B = 4'b0111; S = 2'b00;
    expected_Out = A & B;
    #10; check_output(expected_Out);

    // Prueba 2: OR (S = 01) -> Out = A | B
    A = 4'b1010; B = 4'b0111; S = 2'b01;
    expected_Out = A | B;
    #10; check_output(expected_Out);

    // Prueba 3: XOR (S = 10) -> Out = A ^ B
    A = 4'b1010; B = 4'b0111; S = 2'b10;
    expected_Out = A ^ B;
    #10; check_output(expected_Out);

    // Prueba 4: NOT A (S = 11) -> Out = ~A
    A = 4'b1010; B = 4'b0111; S = 2'b11;
    expected_Out = ~A;
    #10; check_output(expected_Out);

    // Finalizamos la simulación
    $finish;
  end
endmodule
