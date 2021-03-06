class ex3_driver extends uvm_driver #(ex3_transaction);
  `uvm_component_utils(ex3_driver)

  // virtual interface
  virtual ex3_interface _interface;
  // configuration database
  ex3_config m_config;
  // Number of iterations
  int _iterations;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db #(ex3_config)::get(this, "", "ex3_config", m_config))
      `uvm_fatal("NOCONFIG", "Failed to get configuration object from driver!");
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    _interface = m_config.vif; //set local virtual if property
    _iterations = m_config.iterations;
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    ex3_transaction req_item;
    repeat(_iterations)
    begin
     @(posedge _interface.clock)
      if(!_interface.reset) begin
        seq_item_port.try_next_item(req_item);

        if (req_item == null) //send idle pattern
          _interface.data <= "00000000";
        else begin//send next sequence item
          $display("ex3_driver @ %0t transaction = %p", $time, req_item.convert2string());
          _interface.data <= req_item.data;
          seq_item_port.item_done();
        end
      end
      else _interface.reset <= 1; //reset dut

    end
  endtask: run_phase
endclass: ex3_driver
