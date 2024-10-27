module cla #(parameter dataWidth = 4) (
    input [dataWidth-1:0] A, B,    // Two dataWidth-bit input numbers
    input Cin,                     // Carry input
    output [dataWidth:0] Sum       // (dataWidth + 1)-bit Sum output
);
    wire [dataWidth-1:0] P, G;     // Propagate and Generate signals
    wire [dataWidth:0] C;          // Carry signals

    // Step 1: Generate propagate (P) and generate (G) signals
    assign P = A ^ B;   // Propagate: P = A ⊕ B
    assign G = A & B;   // Generate: G = A & B

    // Step 2: Carry look-ahead logic
    assign C[0] = Cin;  // Initial carry is Cin
    genvar i;
    generate
        for (i = 0; i < dataWidth; i = i + 1) begin
            assign C[i+1] = G[i] | (P[i] & C[i]); // Carry out for each stage
        end
    endgenerate

    // Step 3: Compute sum and final carry-out
    assign Sum[dataWidth-1:0] = P ^ C[dataWidth-1:0]; // Sum: S = P ⊕ C
    assign Sum[dataWidth] = C[dataWidth];             // Final carry-out as the MSB of Sum

endmodule
