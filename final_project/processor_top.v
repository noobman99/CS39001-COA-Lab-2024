`timescale 1ns/1ps

module processor_top (clk, rst, unstop, reg_addr, reg_data_output);
    parameter N = 32;
    input clk, rst, unstop;
    input [3:0] reg_addr;
    output [(N / 2)-1:0] reg_data_output;

    wire [N-1:0] NPC, PC, PC_INP;
    wire [N-1:0] IR;
    wire [N-1:0] sgn_extend;
    wire [N-1:0] A, B, ALU_OUT;
    wire [N-1:0] reg_data;

    wire [N-1:0] MEM_OUT;

    wire [N-1:0] regWrData;
    wire [4:0] regWrDest;
    
    initial begin
        $monitor("IR = %b at time %d", IR, $time);
        $monitor("MemWr = %b at time %d", memWr, $time);
    end

    // control signals
    wire [2:0] brOp;
    wire [3:0] aluOp;
    wire [1:0] regISel;
    wire BSel, wrRegSel, memRd, memWr, regWr, regRd, sgnExt, isMV, incPC;

    // Control Unit
    control control_unit (clk, rst, unstop, IR[31:26], IR[3:0], brOp, aluOp, BSel, wrRegSel, memRd, memWr, regWr, regRd, regISel, sgnExt, isMV, incPC);

    // Program Counter
    program_counter #(N) pc_block (clk, rst, incPC, PC, PC_INP);
    program_counter_inc #(N) pc_inc (clk, PC, NPC);

    // Sign Extend Unit
    wire [N-1:0] sgn_extend_16, sgn_extend_26;
    sgn_extend #(N, 16) sgn_extend_unit (IR[15:0], sgn_extend_16);
    sgn_extend #(N, 26) sgn_extend_unit_2 (IR[25:0], sgn_extend_26);
    assign sgn_extend = sgnExt ? sgn_extend_26 : sgn_extend_16;

    // Regbank
    reg_bank #(N) reg_bank_unit (clk, rst, regRd, regRd, regWr, regWrDest, regWrData, IR[25:21], A, IR[20:16], B, {0,reg_addr}, reg_data);
    // Selecting the write destination register
    assign regWrDest = wrRegSel ? IR[15:11] : IR[20:16];

    // Display the output (regiser data)
    display_output #(N) display_output_unit (clk, rst, reg_data, reg_data_output);

    // Selecting the Inputs to the ALU
    wire [N-1:0] A_input, B_input;
    assign A_input = (|brOp) ? PC : A;
    assign B_input = BSel ? B : sgn_extend;

    // ALU
    alu_top #(N) alu_unit (ALU_OUT, A_input, B_input, aluOp);


    // Branch Unit
    wire branch;
    cond_branch #(N) branch_unit (A, brOp, branch);
    assign PC_INP = branch ? ALU_OUT : NPC;

    // Write back Unit
    wire muxsel;
    assign muxsel = isMV ? ALU_OUT[0] : regISel[0];
    wire [N-1:0] l1_mux_out_1, l1_mux_out_2;
    assign l1_mux_out_1 = muxsel ? MEM_OUT : ALU_OUT;
    assign l1_mux_out_2 = muxsel ? A : B;
    assign regWrData = regISel[1] ? l1_mux_out_2 : l1_mux_out_1;

    // Memory Unit

    // Data Memory
//    data_mem #(10, N) data_mem_unit (~clk, ALU_OUT[9:0], memWr, memRd, B, MEM_OUT);
    wire dmu_ena = memRd | memWr;
    data_mem_gen data_mem_unit(.clka(clk), .addra(ALU_OUT[6:0]), .dina(B), .douta(MEM_OUT), .ena(dmu_ena), .wea(memWr));
    // Instruction Memory
//    instruction_mem #(10, N) instruction_mem_unit (~clk, PC[9:0], 1'b0, 1'b1, 32'b0, IR);
    blk_mem_gen_0 instruction_mem_unit(.clka(~clk), .addra(PC[7:0]), .douta(IR));
endmodule