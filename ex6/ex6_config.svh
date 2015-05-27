class ex6_config extends uvm_object;
  `uvm_object_utils(ex6_config);

  // virtual interface for driver, monitor, ...
  virtual ex6_interface vif;

  int iterations = 2;
  string test_name = "test";

  function new(string name = "");
    super.new(name);
  endfunction

endclass