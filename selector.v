`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:28:27 08/26/2023 
// Design Name: 
// Module Name:    selector 
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
`include "SBOX.v"

module selector(
    input [31:0] word_in,
    input [1:0] index,
    output reg [7:0] subyte
    );
	 
	 wire [7:0] byte1;
	 assign byte1 = word_in[7:0];
	 wire [7:0] byte2;
	 assign byte2 = word_in[15:8];
	 wire [7:0] byte3;
	 assign byte3 = word_in[23:16];
	 wire [7:0] byte4;
	 assign byte4 = word_in[31:24];
	 
	 SBOX s1(word_in , byte1);
	 SBOX s2(word_in , byte2);
	 SBOX s3(word_in , byte3);
	 SBOX s4(word_in , byte4);

		always @(index or word_in) begin
					  case(index)
							2'b00 : subyte = byte1;
							2'b01 : subyte = byte2;
							2'b10 : subyte = byte3;
							2'b11 : subyte = byte4;
						endcase
				end

endmodule
