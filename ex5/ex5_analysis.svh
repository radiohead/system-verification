class ex5_analysis extends uvm_component;
  `uvm_component_utils(ex5_analysis)

  uvm_analysis_export #(ex5_transaction) _export;
  uvm_analysis_export #(ex5_transaction) _import;

  uvm_tlm_analysis_fifo #(ex5_transaction) _fifo_in;
  uvm_tlm_analysis_fifo #(ex5_transaction) _fifo_out;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    _export = new("_export", this);
    _fifo_in = new("_fifo_in", this);

    _import = new("_import", this);
    _fifo_out = new("_fifo_out", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    _export.connect(_fifo_in.analysis_export);
    _import.connect(_fifo_out.analysis_export);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    ex5_transaction item;

    forever begin
      _fifo_in.get(item);
      $display("ex5_analysis: %p", $time, item.convert2string());
      _fifo_out.get(item);
      $display("ex5_analysis: %p", $time, item.convert2string());
    end
  endtask
endclass: ex5_analysis
