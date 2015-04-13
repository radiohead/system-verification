class ex4_config extends uvm_object;
  `uvm_object_utils(ex4_config);

  // virtual interface for driver, monitor, ...
  virtual ex4_interface vif;

  int iterations;

  function new(string name = "");
    super.new(name);
  endfunction

endclass