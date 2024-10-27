// this is a cover over nn module
//this takes single bit input serially
//has a clk
//serial in parallel out register at start
module nn_main #(
    parameter dataWidth = 16,
    parameter numOfInputs = 784,
    parameter wait_time = 100  // Adjustable wait time parameter
)(
    input data,
    input clk,
    output reg [3:0] output_Digit
);

// Shift register to hold serial-to-parallel converted input for the nn module
logic [dataWidth-1:0] shift_register [numOfInputs-1:0];
integer bit_counter = 0;  // Bit counter to manage data input in serial form
integer sample_counter = 0;  // To count dataWidth bits and shift them as one element

// Ready signal to indicate when all inputs are accumulated
logic ready_to_process;
assign ready_to_process = (bit_counter == numOfInputs * dataWidth);

// Wait counter for processing delay
integer wait_counter = 0;
logic processing_done;  // Indicates when processing is complete

// Instantiate the nn module
nn #(
    .dataWidth(dataWidth),
    .numOfInputs(numOfInputs)
) nn_inst (
    .Input_to_nn(shift_register),
    .output_Digit(output_Digit)
);

// Serial data input and shift register handling
always_ff @(posedge clk) begin
    if (!ready_to_process) begin
        // Fill the shift register with data serially
        shift_register[bit_counter / dataWidth][bit_counter % dataWidth] <= data;
        bit_counter <= bit_counter + 1;
    end else if (!processing_done && wait_counter == 0) begin
        // Processing starts once data is ready and wait time is fulfilled
        processing_done <= 1;
        wait_counter <= wait_time;
    end else if (wait_counter > 0) begin
        // Delay to wait for processing completion
        wait_counter <= wait_counter - 1;
    end else if (processing_done) begin
        // Reset everything after processing completes
        bit_counter <= 0;
        processing_done <= 0;
    end
end

endmodule
