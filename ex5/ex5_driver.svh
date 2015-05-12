class ex5_driver extends uvm_driver #(ex5_transaction);
  `uvm_component_utils(ex5_driver)

  // virtual interface
  virtual ex5_interface _interface;
  // configuration database
  ex5_config m_config;
  // Number of iterations
  int _iterations;
  uvm_analysis_port #(ex5_transaction) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);

    ap = new("ap", this);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db #(ex5_config)::get(this, "", "ex5_config", m_config))
      `uvm_fatal("NOCONFIG", "Failed to get configuration object from driver!");
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    _interface = m_config.vif; //set local virtual if property
    _iterations = m_config.iterations;
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    ex5_transaction req_item, req_item_clone;

    repeat(_iterations) begin @(posedge _interface.clock)
      if (!_interface.reset) begin
        seq_item_port.get_next_item(req_item);
        // Send next sequence item
        _interface.data = req_item.data;
        ap.write(req_item);
        seq_item_port.item_done();
      end
    end
  endtask: run_phase
endclass: ex5_driver
