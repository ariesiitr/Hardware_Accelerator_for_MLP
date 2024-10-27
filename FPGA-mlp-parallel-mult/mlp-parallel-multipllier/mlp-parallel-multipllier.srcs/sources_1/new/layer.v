//module description of single layer
module layer #(parameter
dataWidth=16, num_neuron=30, num_neuron_prev_layer=30, layer_no=1
)(
input [dataWidth-1:0] Input_Wire[num_neuron_prev_layer-1:0],
output [dataWidth-1:0] Output_Wire [num_neuron-1:0]
);

// Generate multiple neurons
generate
    genvar n;
    for (n = 0; n < num_neuron; n++) begin : neuron_array
        // Create weight and bias file names based on layer_no and neuron_no
        localparam weight_file = $sformatf("w_%0d_%0d.mif", layer_no, n);
        localparam bias_file = $sformatf("b_%0d_%0d.mif", layer_no, n);
        
        // Instantiate each neuron
        neuron #(
            .dataWidth(dataWidth),
            .intermidiate_mul_dataWidth(dataWidth),
            .intermidiate_add_dataWidth(dataWidth),
            .sigmoid_width(10),                    // Using default value of 10 for sigmoid width
            .num_neuron_prev_layer(num_neuron_prev_layer),
            .mem_file(weight_file),               // Weight file specific to this neuron
            .bias_file(bias_file)                 // Bias file specific to this neuron
        ) neuron_inst (
            .Input_Wire(Input_Wire),              // All neurons share the same input
            .Output_Wire(Output_Wire[n])          // Each neuron's output goes to corresponding Output_Wire element
        );
    end
endgenerate

endmodule