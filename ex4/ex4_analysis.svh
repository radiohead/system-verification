class ex4_analysis extends uvm_component;
  `uvm_component_utils(ex4_analysis)

  uvm_analysis_export #(ex4_transaction) _export;
  uvm_tlm_analysis_fifo #(ex4_transaction) _fifo;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    _export = new("_export", this);
    _fifo = new("fifo", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    _export.connect(_fifo.analysis_export);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    ex4_transaction item;

    forever begin
      _fifo.get(item);
      $display("ex4_analysis @ %0t transaction = %p", $time, item.convert2string());
    end
  endtask
endclass: ex4_analysis
