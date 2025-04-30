`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:31:13 08/14/2024 
// Design Name: 
// Module Name:    adder_N
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

module adder_n #(parameter N = 8)(s, c, a, b);
	input [N-1:0] a, b;
	output [N-1:0] s;
	output c;
	
	wire [N-1:0] carry;
	assign c = carry[N-1];

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin: full_adder_gen
            full_adder fa (.s(s[i]), .c(carry[i]), .a(a[i]), .b(b[i]), .cin( i == 0 ? 1'b0 : carry[i-1]));
        end
    endgenerate
	
endmodule
