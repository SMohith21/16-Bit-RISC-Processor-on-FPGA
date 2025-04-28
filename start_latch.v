`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2025 09:11:14
// Design Name: 
// Module Name: start_latch
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


module start_latch(
    input clk,
    input reset,
    input btnc_pressed,
    output enable_execution
);
    reg started;
    always @(posedge clk or posedge reset) begin
        if (reset)
            started <= 0;
        else if (btnc_pressed)
            started <= 1;
    end

    assign enable_execution = started & btnc_pressed;
endmodule