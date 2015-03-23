class ex2_driver extends uvm_driver #(ex2_transaction);
  `uvm_component_utils(ex2_driver)
  
  virtual ex2_interface _interface;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual ex2_interface)::get(this, "", "top_interface", _interface))
      `uvm_fatal("NOVIF", "Failed to instantiate the interface in the driver!");
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    ex2_transaction req_item;
    repeat(10) 
    begin 
     @(posedge _interface.clock)
      if(!_interface.reset) begin
        seq_item_port.try_next_item(req_item);

        if (req_item == null) //send idle pattern
          _interface.data <= "00000000";
        else begin//send next sequence item
          $display("ex2_driver @ %0t transaction = %p", $time, req_item.convert2string());
          _interface.data <= req_item.data;
          seq_item_port.item_done();
        end
      end
      else _interface.reset <= 1; //reset dut

    end
  endtask: run_phase
endclass: ex2_driver
