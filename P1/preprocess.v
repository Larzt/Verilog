module preprocess(output wire [3:0] AMod, output wire [3:0] BMod, input wire [3:0] A, input wire [3:0] B, input wire [2:0] Op);
  wire add1, op1_A, op2_B, cpl;  // Se definen todas las señales locales
  wire [3:0] m1_to_m2;
  wire [3:0] m3_to_c1;

  mux2_4 m1(m1_to_m2, 4'b0, 4'b1, add1);
  mux2_4 m2(AMod, m1_to_m2, A, op1_A);
  mux2_4 m3(m3_to_c1, A, B, op2_B);
  compl1 c1(BMod, m3_to_c1, cpl);

// Modelo 1
  assign add1 = Op[0];
  assign op1_A = (Op[1] & ~Op[0]) | Op[2];
  assign op2_B = (Op[1] & ~Op[0]) | Op[2];
  assign cpl = (~Op[2] & ~Op[1] & Op[0]);
endmodule
