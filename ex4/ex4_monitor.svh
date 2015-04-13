class ex4_monitor extends uvm_monitor;
  // devlaration macros
  `uvm_component_utils(ex4_monitor)
  // external interfaces
  uvm_analysis_port #(ex4_rsp) rsp_ap;
  // internal variables
  ex4_rsp mon_tr, t;
  // configuration database
  ex4_config m_config;
  // virtual interface
  virtual ex4_interface m_vif;

  function new (string name, uvm_component parent);
    super.new(name, parent);
    mon_tr = new();
    t = new();
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rsp_ap = new("rsp_ap", this);

    if(!uvm_config_db#(virtual ex3_interface)::get(this, "", "top_pif", m_vif))
      `uvm_fatal("NOVIF",{"virtual interface must be set for: ", get_full_name(), ".vif"});

  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    m_vif = m_config.vif; // set local virtual if property
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    monitor_dut;
  endtask: run_phase

  task monitor_dut();

endclass: ex4_monitor