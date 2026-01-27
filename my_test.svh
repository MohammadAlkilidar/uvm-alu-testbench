class my_test extends uvm_test;
  `uvm_component_utils(my_test)
  
  my_sequence seq;
  my_env      env;
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    env = my_env::type_id::create("env", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    seq = my_sequence::type_id::create("seq");
    seq.start(env.agent.sequencer);
    
    #20;
    
    phase.drop_objection(this);
  endtask
  
endclass : my_test
