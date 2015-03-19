class ex1_driver extends uvm_component;
  `uvm_component_utils(ex1_driver)
  
  virtual ex1_interface _interface;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual ex1_interface)::get(this, "", "top_interface", _interface))
      `uvm_fatal("NOVIF", "Failed to instantiate the interface in the driver!");
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    forever begin @(posedge _interface.clock)
      _interface.data <= "10000000";
    end
  endtask: run_phase
endclass: ex1_driver
