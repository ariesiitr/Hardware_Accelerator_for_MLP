module sigmoid_mem #(
    parameter output_dataWidth = 10,  // output from adder is taken as input
    parameter dataWidth = 16          // width of the output
) (
    input  logic [output_dataWidth-1:0] x,
    output logic [dataWidth-1:0] out
);
    // Memory declaration
    logic [dataWidth-1:0] mem[2**(output_dataWidth)-1:0];
    logic [output_dataWidth-1:0] y;

    // Initialize memory
    initial begin
        $readmemb("sigContent.mif", mem);
    end

    // Combinational logic for address calculation
    always_comb begin
        if ($signed(x) >= 0) begin
            y = x + (2**(output_dataWidth-1));
        end else begin
            y = x - (2**(output_dataWidth-1));
        end
    end
    
    // Combinational read from memory
    assign out = mem[y];

endmodule