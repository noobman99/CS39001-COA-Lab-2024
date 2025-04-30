`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2024 14:38:46
// Design Name: 
// Module Name: alu_top
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


module alu_top #(parameter N = 32) (out, a, b, sel);
  input [N-1:0] a, b;
  input [3:0] sel;
  output [N-1:0] out;
  wire c, borr, c4, borr4;
  
//  initial
//    $monitor ("Input to ALU, a= %b, b = %b, op = %b, out = %b", a,b,sel, out);
 
  wire [N-1:0] tmp_0, tmp_1, tmp_2, tmp_3, tmp_4, tmp_5, tmp_6, tmp_7,
    tmp_8, tmp_9, tmp_10, tmp_11, tmp_12, tmp_13, tmp_14, tmp_15;
 
  not_n #(N) not_ (tmp_0, a);
  adder_n #(N) add_ (tmp_1, c, a, b);
  subr_n #(N) sub_ (tmp_2, borr, a, b);
  subr_n #(N) sub_4 (tmp_3, borr4, a, 32'b100);
  and_n #(N) and_ (tmp_4, a, b);
  or_n #(N) or_ (tmp_5, a, b);
  xor_n #(N) xor_ (tmp_6, a, b);
  nor_n #(N) nor_ (tmp_7, a, b);/////
  adder_n #(N) add_4 (tmp_8, c4, a, 32'b100);
  shift_left #(N) sll_ (tmp_9, a, b);
  shift_right_log #(N) srl_ (tmp_10, a, b);
  shift_right_ar #(N) sra_ (tmp_11, a, b);
  slt_n #(N) slt_ (tmp_12, a, b);/////
  sgt_n #(N) sgt_ (tmp_13, a, b);/////
  lui_n #(N) lui_ (tmp_14, a);/////
  hamming32 ham_ (tmp_15, {{(32 - N){1'b0}}, a});
 
//  bus_mux_16_1 #(N) mx (sel, tmp, out);

  genvar i;
  generate
    for(i = 0; i < N; i = i + 1) begin : top_mux
        mux_16_1 mx (.sel(sel), .in({tmp_15[i], tmp_14[i], tmp_13[i], tmp_12[i], tmp_11[i], tmp_10[i], tmp_9[i], tmp_8[i], tmp_7[i], tmp_6[i], tmp_5[i], tmp_4[i], tmp_3[i], tmp_2[i], tmp_1[i], tmp_0[i]}), .out(out[i]));
    end
  endgenerate
   
endmodule
