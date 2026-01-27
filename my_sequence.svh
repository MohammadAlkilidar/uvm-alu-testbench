class my_sequence extends uvm_sequence#(my_transaction);

  // Register with the factory
  `uvm_object_utils(my_sequence)
  
  // Constructor
  function new (string name = "");
    super.new(name);
  endfunction
  
  task body;
    repeat(16) begin
      
      req = my_transaction::type_id::create("req");
      
      start_item(req);
      
      if (!req.randomize()) begin
        `uvm_error("MY_SEQUENCE", "randomize() failed");
      end 
      
      finish_item(req);
      
    end
  endtask : body
    
endclass : my_sequence
