`timescale 1ns/1ps

module cond_branch #(parameter N = 32) (A, cond, branch);
    input [N-1:0] A;
    input [2:0] cond;
    output reg branch;
    
    initial begin
        $monitor("Condition %b, branch %b, A = %b", cond, branch, A);
    end
    
    wire po = (|A);
    wire msb = A[N-1];

    always @(*) begin
        case (cond)
            3'b000: branch <= 0;
            3'b100: branch <= 1;
            3'b001: branch <= msb;
            3'b010: branch <= (~msb) & po;
            3'b011: branch <= ~po;
            default: branch <= 0;
        endcase
    end

endmodule