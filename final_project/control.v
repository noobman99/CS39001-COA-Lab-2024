`timescale 1ns / 1ps

module control (clk, rst, unstop, opcode, func, brOp, aluOp, BSel, wrRegSel, memRd, memWr, regWr, regRd, regISel, sgnExt, isMV, incPC);
    input clk, rst, unstop;
    input [5:0] opcode;
    input [3:0] func;

    output [2:0] brOp;
    output [3:0] aluOp;
    output [1:0] regISel;
    output BSel, wrRegSel, memRd, memWr, regWr, regRd, sgnExt, isMV, incPC;

    wire [2:0] primary_brOp;
    wire [3:0] primary_aluOp;
    wire [1:0] primary_regISel;
    wire primary_BSel, primary_wrRegSel, primary_memRd, primary_memWr, primary_regWr, primary_sgnExt, primary_isMV;

    wire I0, I17, I18, I19, I28; 
    wire isHalt = (opcode == 6'b011110) & (~unstop);

    assign I0 = (opcode == 6'b000000);
    assign I17 = (opcode == 6'b010001);
    assign I18 = (opcode == 6'b010010);
    assign I19 = (opcode == 6'b010011);
    assign I28 = (opcode == 6'b011100);


    assign primary_brOp = opcode[5] ? opcode[2:0] : 3'b000;
    assign primary_aluOp = (I18 | I19 | opcode[5]) ? 4'b0001 : I0 ? func : opcode[3:0];
    assign primary_regISel = {I17 | I28, I17 | I18}; 
    assign primary_BSel = I0 | I28;
    assign primary_wrRegSel = I0 | I28;
    assign primary_memRd = I18;
    assign primary_memWr = I19;
    assign primary_regWr = (~opcode[4]) | I17 | I18 | I28;
    assign primary_sgnExt = (opcode[5] & (~opcode[2])) | (opcode[4] & opcode[3]);
    assign primary_isMV = I28;

    // designing the fsm for the control unit
    reg [2:0] state, next_state;
    
    initial begin
//        state <= 3'b0;
//        next_state <= 3'b0;
        $monitor("State : %b, next_state: %b at %d, isHalt - %b", state, next_state, $time, isHalt);
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 3'b111;
        end 
        else begin
            state <= next_state;
        end
    end

    always @ (state or unstop) begin
        case (state)
            3'b000: begin
                next_state <= isHalt ? 3'b110 : 3'b001;
                // READ INSTRUCTION FROM MEMORY
            end
            3'b001: begin
                next_state <= isHalt ? 3'b110 : 3'b010;
                // DECODE INSTRUCTION
            end
            3'b010: begin
                next_state <= isHalt ? 3'b110 : 3'b011;
                // EXECUTE INSTRUCTION
            end
            3'b011: begin
                next_state <= 3'b100;
                // MEMORY ACCESS
            end
            3'b100: begin
                next_state <= 3'b101;
                // MEMORY ACCESS
            end
            3'b101: begin
                next_state <= 3'b000;
                // WRITE BACK
                // INC PC
            end
            3'b110: begin
                next_state <= unstop ? 3'b101 : 3'b110;
                // HALT STATE
            end
            3'b111: begin
                next_state <= 3'b000;
                // RESET STATE
            end
            default: begin
                next_state <= 3'b000;
            end
        endcase
    end 


    // Final outputs according to the state
    assign brOp = primary_brOp;
    assign aluOp = primary_aluOp;
    assign regISel = primary_regISel;
    assign BSel = primary_BSel;
    assign wrRegSel = primary_wrRegSel;
    assign sgnExt = primary_sgnExt;
    assign isMV = primary_isMV;

    assign memRd = primary_memRd & (state == 3'b011 | state == 3'b100);
    assign memWr = primary_memWr & (state == 3'b011 | state == 3'b100);
    assign regWr = primary_regWr & (state == 3'b101);
    assign regRd = (state == 3'b010);
    assign incPC = (state == 3'b101);
    
endmodule