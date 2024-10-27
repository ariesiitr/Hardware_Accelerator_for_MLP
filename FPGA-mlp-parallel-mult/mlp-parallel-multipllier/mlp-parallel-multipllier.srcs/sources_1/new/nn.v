//module description of neural network
//784 inputs to first layer
//30 neurons in Layer1
//30 neurons in Layer2
//10 neurons in Layer3
//10 neurons in Layer4
//each final output neuron represent probability of the corresponding digit. like nth neuron in layer4 represents the digit in the mnist was n.
//our final output would be neuron with highest probability
module nn #(parameter dataWidth=16, numOfInputs=784)(
input [dataWidth-1:0] Input_to_nn [numOfInputs-1:0],
output [3:0] output_Digit 
);

// Intermediate wires to connect layers
logic [dataWidth-1:0] layer1_to_layer2 [29:0];  // 30 outputs from Layer1
logic [dataWidth-1:0] layer2_to_layer3 [29:0];  // 30 outputs from Layer2
logic [dataWidth-1:0] layer3_to_layer4 [9:0];   // 10 outputs from Layer3
logic [dataWidth-1:0] layer4_output [9:0];      // 10 final outputs (probabilities)

// Layer 1: 784 inputs -> 30 neurons
layer #(
    .dataWidth(dataWidth),
    .num_neuron(30),
    .num_neuron_prev_layer(numOfInputs),
    .layer_no(1)
) layer1_inst (
    .Input_Wire(Input_to_nn),
    .Output_Wire(layer1_to_layer2)
);

// Layer 2: 30 inputs -> 30 neurons
layer #(
    .dataWidth(dataWidth),
    .num_neuron(30),
    .num_neuron_prev_layer(30),
    .layer_no(2)
) layer2_inst (
    .Input_Wire(layer1_to_layer2),
    .Output_Wire(layer2_to_layer3)
);

// Layer 3: 30 inputs -> 10 neurons
layer #(
    .dataWidth(dataWidth),
    .num_neuron(10),
    .num_neuron_prev_layer(30),
    .layer_no(3)
) layer3_inst (
    .Input_Wire(layer2_to_layer3),
    .Output_Wire(layer3_to_layer4)
);

// Layer 4: 10 inputs -> 10 neurons
layer #(
    .dataWidth(dataWidth),
    .num_neuron(10),
    .num_neuron_prev_layer(10),
    .layer_no(4)
) layer4_inst (
    .Input_Wire(layer3_to_layer4),
    .Output_Wire(layer4_output)
);

// Logic to find the neuron with highest probability
logic [3:0] max_index;
logic [dataWidth-1:0] max_value;

always_comb begin
    // Initialize with first value
    max_value = layer4_output[0];
    max_index = 4'd0;
    
    // Compare with remaining values
    for(int i = 1; i < 10; i++) begin
        if($signed(layer4_output[i]) > $signed(max_value)) begin
            max_value = layer4_output[i];
            max_index = i[3:0];
        end
    end
end

// Assign the index of maximum probability to output
assign output_Digit = max_index;

endmodule