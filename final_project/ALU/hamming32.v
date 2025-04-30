`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2024 15:43:38
// Design Name: 
// Module Name: hamming32
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


module hamming32(out, a);
    input [32:0] a;
    output [32:0] out;

    wire [32:0] sum_temp;
    wire [7:0] carry_temp;
    wire [23:0] sum_temp_2;
    wire [7:0] carry_temp_2;
    wire [15:0] sum_temp_3;
    wire [5:0] carry_temp_3;
    wire [9:0] sum_temp_4;
    
    wire [3:0] carry_fin;
    
    genvar i, j, k, m;
    generate
        for (i = 0; i < 16; i = i + 1) begin: base_gen_0
            half_adder ha(sum_temp[2*i], sum_temp[2*i+1], a[2*i], a[2*i+1]);
        end
        for (j = 0; j < 8; j = j + 1) begin: base_gen_1
            half_adder ha1(sum_temp_2[3*j], carry_temp[j], sum_temp[4*j], sum_temp[4*j +2]);
            full_adder fa0(sum_temp_2[3*j+1], sum_temp_2[3*j+2], sum_temp[4*j+1], sum_temp[4*j+3], carry_temp[j]);
        end
        for (k = 0; k < 4; k = k + 1) begin: base_gen_2
            half_adder ha2(sum_temp_3[4*k], carry_temp_2[2*k], sum_temp_2[6*k], sum_temp_2[6*k+3]);
            full_adder fa10(sum_temp_3[4*k+1], carry_temp_2[2*k+1], sum_temp_2[6*k+1], sum_temp_2[6*k+4], carry_temp_2[2*k]);
            full_adder fa11(sum_temp_3[4*k+2], sum_temp_3[4*k+3], sum_temp_2[6*k+2], sum_temp_2[6*k+5], carry_temp_2[2*k+1]);
        end
        for (m = 0; m < 2; m = m + 1) begin: base_gen_3
            half_adder ha3(sum_temp_4[5*m], carry_temp_3[3*m], sum_temp_3[8*m], sum_temp_3[8*m+4]);
            full_adder fa20(sum_temp_4[5*m+1], carry_temp_3[3*m+1], sum_temp_3[8*m+1], sum_temp_3[8*m+5], carry_temp_3[3*m]);
            full_adder fa21(sum_temp_4[5*m+2], carry_temp_3[3*m+2], sum_temp_3[8*m+2], sum_temp_3[8*m+6], carry_temp_3[3*m+1]);
            full_adder fa22(sum_temp_4[5*m+3], sum_temp_4[5*m+4], sum_temp_3[8*m+3], sum_temp_3[8*m+7], carry_temp_3[3*m+2]);
        end
    endgenerate
    
    half_adder ha_fin(out[0], carry_fin[0], sum_temp_4[0], sum_temp_4[5]);
    full_adder fa_fin1(out[1], carry_fin[1], sum_temp_4[1], sum_temp_4[6], carry_fin[0]);
    full_adder fa_fin2(out[2], carry_fin[2], sum_temp_4[2], sum_temp_4[7], carry_fin[1]);
    full_adder fa_fin3(out[3], carry_fin[3], sum_temp_4[3], sum_temp_4[8], carry_fin[2]);
    full_adder fa_fin4(out[4], out[5], sum_temp_4[4], sum_temp_4[9], carry_fin[3]);
    
    assign out[31:6] = 26'b0;
    
endmodule
