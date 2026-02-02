class my_sequence extends uvm_sequence#(my_transaction);
  //register to the factory
  //uvm_object
  `uvm_object_utils(my_sequence)
  
  int num_repeat;
  int max;
  int min;
  int max_cmd;
  int min_cmd;
  
  //constructor for uvm_object
  function new (string name = "");
    super.new(name);
  endfunction
  
  task body;
    
    if (!uvm_config_db#(int)::exists(null, "", "num_repeat"))
      `uvm_error("SEQ","Couldn't find num_repeat");
    
    uvm_config_db#(int)::get(null, "", "num_repeat", num_repeat);
    uvm_config_db#(int)::get(null, "", "max",       max);
    uvm_config_db#(int)::get(null, "", "min",       min);
    uvm_config_db#(int)::get(null, "", "max_cmd",   max_cmd);
    uvm_config_db#(int)::get(null, "", "min_cmd",   min_cmd);
    
    repeat(num_repeat) begin
      
      req = my_transaction::type_id::create("req");
      
      start_item(req);
      
      if (!req.randomize() with {
        
        req.in1 >= min; 
        req.in1 <= max; 
        
        req.in2 >= min;
        req.in2 <= max; 
        
        req.cmd >= min_cmd;
        req.cmd <= max_cmd;
        
      }) begin
        `uvm_error("MY_SEQUENCE", "randomize() failed");
      end  
      
      finish_item(req);
      
    end
  endtask : body
    
endclass : my_sequence
