`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2025 16:57:43
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [3:0] opcode,
    input [3:0] func,
    output reg alu_src,
    output reg mem_to_reg,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg branch_not_equal,
    output reg jump,
    output reg [1:0] alu_op
);
   always @(*) begin
       // Default assignments
       alu_src    = 0;
       mem_to_reg = 0;
       reg_write  = 0;
       mem_read   = 0;
       mem_write  = 0;
       branch     = 0;
       jump       = 0;
       alu_op     = 2'b00;
       branch_not_equal = 0;
       
       case(opcode)
           4'b0000: begin  // R-type instructions
              reg_write = 1;
              // alu_src remains 0, mem_to_reg = 0
              case(func)
                  4'b0000: alu_op = 2'b00; // add
                  4'b0001: alu_op = 2'b01; // sub
                  4'b0010: alu_op = 2'b10; // sll
                  4'b0011: alu_op = 2'b11; // and
                  default: alu_op = 2'b00;
              endcase
           end
           4'b0001: begin  // lw
              alu_src    = 1;
              mem_to_reg = 1;
              reg_write  = 1;
              mem_read   = 1;
              alu_op     = 2'b00; // add for effective address
           end
           4'b0010: begin  // sw
              alu_src    = 1;
              mem_write  = 1;
              alu_op     = 2'b00; // add for effective address
           end
           4'b0011: begin  // addi
              alu_src    = 1;
              reg_write  = 1;
              alu_op     = 2'b00; // add
           end
           4'b0100: begin  // beq
              branch     = 1;
              alu_op     = 2'b01; // sub to compare
              branch_not_equal = 0;
           end
           4'b0101: begin  // bne
              branch     = 1;
              alu_op     = 2'b01; // sub to compare (inversion handled in branch decision)
              branch_not_equal = 1;
           end
           4'b0110: begin  // jmp
              jump       = 1;
              // No register or memory operation required.
           end
           default: begin
              // For undefined opcodes, all controls remain 0.
           end
       endcase
   end
endmodule

