class my_transaction extends uvm_sequence_item;
  `uvm_object_utils(my_transaction)
  
  // Transaction fields
  rand logic [31:0] in1, in2;
  rand logic [3:0]  cmd;   // Randomized ALU command
  
  // Constrain cmd to valid ALU operations [0–8]
  constraint valid_cmd {
    cmd inside {[0:8]};
  }
  
  // Constructor
  function new (string name = "");
    super.new(name);
  endfunction
  
endclass : my_transaction
