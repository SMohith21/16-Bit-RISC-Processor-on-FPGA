`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 15:29:10
// Design Name: 
// Module Name: button_debouncer
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


module button_debouncer(
    input clk,
    input reset,
    input btn_in,
    output reg btn_out
);
    // For a 100 MHz clock, for a 20 ms debounce time, N should be 2,000,000 cycles.
    parameter N = 2000000;
    
    // 21 bits needed to count up to 2,000,000 (since 2^21 = 2,097,152)
    reg [20:0] counter;  
    reg btn_sync;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            btn_sync <= 1'b0;
            counter  <= 0;
            btn_out  <= 1'b0;
        end else begin
            if (btn_in != btn_sync) begin
                // New button state detected; reset counter and force output low.
                btn_sync <= btn_in;
                counter  <= 0;
                btn_out  <= 1'b0;
            end else if (counter < N) begin
                counter <= counter + 1;
            end else begin
                // Once the counter exceeds N, update debounced output.
                btn_out <= btn_sync;
            end
        end
    end
endmodule
