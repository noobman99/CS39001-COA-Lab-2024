`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2024 15:53:52
// Design Name: 
// Module Name: mux_2_1
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

module mux_2_1(sel, i0, i1, out);
    input sel, i0, i1;
    output out;
    
    wire sel_not, term1, term2;

    not (sel_not, sel);

    and (term1, i0, sel_not);
    and (term2, i1, sel);

    or (out, term1, term2);
    
endmodule