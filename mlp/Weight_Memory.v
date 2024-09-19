`timescale 1ns/1ps
`include "include.v"

module Weight_Memory #(parameter numWeight = 3,neuronNo=5, layerNo=1,addressWidth=10,dataWidth=16,weigthFile="w_1_15.mif")
(
input clk,
input ren,
output reg [dataWidth-1:0] wout);
input [addressWidth-1:0] radd,

  reg [dataWidth-1:0] mem [numWeight-1:0];

initial
	begin
		$readmemb(weigthFile, mem);
	end
	
always @(posedge clk)
begin
	if (ren)
	begin
		wout <= mem[radd];
	end
end
endmodule
