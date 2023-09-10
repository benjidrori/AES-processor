`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:33:30 08/31/2023 
// Design Name: 
// Module Name:    sub_keyexpansion 
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
`include "RCON.v"

module sub_keyexpansion(
    input [127:0] in,
    input [7:0] iter,
    output [127:0] out
    );

    wire [31:0] sbox_out;     
	 wire [7:0] rcon_out;      
    reg [127:0] tmp;    // reg to temporarily hold output


    // sbox for a word (indices include rotation)
    SBOX s1(in[31:24], sbox_out[7:0]);
    SBOX s2(in[7:0], sbox_out[15:8]);
    SBOX s3(in[15:8], sbox_out[23:16]);
    SBOX s4(in[23:16], sbox_out[31:24]);

    // rcon lookup
    RCON r1(iter, rcon_out);

    always @(*) begin
        // for first word
        // Wn = Wn-4 ^ subst(Wn-1) ^ rcon[i]
        tmp[127:96] = in[127:96] ^  sbox_out ^ {rcon_out, {24{1'b0}}};

        // for all other words
        // Wn = Wn-1 ^ Wn-4
        tmp[95:64] = in[95:64] ^  tmp[127:96];
        tmp[63:32] = in[63:32] ^ tmp[95:64];
        tmp[31:0] = in[31:0] ^ tmp[63:32];

    end

    assign out = tmp;
    

endmodule
