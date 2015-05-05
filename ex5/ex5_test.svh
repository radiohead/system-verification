class ex5_test extends uvm_test;
  // declaration macros
  `uvm_component_utils(ex5_test)
  // internal components
  ex5_env m_env;
  // configuration database
  ex5_config m_config;
  ex5_sequence _sequence;
  ex5_agent_config _agent_config;

  function new(string name = "ex5_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void set_config_params();
    m_config = ex5_config::type_id::create("m_config");
    _agent_config = ex5_agent_config::type_id::create("agent_config");

    if(!uvm_config_db #(virtual ex5_interface)::get(this, "uvm_test_top", "top_interface", m_config.vif))
      `uvm_fatal("EX4 TEST", "Can't read VIF");

    if(!uvm_config_db #(virtual ex5_interface)::get(this, "uvm_test_top", "top_interface", _agent_config.vif))
      `uvm_fatal("EX4 TEST", "Can't read VIF");

    m_config.iterations = 10;
    _agent_config.active = UVM_ACTIVE;

    uvm_config_db #(ex5_config)::set(this, "*", "ex5_config", m_config);
    uvm_config_db #(ex5_agent_config)::set(this, "*", "ex5_agent_config", _agent_config);
  endfunction;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    set_config_params();
    set_report_verbosity_level_hier(UVM_MEDIUM);
    m_env = ex5_env::type_id::create("m_env", this);
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    _sequence = ex5_sequence::type_id::create("_sequence");
    phase.raise_objection(this);
      _sequence.start(m_env._sequencer);
    phase.drop_objection(this);

  endtask: run_phase

endclass