`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:00:54 09/04/2023 
// Design Name: 
// Module Name:    preanalysis 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "collecting_128bit.v"

module preanalysis(
    input [31:0] data_in,
    input [11:0] plain_address,
    input new_key,
    input start,
    input CLK,
    output [31:0] address,
    output read_enable,
    output [127:0] data_out,
    output [127:0] key_out,
    output ready,
    output [2:0] counter
    );

	reg preprocess_en; 		// high while preprocess
	reg collect_en; 		// high while we want collecting_128bit to be on
	reg start_delayed; 		// high one cycle after start
	reg start_collect; 		// high two cycle after start
	wire [31:0] addr; 		// variable t store the current address we start from
	reg [2:0] cnt;		// counter 

	assign read_enable = preprocess_en & !ready;	// high when we want to read from ram 
	assign addr = cnt[2] ? 'b0 : plain_address + 4; // since addresses 0-3 are key, the addresses start at 4 
	assign address = addr + cnt[1:0]; 

	
	always @(posedge CLK) begin
		preprocess_en <= (preprocess_en & (!ready | start)) | start;
		collect_en <= (collect_en & (!ready | start_collect)) | start_collect;
		if (read_enable) cnt <= cnt + 1'b1;
		else if (ready | start) cnt <= 1'b0;
		start_collect <= start_delayed;
		start_delayed <= start;
	end
							
	collecting_128bit buffer128 (
		.data_in	(data_in),
		.enable	(collect_en), 
		.new_key	(new_key),
		.CLK 	(CLK), 
		.key_out (key_out),	
		.data_out(data_out),
		.valid 	(ready),
		.counter	(counter)
		);

endmodule
