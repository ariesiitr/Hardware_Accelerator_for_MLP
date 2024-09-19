module Layer_1 #(parameter NN=30, numWeight=784, dataWidth=16, layerNum=1, sigmoidSize=10, weightIntWidth=4)
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
            // Manually assign file names for each neuron
            .weightFile((i == 0) ? "w_1_0.mif" :
                        (i == 1) ? "w_1_1.mif" :
                        (i == 2) ? "w_1_2.mif" :
                        (i == 3) ? "w_1_3.mif" :
                        (i == 4) ? "w_1_4.mif" :
                        (i == 5) ? "w_1_5.mif" :
                        (i == 6) ? "w_1_6.mif" :
                        (i == 7) ? "w_1_7.mif" :
                        (i == 8) ? "w_1_8.mif" :
                        (i == 9) ? "w_1_9.mif" :
                        (i == 10) ? "w_1_10.mif" :
                        (i == 11) ? "w_1_11.mif" :
                        (i == 12) ? "w_1_12.mif" :
                        (i == 13) ? "w_1_13.mif" :
                        (i == 14) ? "w_1_14.mif" :
                        (i == 15) ? "w_1_15.mif" :
                        (i == 16) ? "w_1_16.mif" :
                        (i == 17) ? "w_1_17.mif" :
                        (i == 18) ? "w_1_18.mif" :
                        (i == 19) ? "w_1_19.mif" :
                        (i == 20) ? "w_1_20.mif" :
                        (i == 21) ? "w_1_21.mif" :
                        (i == 22) ? "w_1_22.mif" :
                        (i == 23) ? "w_1_23.mif" :
                        (i == 24) ? "w_1_24.mif" :
                        (i == 25) ? "w_1_25.mif" :
                        (i == 26) ? "w_1_26.mif" :
                        (i == 27) ? "w_1_27.mif" :
                        (i == 28) ? "w_1_28.mif" :
                        (i == 29) ? "w_1_29.mif" :
                        "w_1_default.mif"), // Default case

            .biasFile((i == 0) ? "b_1_0.mif" :
                      (i == 1) ? "b_1_1.mif" :
                      (i == 2) ? "b_1_2.mif" :
                      (i == 3) ? "b_1_3.mif" :
                      (i == 4) ? "b_1_4.mif" :
                      (i == 5) ? "b_1_5.mif" :
                      (i == 6) ? "b_1_6.mif" :
                      (i == 7) ? "b_1_7.mif" :
                      (i == 8) ? "b_1_8.mif" :
                      (i == 9) ? "b_1_9.mif" :
                      (i == 10) ? "b_1_10.mif" :
                      (i == 11) ? "b_1_11.mif" :
                      (i == 12) ? "b_1_12.mif" :
                      (i == 13) ? "b_1_13.mif" :
                      (i == 14) ? "b_1_14.mif" :
                      (i == 15) ? "b_1_15.mif" :
                      (i == 16) ? "b_1_16.mif" :
                      (i == 17) ? "b_1_17.mif" :
                      (i == 18) ? "b_1_18.mif" :
                      (i == 19) ? "b_1_19.mif" :
                      (i == 20) ? "b_1_20.mif" :
                      (i == 21) ? "b_1_21.mif" :
                      (i == 22) ? "b_1_22.mif" :
                      (i == 23) ? "b_1_23.mif" :
                      (i == 24) ? "b_1_24.mif" :
                      (i == 25) ? "b_1_25.mif" :
                      (i == 26) ? "b_1_26.mif" :
                      (i == 27) ? "b_1_27.mif" :
                      (i == 28) ? "b_1_28.mif" :
                      (i == 29) ? "b_1_29.mif" :
                      "b_1_default.mif") // Default case
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
