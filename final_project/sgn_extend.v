`timescale 1ns / 1ps

module sgn_extend #(parameter N = 32, M = 16) (in, out);
    input [M-1:0] in;
    output [N-1:0] out;

    assign out = {{N-M{in[M-1]}}, in};
endmodule