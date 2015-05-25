class ex6_monitor extends uvm_monitor;
  // devlaration macros
  `uvm_component_utils(ex6_monitor)
  // external interfaces
  uvm_analysis_port #(ex6_transaction) ap;
  // configuration database
  ex6_config m_config;
  // virtual interface
  virtual ex6_interface m_vif;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap", this);

    if (!uvm_config_db #(ex6_config)::get(this, "", "ex6_config", m_config))
      `uvm_fatal("NOCONF",{"Config must be set for: ", get_full_name(), ".m_config"});
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    m_vif = m_config.vif; // set local virtual if property
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    ex6_transaction item;
    item = ex6_transaction::type_id::create("item");

    forever @(posedge m_vif.clock) begin
       item.value1 = m_vif.value1;
       item.value2 = m_vif.value2;
       item.mode = m_vif.mode;
       ap.write(item);
    end
  endtask: run_phase
endclass: ex6_monitor
