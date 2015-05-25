class ex6_env extends uvm_env;
  `uvm_component_utils(ex6_env)

  ex6_driver _driver;
  ex6_sequencer _sequencer;
  ex6_agent _agent;
  ex6_analysis _analysis;
  ex6_scoreboard _sb;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    _agent = ex6_agent::type_id::create("ex6_agent", this);
    _analysis = ex6_analysis::type_id::create("ex6_analysis", this);
    _sb = ex6_scoreboard::type_id::create("sb", this);
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
endclass: ex6_env
