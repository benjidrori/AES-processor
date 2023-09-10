`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:49:13 08/26/2023 
// Design Name: 
// Module Name:    mixcolumns 
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
////////////////////////////////////////////////////////////////////////////
`include "SBOX.v"
`include "mulby2.v"
`include "mulby3.v"

module mixcolumns(
    input [7:0] byte_in,
	 input last_round,
    output reg [31:0] word_out
    );
	 
	 wire [7:0] mul2;
	 wire [7:0] mul3;
	 
	 mulby2 m2(byte_in , mul2);
	 mulby3 m3(byte_in , mul3);

		always @(last_round or byte_in) begin
			  case(last_round)
					1'b0 : word_out = {mul2, mul3, byte_in, byte_in};
					1'b1 : word_out = byte_in;
				endcase
		end

endmodule
