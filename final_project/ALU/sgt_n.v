`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2024 14:44:39
// Design Name: 
// Module Name: sgt_n
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sgt_n #(parameter N = 8)(out, a, b);
	input [N-1:0] a, b;
	output [N-1:0] out;
    wire [N-1:0] tmp;
    
    assign out[N-1:1] = {(N-1){1'b0}};
    subr_n #(N) subr (tmp, out[0], b, a);
    
endmodule
