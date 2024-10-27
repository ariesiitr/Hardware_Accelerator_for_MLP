module multiplier #(parameter dataWidth=16, weightWidth =16, input_dataWidth=32 )(  //input for adder is its output
input [dataWidth-1:0] in1,
input [weightWidth-1:0] in2,
output [input_dataWidth-1:0] out);

assign out=$signed(in1)* $signed(in2);

endmodule 