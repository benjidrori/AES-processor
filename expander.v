`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:06:09 08/26/2023 
// Design Name: 
// Module Name:    expander 
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
module expander(
    input [7:0] in,
    output [31:0] out
    );

		assign out= {24'b0,in};  // Concatenate 24 zeros with the 8-bit input


endmodule
