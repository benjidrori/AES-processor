`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:53:40 09/04/2023 
// Design Name: 
// Module Name:    collecting_128bit 
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
module collecting_128bit(
    input [31:0] data_in,
    input enable,
    input new_key,
    input CLK,
    output [127:0] data_out,
    output valid,
    output [2:0] counter
    );

	reg [127:0] data_buffer;
   reg [2:0] cnt;

   always @(posedge CLK) begin
        if (enable) begin
            // Shift in 32 bits of data at each clock edge
            data_buffer <= {data_buffer[95:0], data_in};
            cnt <= cnt + 1;
        end else if (new_key) begin
            // Reset data collection when a new key is available
            data_buffer <= 128'b0;
            cnt <= 0;
        end
    end

    // Output signals
    assign data_out = data_buffer;
    assign valid = (cnt == 4'b1000); // Valid when 128 bits are collected
    assign counter = cnt;

endmodule
