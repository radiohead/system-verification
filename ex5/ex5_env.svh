class ex5_env extends uvm_env;
  `uvm_component_utils(ex5_env)

  ex5_driver _driver;
  ex5_sequencer _sequencer;
  ex5_agent _agent;
  ex5_analysis _analysis;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    _driver = ex5_driver::type_id::create("_driver", this);
    _sequencer = ex5_sequencer::type_id::create("_sequencer", this);

    _agent = ex5_agent::type_id::create("ex5_agent", this);
    _analysis = ex5_analysis::type_id::create("ex5_analysis", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    _driver.seq_item_port.connect(_sequencer.seq_item_export);
    _agent.ap.connect(_analysis._export);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    uvm_top.print_topology();
  endtask: run_phase
endclass: ex5_env
