`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:40:15 09/04/2023 
// Design Name: 
// Module Name:    ctr_encrypt 
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
`include "enc_aes.v"

module ctr_encrypt(
    input CLK,
    input enable,
    input [127:0] key,
    input [127:0] Din,
    output [127:0] Dout,
    output done_enc
    );

	wire [127:0] enc_plain;
	wire [127:0] enc_cipher;
	wire enc_v;
		
	enc_aes encrypt(
		.plaintext(enc_plain), 
		.key(key), 
		.CLK(CLK), 
		.enable(enable), 
		.ciphertext(enc_cipher), 
		.done(enc_v)
	);
	
	assign enc_plain =  Din ; 
	assign done_enc = enc_v ;
	assign Dout = enc_cipher;

endmodule
