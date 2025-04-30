`timescale 1ns / 1ps

module program_counter_inc #(parameter N = 32) (clk, pc, next_pc);
    input clk;
    input [N-1:0] pc;
    output reg [N-1:0] next_pc;

    reg [N-1:0] pc_reg;

    always @(negedge clk) begin
        next_pc <= pc + 1;
    end

endmodule