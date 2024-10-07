//Sumador completo (full-adder) de tres entradas de 1 bit realizado a partir de puertas logicas 
module fa(output wire sum, output wire c_out, input wire a, input wire b, input wire c_in);
    wire sum1, carry1;
    wire carry2;
    ha1 ha1(sum1, carry1, a, b);
    ha1 ha2(sum, carry2, c_in, sum1);
    assign c_out = carry2 ^ carry1;
endmodule