`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2024 14:54:01
// Design Name: 
// Module Name: lui_n
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


module lui_n#(parameter N = 8)(out, a);
    input [N-1:0] a;
    output [N-1:0] out;
    
    assign out[N-1:N/2] = a[N/2 - 1: 0];
    assign out[N/2 - 1: 0] = {(N/2){1'b0}};

endmodule