`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:52:45 09/04/2023 
// Design Name: 
// Module Name:    aes_accelerator 
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
`include "preanalysis.v"
`include "ctr_encrypt.v"
`include "post_analysis.v"

module aes_accelerator(
    input CLK,
    input start,
    input new_key,
    input [11:0] plain_address,
    input [11:0] cipher_address,
    input [31:0] read_data,
    output done,
    output read_en,
    output write_en,
    output [31:0] write_data,
    output [2:0] counter,
    output [127:0] aes_in,
    output [127:0] aes_out,
    output [31:0] address,
    output [127:0] key
    );

	wire ready;
	wire valid;
	wire [31:0] read_address;
	wire [31:0] write_address;
	
	assign address = write_en ? write_address : read_address;

	
	preanalysis pre(
		.data_in (read_data), 
		.plain_address (plain_address),
		.new_key	(new_key),
		.start (start), 
		.CLK (CLK), 
		.address (read_address),
		.read_enable (read_en), 
		.data_out	(aes_in), 
		.key_out	(key),
		.ready (ready),  
		.counter(counter)
		);
		
	ctr_encrypt aes_encryption(
		.CLK (CLK), 
		.enable (ready), 
		.key (key),
		.Din (aes_in),
		.Dout (aes_out),
		.done_enc (valid)
		);  							
								
	post_analysis post(
		.CLK (CLK),
		.start (valid), 
		.cypher_address (cipher_address),
		.data_in (aes_out), 
		.data_out	(write_data),
		.address (write_address),
		.write_enable (write_en),
		.done (done)
		);

endmodule
