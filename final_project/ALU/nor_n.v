`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2024 14:51:54
// Design Name: 
// Module Name: nor_n
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


module nor_n #(parameter N = 8)(out, a, b);
    input [N-1:0] a, b;
    output [N-1:0] out;
    
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : nor_gen //
            nor no_gate(out[i], a[i], b[i]);
        end
    endgenerate

endmodule
