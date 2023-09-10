`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:12:13 09/04/2023 
// Design Name: 
// Module Name:    post_analysis 
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
module post_analysis(
    input [127:0] data_in,
    input [11:0] cipher_address,
    input start,
    input CLK,
    output [31:0] address,
    output write_enable,
    output reg [31:0] data_out,
    output reg done
    );

	reg enable; 
	reg [1:0] cnt;
	reg start_delayed;
	assign write_enable = enable & !done;
	assign address = cnt + cipher_address + 4; // since addresses 0-3 are key, the address start at 4 
	
	always @(posedge CLK) begin
		start_delayed <= start;
		if (enable | start_delayed) begin 
			enable <= (enable & (!done | start_delayed)) | start_delayed;
			if (!done) begin
				if (start_delayed) data_out[31:0] <= data_in[cnt*32 +: 32];
				else data_out[31:0] <= data_in[(cnt+1)*32 +: 32];
			end
		end
		if (enable) begin
			if (cnt == 3) begin
				done <= 1;
			end
			else done <= 0;
			if (!done) begin
				if (cnt != 3) cnt <= cnt + 1'b1;
				else cnt <= 'b0;
			end
		end
	end

endmodule
