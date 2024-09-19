module Layer_2 #(parameter NN=30, numWeight=784, dataWidth=16, layerNum=2, sigmoidSize=10, weightIntWidth=4)
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
            .weightFile((i == 0) ? "w_2_0.mif" :
                        (i == 1) ? "w_2_1.mif" :
                        (i == 2) ? "w_2_2.mif" :
                        (i == 3) ? "w_2_3.mif" :
                        (i == 4) ? "w_2_4.mif" :
                        (i == 5) ? "w_2_5.mif" :
                        (i == 6) ? "w_2_6.mif" :
                        (i == 7) ? "w_2_7.mif" :
                        (i == 8) ? "w_2_8.mif" :
                        (i == 9) ? "w_2_9.mif" :
                        (i == 10) ? "w_2_10.mif" :
                        (i == 11) ? "w_2_11.mif" :
                        (i == 12) ? "w_2_12.mif" :
                        (i == 13) ? "w_2_13.mif" :
                        (i == 14) ? "w_2_14.mif" :
                        (i == 15) ? "w_2_15.mif" :
                        (i == 16) ? "w_2_16.mif" :
                        (i == 17) ? "w_2_17.mif" :
                        (i == 18) ? "w_2_18.mif" :
                        (i == 19) ? "w_2_19.mif" :
                        (i == 20) ? "w_2_20.mif" :
                        (i == 21) ? "w_2_21.mif" :
                        (i == 22) ? "w_2_22.mif" :
                        (i == 23) ? "w_2_23.mif" :
                        (i == 24) ? "w_2_24.mif" :
                        (i == 25) ? "w_2_25.mif" :
                        (i == 26) ? "w_2_26.mif" :
                        (i == 27) ? "w_2_27.mif" :
                        (i == 28) ? "w_2_28.mif" :
                        (i == 29) ? "w_2_29.mif" :
                        "w_2_default.mif"),

            .biasFile((i == 0) ? "b_2_0.mif" :
                      (i == 1) ? "b_2_1.mif" :
                      (i == 2) ? "b_2_2.mif" :
                      (i == 3) ? "b_2_3.mif" :
                      (i == 4) ? "b_2_4.mif" :
                      (i == 5) ? "b_2_5.mif" :
                      (i == 6) ? "b_2_6.mif" :
                      (i == 7) ? "b_2_7.mif" :
                      (i == 8) ? "b_2_8.mif" :
                      (i == 9) ? "b_2_9.mif" :
                      (i == 10) ? "b_2_10.mif" :
                      (i == 11) ? "b_2_11.mif" :
                      (i == 12) ? "b_2_12.mif" :
                      (i == 13) ? "b_2_13.mif" :
                      (i == 14) ? "b_2_14.mif" :
                      (i == 15) ? "b_2_15.mif" :
                      (i == 16) ? "b_2_16.mif" :
                      (i == 17) ? "b_2_17.mif" :
                      (i == 18) ? "b_2_18.mif" :
                      (i == 19) ? "b_2_19.mif" :
                      (i == 20) ? "b_2_20.mif" :
                      (i == 21) ? "b_2_21.mif" :
                      (i == 22) ? "b_2_22.mif" :
                      (i == 23) ? "b_2_23.mif" :
                      (i == 24) ? "b_2_24.mif" :
                      (i == 25) ? "b_2_25.mif" :
                      (i == 26) ? "b_2_26.mif" :
                      (i == 27) ? "b_2_27.mif" :
                      (i == 28) ? "b_2_28.mif" :
                      (i == 29) ? "b_2_29.mif" :
                      "b_2_default.mif")
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
