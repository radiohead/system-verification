class ex3_config extends uvm_object;
  `uvm_object_utils(ex3_config);

  // virtual interface for driver, monitor, ...
  virtual ex3_interface vif;

  int iterations;

  function new(string name = "");
    super.new(name);
  endfunction

endclass