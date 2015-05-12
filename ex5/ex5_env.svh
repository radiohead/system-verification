class ex5_env extends uvm_env;
  `uvm_component_utils(ex5_env)

  ex5_driver _driver;
  ex5_sequencer _sequencer;
  ex5_agent _agent;
  ex5_analysis _analysis;
  ex5_scoreboard _sb;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // _driver = ex5_driver::type_id::create("_driver", this);
    // _sequencer = ex5_sequencer::type_id::create("_sequencer", this);

    _agent = ex5_agent::type_id::create("ex5_agent", this);
    _analysis = ex5_analysis::type_id::create("ex5_analysis", this);
    _sb = ex5_scoreboard::type_id::create("sb", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    _sequencer = _agent.m_sequencer;
    _driver = _agent.m_driver;

    _agent.output_analysis_port.connect(_analysis._export);
    _agent.input_analysis_port.connect(_analysis._import);

    _agent.output_analysis_port.connect(_sb.axp_out);
    _agent.input_analysis_port.connect(_sb.axp_in);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    uvm_top.print_topology();
  endtask: run_phase
endclass: ex5_env
