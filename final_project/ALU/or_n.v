`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2024 16:16:17
// Design Name: 
// Module Name: or8
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


module or_n #(parameter N = 8)(out, a, b);
    input [N-1:0] a,b;
    output [N-1:0] out;
    
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : or_gen //
            or o_gate(out[i], a[i], b[i]);
        end
    endgenerate
    
endmodule
