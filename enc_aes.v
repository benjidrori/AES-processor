`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:17:20 09/01/2023 
// Design Name: 
// Module Name:    enc_aes 
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
`include "keyexpansion.v"
`include "round_enc.v"

module enc_aes(
    input [127:0] plaintext,
    input [127:0] key,
	 input CLK,
	 input enable,
    output [127:0] ciphertext,
	 output done
    );
	 
	 reg [1407:0] roundkeys;
	 reg [127:0] state;
	 reg [127:0] state_in1, state_in2, state_in3, state_in4, state_in5, state_in6, state_in7, state_in8, state_in9, state_in10; 
	 reg [127:0] state_out0, state_out1, state_out2, state_out3, state_out4, state_out5, state_out6, state_out7, state_out8, state_out9;
	 reg vin1, vin2, vin3, vin4, vin5, vin6, vin7, vin8, vin9, vin10; //validation of the input
	 reg vout1, vout2, vout3, vout4, vout5, vout6, vout7, vout8, vout9, vout10;//validation of the output
   
	// calculaion of the roundkeys
	keyexpansion ke(key, roundkeys);
	
	//round0 - addroundkey of plaintext and the original key
	 always @(posedge CLK) begin
			 if (enable) begin
				  state_out0 = plaintext ^ key; 
				  vout1 = 1;
			 end else begin
				  state_out0 = 128'b0; // No operation - set to 0
				  vout1 = 0;
			 end
	  end
   
	//10 rounds for encryption
	round_enc r1(state_in1, roundkeys[1279:1152], 0, vin1, state_out1, vout2);
	round_enc r2(state_in2, roundkeys[1151:1024], 0, vin2, state_out2, vout3);
	round_enc r3(state_in3, roundkeys[1023:896], 0, vin3, state_out3, vout4);
	round_enc r4(state_in4, roundkeys[895:768], 0, vin4, state_out4, vout5);
	round_enc r5(state_in5, roundkeys[767:640], 0, vin5, state_out5, vout6);
	round_enc r6(state_in6, roundkeys[639:512], 0, vin6, state_out6, vout7);
	round_enc r7(state_in7, roundkeys[511:384], 0, vin7, state_out7, vout8);
	round_enc r8(state_in8, roundkeys[383:256], 0, vin8, state_out8, vout9);
	round_enc r9(state_in9, roundkeys[255:128], 0, vin9, state_out9, vout10);
	round_enc r10(state_in10, roundkeys[127:0], 1, vin10, ciphertext, done);

    always @(posedge CLK) begin
        state <= plaintext;
        state_in1 <= state_out0;
        state_in2 <= state_out1;
        state_in3 <= state_out2;
        state_in4 <= state_out3;        
        state_in5 <= state_out4;
        state_in6 <= state_out5;
        state_in7 <= state_out6;
        state_in8 <= state_out7;
        state_in9 <= state_out8;
        state_in10 <= state_out9;

        vin1 <= vout1;
        vin2 <= vout2;
        vin3 <= vout3;
        vin4 <= vout4;
        vin5 <= vout5;
        vin6 <= vout6;
        vin7 <= vout7;
        vin8 <= vout8;
        vin9 <= vout9;
        vin10 <= vout10;

    end


endmodule
