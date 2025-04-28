module pc_control_unit(
    input [15:0] pc,
    input [15:0] imm,
    input jump,
    input branch,
    input branch_not_equal,
    input alu_zero,
    input [11:0] jmp_offset_raw,
    output [15:0] pc_next
);
    wire [15:0] pc_plus_2 = pc + 16'd2;
    wire [15:0] branch_offset = imm << 1;
    wire [15:0] branch_target = pc_plus_2 + branch_offset;
    wire branch_taken = branch & (branch_not_equal ? ~alu_zero : alu_zero);

    wire [15:0] jump_offset = {{4{jmp_offset_raw[11]}}, jmp_offset_raw} << 1;
    wire [15:0] jump_target = pc_plus_2 + jump_offset;

    assign pc_next = jump ? jump_target : (branch_taken ? branch_target : pc_plus_2);
endmodule