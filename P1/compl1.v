module compl1 (output wire [3:0] Out, input wire [3:0] Inp, input wire cpl);
    assign cpl = Out ? ~Inp : Inp;    
endmodule