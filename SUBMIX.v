`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:33:53 09/01/2023 
// Design Name: 
// Module Name:    SUBMIX 
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
`include "selector.v"
`include "mixcolumns.v"
`include "rotator.v"

module SUBMIX(
    input [31:0] state_in,
	 input index,
    input last_round,
    output reg [31:0] state_out
    );
	 
	 wire [7:0] subyte_out;
	 wire [7:0] subyte_in;
	 wire [31:0] mid_state_out;
	 wire [31:0] mid_state_in;
	 wire [31:0] rot_out;

	selector sel(state_in, index, subyte_out);
	assign subyte_in=subyte_out;
	mixcolumns mc(subyte_in, last_round,mid_state_out);
	assign mid_state_in = mid_state_out;
	rotator ro(mid_state_in, index,rot_out);
	
	always@(*)
    begin
        state_out = rot_out; 
    end

endmodule
