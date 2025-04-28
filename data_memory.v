`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2025 16:54:00
// Design Name: 
// Module Name: data_memory
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


module data_memory(
   input clk,
   input mem_read,
   input mem_write,
   input [15:0] address,
   input [15:0] write_data,
   output reg [15:0] read_data
);
   // Memory array with 64 words of 16 bits each.
   reg [15:0] mem [0:63];
   integer i;
   
   initial begin
      // Initialize memory contents. For this example, each location is set to its index.
      for (i = 0; i < 64; i = i + 1)
         mem[i] = i;
   end
   
   // Write operation: the data is written on the rising edge of clk when mem_write is asserted.
   always @(posedge clk) begin
       if (mem_write)
           mem[address[15:1]] <= write_data;
   end
   
   // Synchronous read operation: read_data is updated on the rising edge of clk.
   always @(posedge clk) begin
       if (mem_read)
           read_data <= mem[address[15:1]];
       else
           read_data <= 16'd0;
   end
endmodule
