`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:31:13 08/14/2024 
// Design Name: 
// Module Name:    subr_N
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

module subr_n #(parameter N = 8)(s, borr, a, b);
	input [N-1:0] a, b;
	output [N-1:0] s;
	output borr;
	
	wire [N:0] borrow;
    assign borr = borrow[N-1];
    assign borrow[0] = 1'b0;
    
    genvar i;
    generate
        for (i = 1; i <= N; i = i + 1) begin: full_adder_gen
            full_subr fs (.s(s[i-1]), .borr(borrow[i]), .a(a[i-1]), .b(b[i-1]), .bin(borrow[i-1]));
        end
    endgenerate
	
endmodule
