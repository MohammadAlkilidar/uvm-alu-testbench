# UVM ALU Verification Testbench

This project implements a SystemVerilog/UVM testbench for verifying a 32-bit ALU with opcode-based operations.  
The environment follows a standard UVM structure using transactions, sequences, drivers, a sequencer, an agent, an environment, and a test.

The DUT accepts two 32-bit operands (in1, in2) and a 4-bit command (cmd) selecting one of nine operations.  
The updated testbench now uses UVM configuration database parameters to control randomization ranges and the number of generated transactions.

-------------------------------------------------------------------------------

## Features
- Full UVM infrastructure:  
  my_transaction  
  my_sequence  
  my_driver  
  my_agent  
  my_env  
  my_test  
- Constrained-random stimulus for (in1, in2, cmd) using inline constraints in the sequence  
- Runtime-configurable number of transactions (`num_repeat`)  
- Configurable operand value range (`min`, `max`)  
- Configurable opcode range (`min_cmd`, `max_cmd`), supporting single-opcode mode  
- Interface with dedicated DUT and TEST modports  
- Synchronous clock/reset generation  
- VCD waveform dumping for debugging  
- Modular structure ready for monitors, scoreboards, and coverage

-------------------------------------------------------------------------------

## ALU Operations

| cmd (binary) | Operation     | Description        |
|--------------|---------------|--------------------|
| 0000         | AND           | in1 & in2          |
| 0001         | OR            | in1 \| in2         |
| 0010         | ADD           | in1 + in2          |
| 0100         | SUB           | in1 - in2          |
| 1000         | LESS THAN     | result = (in1 < in2) |
| 0011         | SHIFT LEFT    | in1 << in2         |
| 0101         | SHIFT RIGHT   | in1 >> in2         |
| 0110         | MULTIPLY      | in1 * in2          |
| 0111         | XOR           | in1 ^ in2          |

-------------------------------------------------------------------------------

## Constrained-Random Inputs

The transaction class defines the randomized fields:

class my_transaction extends uvm_sequence_item;  
  `uvm_object_utils(my_transaction)  

  rand logic [31:0] in1, in2;  
  rand logic [3:0]  cmd;  

  function new (string name = "");  
    super.new(name);  
  endfunction  

endclass : my_transaction

Unlike earlier versions, **this class no longer hard-constrains cmd**.  
All constraints are now driven by the sequence using configuration parameters from the UVM config DB:

- `min`, `max` control in1/in2  
- `min_cmd`, `max_cmd` control cmd  
- `num_repeat` determines how many transactions run

Each transaction randomizes with inline constraints based on these values.

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
  vlog \*.sv \*.svh  
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
This enhanced UVM testbench uses UVM configuration database control to support flexible and targeted constrained-random verification.  
It can be expanded with:  
- Monitors  
- Scoreboards  
- Functional coverage  
- Assertions  
- UVM Register Model (RAL)  
- Callback support  
