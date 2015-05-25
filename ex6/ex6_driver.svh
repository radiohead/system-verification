class ex6_driver extends uvm_driver #(ex6_transaction);
  `uvm_component_utils(ex6_driver)

  // virtual interface
  virtual ex6_interface _interface;
  // configuration database
  ex6_config m_config;
  // Number of iterations
  int _iterations;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db #(ex6_config)::get(this, "", "ex6_config", m_config))
      `uvm_fatal("NOCONFIG", "Failed to get configuration object from driver!");
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    _interface = m_config.vif; //set local virtual if property
    _iterations = m_config.iterations;
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    ex6_transaction req_item;
    repeat(_iterations)
    begin
     @(posedge _interface.clock)
      if(!_interface.reset) begin
        seq_item_port.try_next_item(req_item);

        if (req_item == null) //send idle pattern
          _interface.value1 <= 0;
          _interface.value2 <= 0;
          _interface.mode <= ADD;
        else begin//send next sequence item
          $display("ex6_driver @ %0t transaction = %p", $time, req_item.convert2string());
          _interface.value1 <= req_item.value1;
          _interface.value2 <= req_item.value2;
          _interface.mode <= req_item.mode;
          seq_item_port.item_done();
        end
      end
      else _interface.reset <= 1; //reset dut

    end
  endtask: run_phase
endclass: ex6_driver
