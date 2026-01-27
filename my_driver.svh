class my_driver extends uvm_driver #(my_transaction);   
  `uvm_component_utils(my_driver)  
  
  // Declare the interface
  virtual dut_if dut_vif;
                  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 
                
  function void build_phase(uvm_phase phase);
    // Get the interface reference from the config database
    if (!uvm_config_db#(virtual dut_if)::get(this, "", "dut_vif", dut_vif)) begin
      `uvm_error("", "uvm_config_db::get failed")
    end
  endfunction
  
  task run_phase(uvm_phase phase);
    // Apply reset
    dut_vif.reset = 1;
    @(posedge dut_vif.clock);
    @(posedge dut_vif.clock);
    @(posedge dut_vif.clock);
    
    #1;
    dut_vif.reset = 0;
    @(posedge dut_vif.clock);
    @(posedge dut_vif.clock);
    
    // Drive the DUT inputs
    forever begin
      seq_item_port.get_next_item(req);
      
      // Drive on clock edge
      @(posedge dut_vif.clock);
      
      dut_vif.in1 <= req.in1;
      dut_vif.in2 <= req.in2;
      dut_vif.cmd <= req.cmd;
      
      seq_item_port.item_done();
    end
  endtask
                
endclass
