class ex5_scoreboard extends uvm_component;
  `uvm_component_utils(ex5_scoreboard)

  uvm_analysis_export #(ex5_transaction) before_export, after_export;

  protected uvm_tlm_analysis_fifo #(ex5_transaction) before_fifo, after_fifo;

  int error_cnt, op_cnt;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    before_export = new("before_export", this);
    after_export = new("after_export", this);

    before_fifo = new("before", this);
    after_fifo = new("after", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    before_export.connect(before_fifo.analysis_export);
    after_export.connect(after_fifo.analysis_export);
  endfunction

  task run_phase(uvm_phase phase);
    string st1, st2, st3;
    ex5_transaction stim_txn;
    ex5_transaction result_txn;
    forever begin
      before_fifo.get(stim_txn);
      after_fifo.get(result_txn);
      op_cnt++;

      if ( stim_txn.result == result_txn.result)
        `uvm_info("SB",
            $sformatf("Received correct result for ex5_transaction %0d, mode %s ",
          result_txn.get_transaction_id(), 
          result_txn.mode.name()), UVM_LOW)
      else begin
        st1 = $sformatf("Received incorrect result for ex5_transaction %0d, \n",stim_txn.get_transaction_id());
        st2 = $sformatf("  Expected ex5_transaction: %s", stim_txn.convert2string());
        st3 = $sformatf("  Received ex5_transaction: %s", result_txn.convert2string());
        `uvm_error("SB MISMATCH",{st1, st2, st3})
        error_cnt++;
        if (error_cnt > 20) uvm_top.stop_request();
      end
    end
  endtask

  function void report_phase(uvm_phase phase);
    `uvm_info("SB",$sformatf("*****\nDUT did %0d operations with %0d errors\n",
      op_cnt, error_cnt), UVM_LOW)
  endfunction
