`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:59:13 08/28/2023 
// Design Name: 
// Module Name:    shift_by_num 
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
module shift_by_num(
    input [31:0] in,
    input [4:0] shift_amount,
	 input right,
    output reg [31:0] out
    );

		always @(in or shift_amount) begin
			case(right)
				1'b0 : out = in << shift_amount;
				1'b1 : out = in >> shift_amount;
			endcase

		end

endmodule
