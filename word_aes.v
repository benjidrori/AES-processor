`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:55:55 09/01/2023 
// Design Name: 
// Module Name:    word_aes 
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
`include "SUBMIX.v"

module word_aes(
    input [31:0] state_in,
    input [31:0] round_key,
	 input last_round,
    output reg [31:0] state_out
    );
	 
	 wire [31:0] mid_state;

	SUBMIX sm1(state_in, 2'b00, last_round, mid_state);
	SUBMIX sm2(state_in, 2'b01, last_round, mid_state);
	SUBMIX sm3(state_in, 2'b10, last_round, mid_state);
	SUBMIX sm4(state_in, 2'b11, last_round, mid_state);
	
	always@(*)
    begin
        state_out = mid_state ^ round_key; 
    end
	
	

endmodule
