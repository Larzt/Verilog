module memprog(input [9:0] addr, output reg [15:0] data);

    // Memoria de programa
    reg [15:0] rom [0:1023];

    initial begin
        // Cargar el contenido desde un archivo (progfile.dat)
        $readmemh("progfile.dat", rom);
    end

    always @(*) begin
        data = rom[addr]; // Leer la instrucción en la dirección `addr`
    end

endmodule