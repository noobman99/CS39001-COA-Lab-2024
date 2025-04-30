`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:28:52 08/14/2024 
// Design Name: 
// Module Name:    full_adder 
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
module full_adder(s,c,a,b,cin);
    input a,b,cin;
    output s,c;
    wire p, g, t1;
    and a0(g, a, b);
    xor x0(p, a, b);
    xor x1(s, p, cin);
    
    and x2(t1, p, cin);
    or o0(c, g, t1);

endmodule