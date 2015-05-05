class ex5_agent_config extends uvm_object;
  `uvm_object_utils(ex5_agent_config)
 
  // Virtual Interface
  virtual ex5_interface vif;
 
  // Is the agent active or passive
  uvm_active_passive_enum active = UVM_ACTIVE;

  function new(string name = "ex5_agent_config");
   super.new(name);
  endfunction

endclass: ex5_agent_config