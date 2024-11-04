module alu(output wire [3:0] R, output wire zero, carry, sign, input wire [3:0] A, input wire [3:0] B, input wire c_in, input wire [2:0] Op);
  wire [3:0] AMod, BMod, out_sum, out_ul;
  wire c_out;
  
  preprocess pp(AMod, BMod, A, B, Op);

  sum4 sum(out_sum, c_out, AMod, BMod, c_in);
  ul4 ul(out_ul, AMod, BMod, Op[1:0]);
  
  mux2_4 m1(R, out_sum, out_ul, Op[2]);

  assign zero = (R == 1'b0) ? 1'b1 : 1'b0;
  assign sign = R[3];
  assign carry = c_out;
endmodule


