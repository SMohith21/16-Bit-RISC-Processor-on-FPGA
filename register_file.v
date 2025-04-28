`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2025 16:50:48
// Design Name: 
// Module Name: register_file
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


module register_file(
    input clk,
    input reset,
    input reg_write,
    input [3:0] read_reg1,
    input [3:0] read_reg2,
    input [3:0] write_reg,
    input [15:0] write_data,
    output [15:0] read_data1,
    output [15:0] read_data2
);
    reg [15:0] registers [15:0];
    
    // Initialize register values (simulation usage)
    initial begin
       registers[0]  = 16'h0A;
       registers[1]  = 16'h03;
       registers[2]  = 16'h05;
       registers[3]  = 16'h02;
       registers[4]  = 16'h4D;
       registers[5]  = 16'h5E;
       registers[6]  = 16'h6F;
       registers[7]  = 16'h7A;
       registers[8]  = 16'h8B;
       registers[9]  = 16'h9C;
       registers[10] = 16'hAD;
       registers[11] = 16'hBE;
       registers[12] = 16'hCF;
       registers[13] = 16'hDA;
       registers[14] = 16'hEB;
       registers[15] = 16'hFC;
    end
    
    // Synchronous write and asynchronous read
    always @(posedge clk or posedge reset) begin
        if (reset) begin
           registers[0]  <= 16'h0A;
           registers[1]  <= 16'h03;
           registers[2]  <= 16'h05;
           registers[3]  <= 16'h02;
           registers[4]  <= 16'h4D;
           registers[5]  <= 16'h5E;
           registers[6]  <= 16'h6F;
           registers[7]  <= 16'h7A;
           registers[8]  <= 16'h8B;
           registers[9]  <= 16'h9C;
           registers[10] <= 16'hAD;
           registers[11] <= 16'hBE;
           registers[12] <= 16'hCF;
           registers[13] <= 16'hDA;
           registers[14] <= 16'hEB;
           registers[15] <= 16'hFC;
        end else if (reg_write) begin
            registers[write_reg] <= write_data;
        end
    end
    
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];
    
endmodule