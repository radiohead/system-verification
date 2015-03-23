class ex2_env extends uvm_env;
  `uvm_component_utils(ex2_env)
  
  ex2_driver _driver;
  ex2_sequencer _sequencer;
  ex2_sequence _sequence;
  
  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    _driver = ex2_driver::type_id::create("_driver", this);
    _sequencer = ex2_sequencer::type_id::create("_sequencer", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    _driver.seq_item_port.connect(_sequencer.seq_item_export);
  endfunction: connect_phase
  
  task run_phase(uvm_phase phase);
    _sequence = ex2_sequence::type_id::create("_sequence");
    phase.raise_objection(this);
      _sequence.start(_sequencer);
    phase.drop_objection(this);

    uvm_top.print_topology();
  endtask: run_phase
endclass: ex2_env
