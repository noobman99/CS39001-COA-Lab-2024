`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2024 15:57:55
// Design Name: 
// Module Name: mux_4_1
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


module mux_4_1(sel, in, out);
    input [1:0] sel;
    input [3:0] in;
    output out;
    
    wire mo0, mo1;
    
    mux_2_1 m0 (.sel(sel[0]), .i0(in[0]), .i1(in[1]), .out(mo0));
    mux_2_1 m1 (.sel(sel[0]), .i0(in[2]), .i1(in[3]), .out(mo1));
    mux_2_1 final (.sel(sel[1]), .i0(mo0), .i1(mo1), .out(out));
    
endmodule
