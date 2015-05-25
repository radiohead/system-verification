class ex5_agent extends uvm_component;
  //UVM Factory Registration Macro
  `uvm_component_utils(ex5_agent)

  // Data members
  ex5_agent_config m_cfg;

  // Component Members
  uvm_analysis_port #(ex5_transaction) input_analysis_port;
  uvm_analysis_port #(ex5_transaction) output_analysis_port;

  ex5_monitor m_monitor;
  ex5_sequencer m_sequencer;
  ex5_driver m_driver;

  // Methods
  function new(string name = "ex5_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(ex5_agent_config)::get(this, "", "ex5_agent_config", m_cfg))
      `uvm_fatal("CONFIC_LOAD", "Cannot get() configuration ex5_agent_config from uvm_config_db!")

    m_monitor = ex5_monitor::type_id::create("m_monitor", this);

    if (m_cfg.active == UVM_ACTIVE) begin
      m_driver = ex5_driver::type_id::create("m_driver", this);
      m_sequencer = ex5_sequencer::type_id::create("m_sequencer", this);
    end
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    output_analysis_port = m_monitor.ap;
    input_analysis_port = m_driver.ap;

    if (m_cfg.active == UVM_ACTIVE) begin
      m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    end
  endfunction: connect_phase
endclass: ex5_agent
