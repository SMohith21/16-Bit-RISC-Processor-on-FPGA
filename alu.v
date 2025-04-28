`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2025 16:49:37
// Design Name: 
// Module Name: alu
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


module alu(
   input [15:0] a,
   input [15:0] b,
   input [1:0] alu_op,
   output reg [15:0] result,
   output zero
);
   always @(*) begin
       case(alu_op)
           2'b00: result = a + b;               // add (also used for addi, lw, sw)
           2'b01: result = a - b;               // sub (and branch compare)
           2'b10: result = b << a[3:0];         // sll (shift left by lower 4 bits of b)
           2'b11: result = a & b;               // and
           default: result = 16'd0;
       endcase
   end
   assign zero = (result == 16'd0);
endmodule

