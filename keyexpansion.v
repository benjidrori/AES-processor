`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:42:23 08/31/2023 
// Design Name: 
// Module Name:    keyexpansion 
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
`include "sub_keyexpansion.v"

module keyexpansion(
    input [127:0] key,
    output reg [1407:0] roundkey_array
    );
	 
	 wire [1407:0] roundkeys;

		assign roundkeys[1407:1280] = key[127:0];

			 sub_keyexpansion kc1(roundkeys[1407:1280], roundkeys[1279:1152], 8'd1);
			 sub_keyexpansion kc2(roundkeys[1279:1152], roundkeys[1151:1024], 8'd2);
			 sub_keyexpansion kc3(roundkeys[1151:1024], roundkeys[1023:896], 8'd3);
			 sub_keyexpansion kc4(roundkeys[1023:896], roundkeys[895:768], 8'd4);
			 sub_keyexpansion kc5(roundkeys[895:768], roundkeys[767:640], 8'd5);
			 sub_keyexpansion kc6(roundkeys[767:640], roundkeys[639:512], 8'd6);
			 sub_keyexpansion kc7(roundkeys[639:512], roundkeys[511:384], 8'd7);
			 sub_keyexpansion kc8(roundkeys[511:384], roundkeys[383:256], 8'd8);
			 sub_keyexpansion kc9(roundkeys[383:256], roundkeys[255:128], 8'd9);
			 sub_keyexpansion kc10(roundkeys[255:128], roundkeys[127:0], 8'd10);
			 
		 always@(*)
    begin
        roundkey_array = roundkeys; 
    end


endmodule
