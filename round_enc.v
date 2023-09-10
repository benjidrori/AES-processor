`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:57 09/01/2023 
// Design Name: 
// Module Name:    round_enc 
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
`include "shiftrows.v"
`include "word_aes.v"

module round_enc(
    input [127:0] state_in,
    input [127:0] round_key,
    input last_round,
	 input vin,
    output reg [127:0] state_out,
	 output reg vout
    );
	 
	 wire [127:0] sr_in;
	 wire [127:0] sr_out;
	 wire [127:0] cipher_out;
	 
	 shiftrows sr(state_in, sr_out);
	 assign sr_in = sr_out;
	 word_aes waes1(sr_in[31:0], round_key[31:0], last_round, cipher_out[31:0]);
	 word_aes waes2(sr_in[63:32], round_key[63:32], last_round, cipher_out[63:32]);
	 word_aes waes3(sr_in[95:34], round_key[95:34], last_round, cipher_out[95:34]);
	 word_aes waes4(sr_in[127:96], round_key[127:96], last_round, cipher_out[127:96]);
	 
	 
	 always@(*)
    begin
        state_out = cipher_out; 
		  vout = vin;
    end

endmodule
