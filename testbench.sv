`include "uvm_macros.svh"
`include "my_testbench_pkg.svh"

module top;
  import uvm_pkg::*;
  import my_testbench_pkg::*;
  
  bit clock;
  
  // Instantiate the interface
  dut_if dut_if1(clock);
  
  // Instantiate the DUT and connect it to the interface
  dut dut1(.clock(dut_if1.clock),
           .reset(dut_if1.reset), 
           .in1(dut_if1.in1), 
           .in2(dut_if1.in2),
           .cmd(dut_if1.cmd),
           .result(dut_if1.result));
  
  // Generate the clock
  initial begin 
    clock = 0;
    forever #5 clock = ~clock;
  end 
           
  initial begin 
    // Place interface into the UVM configuration database
    uvm_config_db#(virtual dut_if)::set(null, "*", "dut_vif", dut_if1);
    
    // Start the test
    run_test("my_test");
  end 
  
  initial begin 
    `uvm_info("TESTTOP", "My first UVM testbench!", UVM_NONE);
  end 
  
  // Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, top);
  end 
  
endmodule
