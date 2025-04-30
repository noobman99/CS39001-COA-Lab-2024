`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2024 16:20:08
// Design Name: 
// Module Name: not8
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


module not_n #(parameter N = 8)(out, a);
    input [N-1:0] a;
    output [N-1:0] out;
    
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : not_gen //
            not n_gate(out[i], a[i]);
        end
    endgenerate
    
endmodule
