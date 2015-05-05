class ex5_monitor extends uvm_monitor;
  // devlaration macros
  `uvm_component_utils(ex5_monitor)
  // external interfaces
  uvm_analysis_port #(ex5_transaction) ap;
  // configuration database
  ex5_config m_config;
  // virtual interface
  virtual ex5_interface m_vif;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap", this);

    if (!uvm_config_db #(ex5_config)::get(this, "", "ex5_config", m_config))
      `uvm_fatal("NOCONF",{"Config must be set for: ", get_full_name(), ".m_config"});
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    m_vif = m_config.vif; // set local virtual if property
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    ex5_transaction item;
    item = ex5_transaction::type_id::create("item");

    forever @(posedge m_vif.clock) begin
       item.data = m_vif.data;
       ap.write(item);
    end
  endtask: run_phase
endclass: ex5_monitor
