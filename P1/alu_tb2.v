module tb_alu;
  // Declaración de señales
  reg [3:0] A, B;
  reg [2:0] Op;
  reg c_in;
  wire [3:0] R;
  wire zero, carry, sign;

  // Variable para los valores esperados
  reg [3:0] expected_R;
  reg expected_zero, expected_sign, expected_carry;

  // Instanciamos el módulo alu
  alu uut (
    .R(R),
    .zero(zero),
    .carry(carry),
    .sign(sign),
    .A(A),
    .B(B),
    .c_in(c_in),
    .Op(Op)
  );

  // Tarea para verificar los resultados
  task check_output;
    input [3:0] expected_R;
    input expected_zero, expected_sign, expected_carry;
    begin
      // Comparar el resultado con el valor esperado
      if (R === expected_R && zero === expected_zero && sign === expected_sign && carry === expected_carry) begin
        $display("Time: %0d | Op=%b | R=%b (Expected: %b) | zero=%b (Expected: %b) | sign=%b (Expected: %b) | carry=%b (Expected: %b) | Ok",
                 $time, Op, R, expected_R, zero, expected_zero, sign, expected_sign, carry, expected_carry);
      end else begin
        $display("Time: %0d | Op=%b | R=%b (Expected: %b) | zero=%b (Expected: %b) | sign=%b (Expected: %b) | carry=%b (Expected: %b) | Error",
                 $time, Op, R, expected_R, zero, expected_zero, sign, expected_sign, carry, expected_carry);
      end
    end
  endtask

  // Bloque inicial para las pruebas
  initial begin
    // Prueba 1: A (Op = 000) -> R = A + c_in
    A = 4'b0011; B = 4'b0000; c_in = 1'b0; Op = 3'b000;
    expected_R = A + c_in;
    expected_zero = (expected_R == 4'b0000) ? 1'b1 : 1'b0;
    expected_sign = expected_R[3];
    expected_carry = 1'b0; // No carry esperado
    #10; check_output(expected_R, expected_zero, expected_sign, expected_carry);

    // Prueba 2: -A (Op = 001) -> R = -A + c_in
    A = 4'b0011; B = 4'b0000; c_in = 1'b0; Op = 3'b001;
    expected_R = -A + c_in;
    expected_zero = (expected_R == 4'b0000) ? 1'b1 : 1'b0;
    expected_sign = expected_R[3];
    expected_carry = 1'b0; // No carry esperado
    #10; check_output(expected_R, expected_zero, expected_sign, expected_carry);

    // Prueba 3: A + B (Op = 010) -> R = A + B + c_in
    A = 4'b0011; B = 4'b0001; c_in = 1'b0; Op = 3'b010;
    expected_R = A + B + c_in;
    expected_zero = (expected_R == 4'b0000) ? 1'b1 : 1'b0;
    expected_sign = expected_R[3];
    expected_carry = (A + B + c_in) > 4'b1111; // Carry si hay overflow
    #10; check_output(expected_R, expected_zero, expected_sign, expected_carry);

    // Prueba 4: A + 1 (Op = 011) -> R = A + 1 + c_in
    A = 4'b0011; B = 4'b0000; c_in = 1'b0; Op = 3'b011;
    expected_R = A + 1 + c_in;
    expected_zero = (expected_R == 4'b0000) ? 1'b1 : 1'b0;
    expected_sign = expected_R[3];
    expected_carry = (A + 1 + c_in) > 4'b1111;
    #10; check_output(expected_R, expected_zero, expected_sign, expected_carry);

    // Prueba 5: A & B (Op = 100) -> R = A & B
    A = 4'b1010; B = 4'b0111; c_in = 1'b0; Op = 3'b100;
    expected_R = A & B;
    expected_zero = (expected_R == 4'b0000) ? 1'b1 : 1'b0;
    expected_sign = expected_R[3];
    expected_carry = 1'b0; // No carry en operación lógica
    #10; check_output(expected_R, expected_zero, expected_sign, expected_carry);

    // Prueba 6: A | B (Op = 101) -> R = A | B
    A = 4'b1010; B = 4'b0111; c_in = 1'b0; Op = 3'b101;
    expected_R = A | B;
    expected_zero = (expected_R == 4'b0000) ? 1'b1 : 1'b0;
    expected_sign = expected_R[3];
    expected_carry = 1'b0; // No carry en operación lógica
    #10; check_output(expected_R, expected_zero, expected_sign, expected_carry);

    // Prueba 7: A ^ B (Op = 110) -> R = A ^ B
    A = 4'b1010; B = 4'b0111; c_in = 1'b0; Op = 3'b110;
    expected_R = A ^ B;
    expected_zero = (expected_R == 4'b0000) ? 1'b1 : 1'b0;
    expected_sign = expected_R[3];
    expected_carry = 1'b0; // No carry en operación lógica
    #10; check_output(expected_R, expected_zero, expected_sign, expected_carry);

    // Prueba 8: ~A (Op = 111) -> R = ~A
    A = 4'b1010; B = 4'b0111; c_in = 1'b0; Op = 3'b111;
    expected_R = ~A;
    expected_zero = (expected_R == 4'b0000) ? 1'b1 : 1'b0;
    expected_sign = expected_R[3];
    expected_carry = 1'b0; // No carry en operación lógica
    #10; check_output(expected_R, expected_zero, expected_sign, expected_carry);

    // Finalizamos la simulación
    $finish;
  end
endmodule
