`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:52:20 08/31/2023 
// Design Name: 
// Module Name:    shiftrows 
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
module shiftrows(
    input [127:0] state,
    output reg [127:0] out
    );

	 wire [127:0] mid_state;

	 /* row 0 no change */
    assign mid_state[7:0] = state[7:0];
    assign mid_state[39:32] = state[39:32];
    assign mid_state[71:64] = state[71:64];
    assign mid_state[103:96] = state[103:96];

    /* row 1 , 1 shift left */
    assign mid_state [15:8] = state[47:40];
    assign mid_state [47:40] = state[79:72];
    assign mid_state [79:72] = state[111:104];
    assign mid_state [111:104] = state[15:8];

    /* row 2 , 2 shifts left */
    assign mid_state [23:16] = state[87:80];
    assign mid_state [55:48] = state[119:112];
    assign mid_state [87:80] = state[23:16];
    assign mid_state [119:112] = state[55:48];

    /* row 3 , 3 shifts left */
    assign mid_state [31:24] = state[127:120];
    assign mid_state [63:56] = state[31:24];
    assign mid_state [95:88] = state[63:56];
    assign mid_state [127:120] = state[95:88];
	
	always@(*)
    begin
        out <= mid_state; 
    end

endmodule
