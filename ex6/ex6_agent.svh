class ex6_agent extends uvm_component;
  //UVM Factory Registration Macro
  `uvm_component_utils(ex6_agent)

  // Data members
  ex6_agent_config m_cfg;

  // Component Members
  uvm_analysis_port #(ex6_transaction) input_analysis_port;
  uvm_analysis_port #(ex6_transaction) output_analysis_port;

  ex6_monitor m_monitor;
  ex6_sequencer m_sequencer;
  ex6_driver m_driver;

  // Methods
  function new(string name = "ex6_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(ex6_agent_config)::get(this, "", "ex6_agent_config", m_cfg))
      `uvm_fatal("CONFIC_LOAD", "Cannot get() configuration ex6_agent_config from uvm_config_db!")

    m_monitor = ex6_monitor::type_id::create("m_monitor", this);

    if (m_cfg.active == UVM_ACTIVE) begin
      m_driver = ex6_driver::type_id::create("m_driver", this);
      m_sequencer = ex6_sequencer::type_id::create("m_sequencer", this);
    end
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    output_analysis_port = m_monitor.ap;
    input_analysis_port = m_driver.ap;

    if (m_cfg.active == UVM_ACTIVE) begin
      m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    end
  endfunction: connect_phase
endclass: ex6_agent
