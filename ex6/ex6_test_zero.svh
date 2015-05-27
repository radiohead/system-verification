class ex6_test_zero extends uvm_test;
  // declaration macros
  `uvm_component_utils(ex6_test_zero)
  // internal components
  ex6_env m_env;
  // configuration database
  ex6_config m_config;
  ex6_sequence _sequence;
  ex6_agent_config _agent_config;

  function new(string name = "ex6_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void set_config_params();
    m_config = ex6_config::type_id::create("m_config");
    _agent_config = ex6_agent_config::type_id::create("agent_config");

    if(!uvm_config_db #(virtual ex6_interface)::get(this, "uvm_test_top", "top_interface", m_config.vif))
      `uvm_fatal("ex5 TEST", "Can't read VIF");

    if(!uvm_config_db #(virtual ex6_interface)::get(this, "uvm_test_top", "top_interface", _agent_config.vif))
      `uvm_fatal("ex5 TEST", "Can't read VIF");

    m_config.test_name = "test_zero";
    _agent_config.active = UVM_ACTIVE;

    uvm_config_db #(ex6_config)::set(uvm_root::get(), "*", "ex6_config", m_config);
    uvm_config_db #(ex6_agent_config)::set(this, "*", "ex6_agent_config", _agent_config);
  endfunction;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    set_config_params();
    // set_report_verbosity_level_hier(UVM_MEDIUM);
    m_env = ex6_env::type_id::create("m_env", this);
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    _sequence = ex6_sequence::type_id::create("_sequence");
    phase.raise_objection(this);
      _sequence.start(m_env._sequencer);
    phase.drop_objection(this);

  endtask: run_phase

endclass