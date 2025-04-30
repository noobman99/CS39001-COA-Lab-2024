`timescale 1ns / 1ps

module reg_bank #(parameter N = 32) (clk, rst, read1, read2, write, dest, w_data, src1, r_data1, src2, r_data2, src3, r_data3);
    input read1, read2, write, clk, rst;
    input [4:0] dest, src1, src2, src3;
    input [N-1:0] w_data;
    output reg [N-1:0] r_data1, r_data2, r_data3;

    reg [N-1:0] reg_file [15:0];
    integer i;   

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_file[0] <= 0;
            reg_file[1] <= 0;
            reg_file[2] <= 0;
            reg_file[3] <= 0;
            reg_file[4] <= 0;
            reg_file[5] <= 0;
            reg_file[6] <= 0;
            reg_file[7] <= 0;
            reg_file[8] <= 0;
            reg_file[9] <= 0;
            reg_file[10] <= 0;
            reg_file[11] <= 0;
            reg_file[12] <= 0;
            reg_file[13] <= 0;
            reg_file[14] <= 0;
            reg_file[15] <= 0;
        end else if (write) begin
            reg_file[dest[3:0]] <= w_data;
        end else begin
            reg_file[0] <= 0;
        end
    end

    always @(negedge clk) begin
       if (read1) begin
           r_data1 <= reg_file[src1[3:0]];
       end
       if (read2) begin
           r_data2 <= reg_file[src2[3:0]];
       end
       r_data3 <= reg_file[src3[3:0]];
    end

endmodule