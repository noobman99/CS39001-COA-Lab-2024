`timescale 1ns / 1ps

module program_counter #(parameter N = 32) (clk, rst, enable, pc, next_pc);
    input clk, rst, enable;
    output reg [N-1:0] pc;
    input [N-1:0] next_pc;
    
//    initial begin
//        pc <= 0;
//    end


    always @(posedge clk) begin
        if (rst) begin
            pc <= 0;
        end
        else if (enable) begin
            pc <= next_pc;
        end
    end

endmodule