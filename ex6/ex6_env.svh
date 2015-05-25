class ex6_env extends uvm_env;
  `uvm_component_utils(ex6_env)

  ex6_driver _driver;
  ex6_sequencer _sequencer;
  ex6_agent _agent;
  ex6_analysis _analysis;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    _driver = ex6_driver::type_id::create("_driver", this);
    _sequencer = ex6_sequencer::type_id::create("_sequencer", this);

    _agent = ex6_agent::type_id::create("ex6_agent", this);
    _analysis = ex6_analysis::type_id::create("ex6_analysis", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    _driver.seq_item_port.connect(_sequencer.seq_item_export);
    _agent.ap.connect(_analysis._export);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    uvm_top.print_topology();
  endtask: run_phase
endclass: ex6_env
