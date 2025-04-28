# 16-Bit RISC Processor on FPGA

## Project Overview

This project involves the design and implementation of a 16-bit single-cycle, non-pipelined RISC processor, written entirely in structural Verilog and deployed on FPGA hardware (Basys 3 board).  
The processor supports R-type, I-type, and J-type instructions and is capable of fetching, decoding, executing, memory access, and writing back results.  

All modules including control path, data path, ALU, register file, program counter, memory, and I/O interface were implemented individually and connected structurally.  
The processor was verified through both simulation and hardware testing.

---

## Features

- 16-bit wide datapath and instruction word.
- Support for arithmetic, logical, load/store, branch, and jump instructions.
- Structural Verilog design (strict modular connection, no behavioral shortcuts).
- Single-cycle execution model (each instruction completes in one cycle).
- Button-driven instruction stepping on FPGA hardware.
- Real-time LED display of register values during and after execution.
- Full integration of control unit, ALU, register file, program counter, and memory.
- Testbenches for individual modules and integrated system simulation.
- Synthesized and tested on Xilinx Basys 3 FPGA board.

---

## Processor Architecture

The processor operates in five major stages:

1. **Instruction Fetch**:  
   The Program Counter (PC) fetches the current instruction from the instruction memory.

2. **Instruction Decode**:  
   The Control Unit interprets the opcode and function codes, setting control signals accordingly.

3. **Execution**:  
   The ALU performs computations using operands from the Register File or an immediate value.

4. **Memory Access**:  
   For load and store instructions, the Data Memory module reads or writes data.

5. **Write Back**:  
   Results from the ALU or memory are written back into the Register File.

Additional supporting modules include:
- Button debounce controller and start latch for manual instruction stepping.
- Last written value tracker for debugging via LEDs.
- Sign extension for immediate values.

---

## Instruction Set Summary

| Instruction Type | Operations Supported |
|:-----------------|:----------------------|
| **R-Type**        | ADD, SUB, SLL, AND |
| **I-Type**        | LW, SW, ADDI, BEQ, BNE |
| **J-Type**        | JMP |

---

## Folder Structure

- `src/` : All Verilog source modules.
- `tb/` : Testbenches for unit simulation.
- `bitstream/` : Generated FPGA bitstream files.
- `docs/` : Documentation and schematics.
- `instructions.mem` : Program memory file in binary.

---

## Simulation Instructions

1. Open the project in **Xilinx Vivado**.
2. Load the testbench files for each module (`*_tb.v`).
3. Set the appropriate testbench as the top module.
4. Run behavioral simulation.
5. Verify waveform outputs against expected control signals and datapath behavior.

Each major component (ALU, Register File, PC Control Unit, etc.) has its own testbench verifying individual functionality.

---

## Hardware Deployment (FPGA)

1. Set `top_module.v` as the top module.
2. Synthesize the design.
3. Implement the design.
4. Generate the bitstream (`.bit`) file.
5. Connect the Basys 3 FPGA board via USB.
6. Program the FPGA with the generated bitstream.

### Usage on FPGA:

- Press **BTNC** (Center Button) to step through instructions.
- **Hold** BTNC to view pre-instruction register value.
- **Release** BTNC to execute instruction and update LED outputs.
- Press **BTNR** (Right Button) to reset the processor (clear PC, register file, memory).

LEDs display register data in binary (MSB on leftmost LED).
