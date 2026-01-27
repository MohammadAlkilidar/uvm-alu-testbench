class my_agent extends uvm_agent;
  `uvm_component_utils(my_agent)
  
  // Create component handles
  my_driver driver;
  uvm_sequencer#(my_transaction) sequencer;
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    driver    = my_driver::type_id::create("driver", this);
    sequencer = uvm_sequencer#(my_transaction)::type_id::create("sequencer", this);
  endfunction 
  
  function void connect_phase(uvm_phase phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction 
    
endclass : my_agent
