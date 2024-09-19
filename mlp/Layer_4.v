module Layer_4 #(parameter NN=10, numWeight=10, dataWidth=16, layerNum=4, sigmoidSize=10, weightIntWidth=4)
(
    input clk,
    input rst,
    input [31:0] weightValue,
    input [31:0] biasValue,
    input [31:0] config_layer_num,
    input [31:0] config_neuron_num,
    input x_valid,
    output [NN-1:0] o_valid,
    input [dataWidth-1:0] x_in,
    output [NN*dataWidth-1:0] x_out
);

genvar i;
generate
    for (i = 0; i < NN; i = i + 1) begin : neuron_gen
        neuron #(
            .layerNo(layerNum),
            .neuronNo(i),
            .numWeight(numWeight),
            .dataWidth(dataWidth),
            .sigmoidSize(sigmoidSize),
            .weightIntWidth(weightIntWidth),
            .weightFile((i == 0) ? "w_4_0.mif" :
                        (i == 1) ? "w_4_1.mif" :
                        (i == 2) ? "w_4_2.mif" :
                        (i == 3) ? "w_4_3.mif" :
                        (i == 4) ? "w_4_4.mif" :
                        (i == 5) ? "w_4_5.mif" :
                        (i == 6) ? "w_4_6.mif" :
                        (i == 7) ? "w_4_7.mif" :
                        (i == 8) ? "w_4_8.mif" :
                        (i == 9) ? "w_4_9.mif" :
                        "w_4_default.mif"),

            .biasFile((i == 0) ? "b_4_0.mif" :
                      (i == 1) ? "b_4_1.mif" :
                      (i == 2) ? "b_4_2.mif" :
                      (i == 3) ? "b_4_3.mif" :
                      (i == 4) ? "b_4_4.mif" :
                      (i == 5) ? "b_4_5.mif" :
                      (i == 6) ? "b_4_6.mif" :
                      (i == 7) ? "b_4_7.mif" :
                      (i == 8) ? "b_4_8.mif" :
                      (i == 9) ? "b_4_9.mif" :
                      "b_4_default.mif")
        ) n_i (
            .clk(clk),
            .rst(rst),
            .myinput(x_in),
            .config_layer_num(config_layer_num),
            .config_neuron_num(config_neuron_num),
            .myinputValid(x_valid),
            .out(x_out[i*dataWidth+:dataWidth]),
            .outvalid(o_valid[i])
        );
    end
endgenerate
endmodule
