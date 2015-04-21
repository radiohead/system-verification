class ex4_agent_config extends uvm_object;
  `uvm_object_utils(ex4_agent_config)
 
  // Virtual Interface
  virtual ex4_interface vif;
 
  // Is the agent active or passive
  uvm_active_passive_enum active = UVM_ACTIVE;

  function new(string name = "ex4_agent_config");
   super.new(name);
  endfunction

endclass: ex4_agent_config