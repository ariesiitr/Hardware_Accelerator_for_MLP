//module description of single neuron
module neuron #( parameter
dataWidth=16,
intermidiate_mul_dataWidth=dataWidth,
intermidiate_add_dataWidth=dataWidth,
sigmoid_width=10,
num_neuron_prev_layer=30,
mem_file= "w_1_5.mif",
bias_file= "b_1_14.mif")
(
input [dataWidth-1:0] Input_Wire[num_neuron_prev_layer-1:0],
output [dataWidth-1:0] Output_Wire);

logic [intermidiate_mul_dataWidth-1:0] Intermidiate_Wire_1 [num_neuron_prev_layer-1:0];
logic [intermidiate_add_dataWidth-1:0] Intermidiate_Wire_2;

// Instantiate weight memory
logic [dataWidth-1:0] weights [num_neuron_prev_layer-1:0];
weight_mem #(
    .numWeight(num_neuron_prev_layer),
    .addressWidth(10),
    .weightWidth(dataWidth),
    .weightFile(mem_file)
) weight_mem_inst (
    .mem(weights)
);

// Instantiate bias memory (single bias value)
logic [dataWidth-1:0] bias [0:0];
weight_mem #(
    .numWeight(1),
    .addressWidth(10),
    .weightWidth(dataWidth),
    .weightFile(bias_file)
) bias_mem_inst (
    .mem(bias)
);

//generating parallel multipliers
generate
    genvar i;
    for (i = 0; i < num_neuron_prev_layer; i++) begin : parallel_multiplier
        multiplier #(
            .dataWidth(dataWidth),
            .weightWidth(dataWidth),
            .input_dataWidth(intermidiate_mul_dataWidth)
        ) mult_inst (
            .in1(Input_Wire[i]),
            .in2(weights[i]),
            .out(Intermidiate_Wire_1[i])
        );
    end
endgenerate

// Instantiate Adder to sum all Intermidiate_Wire_1 elements
Adder #(
    .n(num_neuron_prev_layer),
    .input_dataWidth(intermidiate_mul_dataWidth),
    .output_dataWidth(intermidiate_add_dataWidth),
    .bias_width(dataWidth)
) adder_inst (
    .in(Intermidiate_Wire_1),
    .bias(bias[0]),
    .out(Intermidiate_Wire_2)
);

// Instantiate sigmoid memory
// Taking most significant sigmoid_width bits from Intermidiate_Wire_2 as input
sigmoid_mem #(
    .output_dataWidth(sigmoid_width),
    .dataWidth(dataWidth)
) sigmoid_inst (
    .x(Intermidiate_Wire_2[intermidiate_add_dataWidth-1 -: sigmoid_width]),
    .out(Output_Wire)
);

endmodule