// Adder circuit to add n inputs (datawidth - width of inputs) efficiently
module Adder #(
    parameter int n = 5,                    // Number of inputs (n can be odd or even)
    parameter int input_dataWidth = 16,     // Width of each input
    parameter int output_dataWidth = 17,    // Width of the final output
    parameter int bias_width = 8             // Width of the bias input
) (
    input  logic [input_dataWidth-1:0] in [n],   // n inputs of input_dataWidth bits
    input  logic [bias_width-1:0] bias,           // Bias input
    output logic [output_dataWidth-1:0] out       // Output of output_dataWidth bits
);

    logic [output_dataWidth-1:0] sum;           // Accumulator for the sum
    logic [output_dataWidth:0] temp_sum;         // Temporary sum to check overflow
    logic [output_dataWidth-1:0] max_value;      // Maximum value for output_dataWidth bits
    logic signed [input_dataWidth-1:0] signed_in [n];  // Signed inputs

    // Calculate the maximum value for output_dataWidth bits (for positive overflow)
    assign max_value = {output_dataWidth{1'b1}};  // max_value = 2^output_dataWidth - 1

    // Initial sum is 0
    initial begin
        sum = 0;
    end

    // Convert inputs to signed for correct addition
    always_comb begin
        for (int i = 0; i < n; i++) begin
            signed_in[i] = in[i];  // Assign input to signed array
        end
    end

    // Sequential addition of inputs and bias
    always_comb begin
        temp_sum = 0;
        
        // Adding inputs
        for (int i = 0; i < n; i++) begin
            temp_sum = temp_sum + signed_in[i];  // Add signed inputs
            
            // Overflow detection
            if (temp_sum[output_dataWidth] ^ temp_sum[output_dataWidth-1]) begin
                // Detect overflow: check sign of temp_sum with MSB of sum
                if (temp_sum[output_dataWidth-1] == 1'b0 && signed_in[i][input_dataWidth-1] == 1'b0) begin
                    // Positive overflow
                    temp_sum = max_value;
                end else if (temp_sum[output_dataWidth-1] == 1'b1 && signed_in[i][input_dataWidth-1] == 1'b1) begin
                    // Negative overflow
                    temp_sum = max_value;  // Or handle accordingly based on desired behavior
                end
            end
        end

        // Adding bias
        temp_sum = temp_sum + {{(output_dataWidth-bias_width){1'b0}}, bias}; // Extend bias to output_dataWidth
        
        // Check for overflow after adding bias
        if (temp_sum[output_dataWidth] ^ temp_sum[output_dataWidth-1]) begin
            // Detect overflow: check sign of temp_sum with MSB of sum after bias addition
            if (temp_sum[output_dataWidth-1] == 1'b0 && bias[bias_width-1] == 1'b0) begin
                // Positive overflow
                temp_sum = max_value;
            end else if (temp_sum[output_dataWidth-1] == 1'b1 && bias[bias_width-1] == 1'b1) begin
                // Negative overflow
                temp_sum = max_value;  // Or handle accordingly based on desired behavior
            end
        end

        sum = temp_sum[output_dataWidth-1:0];  // Final sum truncated to output_dataWidth
    end

    // Assign the final result to the output
    assign out = sum;

endmodule



