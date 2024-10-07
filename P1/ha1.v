module ha1(output wire sum, output wire carry, input wire a, input wire b);
	xor #1 xor1(sum, a, b);
	and #1 and1(carry, a, b);
endmodule
