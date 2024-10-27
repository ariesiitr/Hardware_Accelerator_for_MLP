module weight_mem #(
    parameter numWeight = 3,             // Number of weight outputs
    parameter addressWidth = 10,          // Address width (not directly used here)
    parameter weightWidth = 16,           // Width of each weight
    parameter weightFile = "w_1_5.mif" // Memory initialization file
) (
    output logic [weightWidth-1:0] mem [numWeight-1:0] // Memory outputs
);
    // Memory declaration
    reg [weightWidth-1:0] mem_reg [numWeight-1:0]; // Internal memory storage
    // Initial block to read memory from the file
    initial begin
        // Read weights from the memory initialization file
        $readmemb(weightFile, mem_reg);
    end
    // Continuous assignment to connect the internal memory to output ports
    generate
        genvar i;
        for (i = 0; i < numWeight; i++) begin : output_assignment
            assign mem[i] = mem_reg[i]; // Continuous assignment to outputs
        end
    endgenerate
endmodule