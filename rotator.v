`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:25:56 08/26/2023 
// Design Name: 
// Module Name:    rotator 
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
module rotator(
    input [31:0] word_in,
    input [1:0] index,
    output reg [31:0] word_out
    );

		always @(index) begin
					  case(index)
							2'b00 : word_out = word_in;
							2'b01 : word_out = {word_in[15:8], word_in[23:16], word_in[31:24], word_in[7:0]};
							2'b10 : word_out = {word_in[23:16], word_in[31:24], word_in[7:0], word_in[15:8]};
							2'b11 : word_out = {word_in[31:24], word_in[7:0], word_in[15:8], word_in[23:16]};
						endcase
				end

endmodule
