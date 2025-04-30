`timescale 1ns/1ps

module display_output #(parameter N = 32) (clk, rst, reg_data, reg_data_output);
    input clk, rst;
    input [N-1:0] reg_data;
    output reg [(N / 2) - 1:0] reg_data_output;

    reg state;
    reg next_state;
    
//    initial begin
//        state <= 0;
//        next_state <= 1;
//    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 0;
        end 
        else begin
            state <= next_state;
        end
    end

    always @(state) begin
        if (state == 0) begin
            reg_data_output = reg_data[N-1:N/2];
            next_state = 1;
        end
        else begin
            reg_data_output = reg_data[N/2-1:0];
            next_state = 0;
        end
    end
endmodule