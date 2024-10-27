//adder ckt to add n-inputs (datawidth - width of inputs) efficiently
module Adder #(
    parameter n = 5,                    // Number of inputs (n can be odd or even)
    parameter input_dataWidth = 16,     // Width of each input
    parameter output_dataWidth = 16     // Width of the final output
) (
    input  wire [input_dataWidth-1:0] in [n-1:0],  // n inputs of input_dataWidth bits
    output logic [output_dataWidth-1:0] out        // Output of output_dataWidth bits
);

    // Internal logic to hold the sum during each stage
    logic [(input_dataWidth+1)*n-1:0] sum_tree [0:n-1];  // Wider enough to accommodate all stages

    int current_level_size;   // To track the number of data lines at each level
    int next_level_size;
    int dynamic_width;        // To track the required width at each stage

    // Combinational logic to sum the inputs using a tree structure
    always_comb begin
        // Initialize the first level with the input values
        for (int i = 0; i < n; i++) begin
            sum_tree[i] = in[i];
        end

        // Set the initial number of inputs in the first level
        current_level_size = n;
        dynamic_width = input_dataWidth;  // Start with input data width

        // Create a tree structure to add the inputs
        while (current_level_size > 1) begin
            next_level_size = (current_level_size + 1) / 2;  // Half the inputs at the next level
            dynamic_width = dynamic_width + 1;  // Increase width by 1 bit for each stage of addition

            for (int i = 0; i < next_level_size; i++) begin
                if (2 * i + 1 < current_level_size) begin
                    // Add pairs of inputs using the minimal width at each stage
                    CLA_Adder #(
                        .input_width(dynamic_width),
                        .output_width(dynamic_width + 1)  // One extra bit for carry-out
                    ) cla_adder (
                        .a(sum_tree[2 * i][dynamic_width-1:0]),      // First operand
                        .b(sum_tree[2 * i + 1][dynamic_width-1:0]),  // Second operand
                        .cin(1'b0),                                  // Carry-in is 0
                        .sum(sum_tree[i])                            // Sum result
                    );
                end else begin
                    // If odd number of inputs, propagate the last input unchanged
                    sum_tree[i] = sum_tree[2 * i];
                end
            end
            current_level_size = next_level_size;
        end

        // The final sum is in sum_tree[0]
        if (sum_tree[0] > {1'b0, {output_dataWidth{1'b1}}}) begin
            // Overflow: set output to maximum value
            out = {output_dataWidth{1'b1}};
        end else begin
            // No overflow: assign the final sum to the output
            out = sum_tree[0][output_dataWidth-1:0];
        end
    end

endmodule
endmodule
endmodule
endmodule
endmodule
endmodule
endmodule
endmodule
endmodule
endmodule
