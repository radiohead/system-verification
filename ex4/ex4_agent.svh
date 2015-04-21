class ex4_agent extends uvm_component;
  //UVM Factory Registration Macro
  `uvm_component_utils(ex4_agent)

  // Data members
  ex4_agent_config m_cfg;
  // Component Members
  uvm_analysis_port #(ex4_transaction) ap;
  ex4_monitor m_monitor;
  ex4_sequencer m_sequencer;
  ex4_driver m_driver;

  // Methods
  function new(string name = "ex4_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(ex4_agent_config)::get(this, "", "ex4_agent_config", m_cfg))
      `uvm_fatal("CONFIC_LOAD", "Cannot get() configuration ex4_agent_config from uvm_config_db!")

    m_monitor = ex4_monitor::type_id::create("m_monitor", this);

    if(m_cfg.active == UVM_ACTIVE) begin
      m_driver = ex4_driver::type_id::create("m_driver", this);
      m_sequencer = ex4_sequencer::type_id::create("m_sequencer", this);
    end
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    ap = m_monitor.ap;

    if (m_cfg.active == UVM_ACTIVE) begin
      m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    end
  endfunction: connect_phase
endclass: ex4_agent
