class ex3_test extends uvm_test;
  // declaration macros
  `uvm_component_utils(ex3_test)
  // internal components
  ex3_env m_env;
  // configuration database
  ex3_config m_config;

  ex3_sequence _sequence;

  function new(string name = "ex3_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void set_config_params();
    m_config = ex3_config::type_id::create("m_config");

    if(!uvm_config_db #(virtual ex3_interface)::get(this, "uvm_test_top", "top_interface", m_config.vif))
      `uvm_fatal("EX3 TEST", "Can't read VIF");

    m_config.iterations = 10;

    uvm_config_db #(ex3_config)::set(this, "*", "ex3_config", m_config);
  endfunction;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    set_config_params();
    set_report_verbosity_level_hier(UVM_MEDIUM);
    m_env = ex3_env::type_id::create("m_env", this);
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    _sequence = ex3_sequence::type_id::create("_sequence");
    phase.raise_objection(this);
      _sequence.start(m_env._sequencer);
    phase.drop_objection(this);

  endtask: run_phase

endclass