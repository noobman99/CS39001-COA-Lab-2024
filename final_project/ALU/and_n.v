`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2024 16:11:55
// Design Name: 
// Module Name: and8
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


module and_n #(parameter N = 8)(out, a, b);
    input [N-1:0] a, b;
    output [N-1:0] out;
    
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : and_gen //
            and a_gate(out[i], a[i], b[i]);
        end
    endgenerate

endmodule