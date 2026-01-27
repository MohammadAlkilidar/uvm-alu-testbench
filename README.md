# UVM ALU Verification Testbench

This project implements a SystemVerilog/UVM testbench for verifying a 32-bit ALU with opcode-based operations.  
The environment follows a standard UVM structure using transactions, sequences, drivers, a sequencer, an agent, an environment, and a test.

The DUT accepts two 32-bit operands (in1, in2) and a 4-bit command (cmd) selecting one of nine operations.

-------------------------------------------------------------------------------

## Features
- Full UVM infrastructure:
  my_transaction
  my_sequence
  my_driver
  my_agent
  my_env
  my_test
- Constrained-random stimulus for (in1, in2, cmd)
- 16 randomized transactions per simulation run
- Interface with dedicated DUT and TEST modports
- Synchronous clock/reset generation
- VCD waveform dumping for debugging
- Modular structure ready for monitors, scoreboards, and coverage

-------------------------------------------------------------------------------

## ALU Operations
cmd (binary) | Operation     | Description
0000         | AND           | in1 & in2
0001         | OR            | in1 | in2
0010         | ADD           | in1 + in2
0100         | SUB           | in1 - in2
1000         | LESS THAN     | result = (in1 < in2)
0011         | SHIFT LEFT    | in1 << in2
0101         | SHIFT RIGHT   | in1 >> in2
0110         | MULTIPLY      | in1 * in2
0111         | XOR           | in1 ^ in2

-------------------------------------------------------------------------------

## Constrained-Random Inputs
The cmd field is constrained to valid opcode values:

constraint valid_cmd {
  cmd inside {[0:8]};
}

Each transaction randomizes:
  in1  = 32-bit value
  in2  = 32-bit value
  cmd  = value in range 0–8

-------------------------------------------------------------------------------

## Waveform Dump
The top-level testbench generates a VCD file:

$dumpfile("dump.vcd");
$dumpvars(0, top);

-------------------------------------------------------------------------------

## How to Run

EDAPlayground:
  1. Upload all .sv and .svh files
  2. Select a UVM simulator (Aldec Riviera-PRO, Synopsys VCS, etc.)
  3. Click Run

Questa/ModelSim:
  vlog *.sv *.svh
  vsim top -do "run -all"

-------------------------------------------------------------------------------

## Project Structure
design.sv
testbench.sv
my_transaction.svh
my_sequence.svh
my_driver.svh
my_agent.svh
my_env.svh
my_test.svh
my_testbench_pkg.svh

-------------------------------------------------------------------------------

## Notes
This is a foundational UVM testbench that can be expanded with:
- Monitors
- Scoreboards
- Functional coverage
- Assertions
- UVM Register Model (RAL)
- Callback support
