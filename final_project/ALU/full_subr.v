`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2024 16:35:47
// Design Name: 
// Module Name: full_subr
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


module full_subr(s,borr,a,b,bin);
    input a,b,bin;
    output s, borr;
    wire p, g, t1, t2;
    and a0(g, bin, b);
    xor x0(p, bin, b);
    
    xor x1(s, p, a);
    
    not n0 (t2, a);
    and x2(t1, p, t2);
    or o0(borr, g, t1);

endmodule