class ex5_config extends uvm_object;
  `uvm_object_utils(ex5_config);

  // virtual interface for driver, monitor, ...
  virtual ex5_interface vif;

  int iterations;

  function new(string name = "");
    super.new(name);
  endfunction

endclass