`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2025 16:48:57
// Design Name: 
// Module Name: top_module
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

// Structural top_module.v

module top_module(
    input clk,
    input reset,
    input btnc,
    output [15:0] led
);
    // Wires
    wire btnc_db, btnc_pressed, btnc_released;
    wire enable_execution;
    wire [15:0] pc, pc_next, instruction;
    wire [3:0] opcode = instruction[15:12];
    wire [3:0] rd_rt = instruction[11:8];
    wire [3:0] rs = instruction[7:4];
    wire [3:0] func_or_imm = instruction[3:0];

    wire alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, branch_not_equal, jump;
    wire [1:0] alu_op;

    wire [15:0] reg_data1, reg_data2, reg_write_data;
    wire [15:0] immediate_extended;
    wire [15:0] alu_operand2, alu_result;
    wire alu_zero;
    wire [15:0] mem_read_data;
    wire [15:0] last_written_value;

    // Button debounce and edge detection
    button_controller BTN_CTRL (
        .clk(clk), .reset(reset), .btnc(btnc),
        .btnc_db(btnc_db), .btnc_pressed(btnc_pressed), .btnc_released(btnc_released)
    );

    // Execution enable latch
    start_latch START_CTRL (
        .clk(clk), .reset(reset), .btnc_pressed(btnc_pressed),
        .enable_execution(enable_execution)
    );

    // Program counter control
    pc_control_unit PC_CTRL (
        .pc(pc),
        .imm(immediate_extended),
        .jump(jump),
        .branch(branch), .branch_not_equal(branch_not_equal), .alu_zero(alu_zero),
        .jmp_offset_raw(instruction[11:0]),
        .pc_next(pc_next)
    );

    // Program counter 
    program_counter PC_REG (
        .clk(clk), .reset(reset), .enable(enable_execution),
        .pc_in(pc_next), .pc_out(pc)
    );

    // Instruction memory
    instruction_memory IMEM (
        .address(pc), .instruction(instruction)
    );

    // Control unit
    control_unit CU (
        .opcode(opcode), .func(func_or_imm),
        .alu_src(alu_src), .mem_to_reg(mem_to_reg), .reg_write(reg_write),
        .mem_read(mem_read), .mem_write(mem_write), .branch(branch),
        .branch_not_equal(branch_not_equal), .jump(jump), .alu_op(alu_op)
    );

    // Register file
    register_file RF (
        .clk(clk), .reset(reset), .reg_write(reg_write & enable_execution),
        .read_reg1(rs), .read_reg2(rd_rt), .write_reg(rd_rt),
        .write_data(reg_write_data), .read_data1(reg_data1), .read_data2(reg_data2)
    );

    // Sign extension
    sign_extend SE (
        .imm(func_or_imm), .extended(immediate_extended)
    );

    // ALU operand mux
    mux2to1 ALU_MUX (
        .in0(reg_data2), .in1(immediate_extended), .sel(alu_src), .out(alu_operand2)
    );

    // ALU
    alu ALU (
        .a(reg_data1), .b(alu_operand2), .alu_op(alu_op), .result(alu_result), .zero(alu_zero)
    );

    // Data memory
    data_memory DMEM (
        .clk(clk), .mem_read(mem_read), .mem_write(mem_write),
        .address(alu_result), .write_data(reg_data2), .read_data(mem_read_data)
    );

    // Write-back mux
    mux2to1 WB_MUX (
        .in0(alu_result), .in1(mem_read_data), .sel(mem_to_reg), .out(reg_write_data)
    );

    // Last written tracker
    last_written_tracker TRACKER (
        .clk(clk), .reset(reset), .btnc_released(btnc_released),
        .reg_write(reg_write), .reg_write_data(reg_write_data),
        .btnc_db(btnc_db), .reg_data2(reg_data2), .out(last_written_value)
    );
    
    mux2to1 LED_MUX (
        .in0(last_written_value), .in1(reg_data2), .sel(btnc_db), .out(led)
    );
    
    
endmodule
