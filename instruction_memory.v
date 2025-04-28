`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2025 16:53:30
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(
   input [15:0] address,
   output [15:0] instruction
);
   // Memory array with at least 64 locations.
   reg [15:0] mem [0:63];
   
   initial begin
       $readmemb("instructions.mem", mem);
   end
   
   // Since each instruction is 2 bytes, use address/2.
   assign instruction = mem[address[15:1]];
   
endmodule

