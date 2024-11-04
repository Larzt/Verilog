module tb_preprocess;
  // Declaración de señales
  reg [3:0] A, B;
  reg [2:0] Op;
  wire [3:0] AMod, BMod;

  // Variables para valores esperados
  reg [3:0] expected_AMod, expected_BMod;

  // Instanciamos el módulo preprocess
  preprocess uut (
    .AMod(AMod),
    .BMod(BMod),
    .A(A),
    .B(B),
    .Op(Op)
  );

  // Tarea para verificar el resultado
  task check_output;
    input [3:0] expected_AMod, expected_BMod;
    begin
      // Comparar el resultado con el valor esperado
      if (AMod === expected_AMod && BMod === expected_BMod) begin
        $display("Time: %0d | Op=%b | AMod=%b (Expected: %b) | BMod=%b (Expected: %b) | Ok", 
                 $time, Op, AMod, expected_AMod, BMod, expected_BMod);
      end else begin
        $display("Time: %0d | Op=%b | AMod=%b (Expected: %b) | BMod=%b (Expected: %b) | Error", 
                 $time, Op, AMod, expected_AMod, BMod, expected_BMod);
      end
    end
  endtask

  // Bloque inicial para pruebas
  initial begin
    // Prueba 1: A (Op = 000) -> AMod = 0, BMod = A
    A = 4'b1010; B = 4'b0111; Op = 3'b000;
    expected_AMod = 4'b0000; expected_BMod = A;
    #10; check_output(expected_AMod, expected_BMod);

    // Prueba 2: -A (Op = 001) -> AMod = 0, BMod = complemento a 1 de A
    A = 4'b1010; B = 4'b0111; Op = 3'b001;
    expected_AMod = 4'b0000; expected_BMod = ~A;
    #10; check_output(expected_AMod, expected_BMod);

    // Prueba 3: A + B (Op = 010) -> AMod = A, BMod = B
    A = 4'b1010; B = 4'b0111; Op = 3'b010;
    expected_AMod = A; expected_BMod = B;
    #10; check_output(expected_AMod, expected_BMod);

    // Prueba 4: A + 1 (Op = 011) -> AMod = A, BMod = 1
    A = 4'b1010; B = 4'b0111; Op = 3'b011;
    expected_AMod = A; expected_BMod = 4'b0001;
    #10; check_output(expected_AMod, expected_BMod);

    // Prueba 5: A & B (Op = 100) -> AMod = A, BMod = B
    A = 4'b1010; B = 4'b0111; Op = 3'b100;
    expected_AMod = A; expected_BMod = B;
    #10; check_output(expected_AMod, expected_BMod);

    // Prueba 6: A | B (Op = 101) -> AMod = A, BMod = B
    A = 4'b1010; B = 4'b0111; Op = 3'b101;
    expected_AMod = A; expected_BMod = B;
    #10; check_output(expected_AMod, expected_BMod);

    // Prueba 7: A ^ B (Op = 110) -> AMod = A, BMod = B
    A = 4'b1010; B = 4'b0111; Op = 3'b110;
    expected_AMod = A; expected_BMod = B;
    #10; check_output(expected_AMod, expected_BMod);

    // Prueba 8: ~A (Op = 111) -> AMod = A, BMod = complemento a 1 de A
    A = 4'b1010; B = 4'b0111; Op = 3'b111;
    expected_AMod = A; expected_BMod = ~A;
    #10; check_output(expected_AMod, expected_BMod);

    // Finalizamos la simulación
    $finish;
  end
endmodule
