class ex1_env extends uvm_env;
  `uvm_component_utils(ex1_env)
  
  ex1_driver _driver;
  
  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    _driver = ex1_driver::type_id::create("_driver", this);
  endfunction: build_phase
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
      #200;
    phase.drop_objection(this);

    uvm_top.print_topology();
  endtask: run_phase
endclass: ex1_env
