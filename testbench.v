`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2025 16:59:06
// Design Name: 
// Module Name: testbench
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


module testbench;
    reg clk;
    reg reset;
    
    // Instantiate the top module
    top_module uut(
        .clk(clk),
        .reset(reset)
    );
    
    // Generate a clock with a period of 10 ns
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;

        // Hold reset for a few cycles
        #10 reset = 0;
        
        // Run simulation for a longer time to observe effects
        #2000 $finish;
    end
    
    initial begin
        $monitor("Time=%0t | PC=%h | Instruction=%b | ALU Result=%h | rd_rt=%h | rs=%h | reg_write=%h | Mem=%h", 
                  $time, uut.pc, uut.instruction, uut.ALU_inst.result, uut.RF.read_reg1, uut.RF.read_reg2, uut.RF.write_data, uut.DM.mem[2]);
    end
    // Monitor PC and Instruction from the top module
   
endmodule


