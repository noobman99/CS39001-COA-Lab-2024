`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2024 15:53:52
// Design Name: 
// Module Name: mux_16_1
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


module mux_16_1(sel, in, out);
    input [3:0] sel;
    input [15:0] in;
    output out;
    
    wire [3:0] mo;
    
    mux_4_1 m0 (.sel(sel[1:0]), .in(in[3:0]), .out(mo[0]));
    mux_4_1 m1 (.sel(sel[1:0]), .in(in[7:4]), .out(mo[1]));
    mux_4_1 m2 (.sel(sel[1:0]), .in(in[11:8]), .out(mo[2]));
    mux_4_1 m3 (.sel(sel[1:0]), .in(in[15:12]), .out(mo[3]));
    mux_4_1 final (.sel(sel[3:2]), .in(mo), .out(out));
endmodule
