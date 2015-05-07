class ex5_comparator extends uvm_component;
  `uvm_component_utils(ex5_comparator)

  uvm_analysis_export #(ex5_transaction) axp_in;
  uvm_analysis_export #(ex5_transaction) axp_out;
  uvm_tlm_analysis_fifo #(ex5_transaction) expfifo;
  uvm_tlm_analysis_fifo #(ex5_transaction) outfifo;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    axp_in = new("axp_in", this);
    axp_out = new("axp_out", this);
    expfifo = new("expfifo", this);
    outfifo = new("outfifo", this);
  endfunction

  function connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    axp_in.connect(expfifo.analysis_export);
    axp_out.connect(outfifo.analysis_export);
  endfunction

  task run_phase(uvm_phase phase);
    ex5_transaction exp_tr, out_tr;
    forever begin
      `uvm_info("ex5_comparator run task", 
                "WAITING for expected output", UVM_DEBUG)
      expfifo.get(exp_tr);
      `uvm_info("ex5_comparator run task",
                "WAITING for actual output", UVM_DEBUG)
      outfifo.get(out_tr);

      if (out_tr.compare(exp_tr)) begin
        PASS();
        `uvm_onfo ("PASS ", $sformatf("Actual=%s    Expected=%s \n",
                    out_tr.output2string(),
                    exp_tr.convert2string()), UVM_HIGH)
      end
      else begin
        ERROR();
        `uvm_onfo ("ERROR ", $sformatf("Actual=%s    Expected=%s \n",
                    out_tr.output2string(),
                    exp_tr.convert2string()))
      end
    end
  endtask

  int VECT_CNT, PASS_CNT, ERROR_CNT;

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);

    if (VECT_CNT && !ERROR_CNT)
      `uvm_info(get_type_name(),
                $sformatf(
                 "\n\n\n*** TEST PASSED - %0d vectors ran, %0d vectors passed ***\n", 
                 VECT_CNT, PASS_CNT), UVM_LOW)
    else
            `uvm_info(get_type_name(), 
      $sformatf( 
                "\n\n\n*** TEST FAILED - %0d vectors ran, %0d vectors passed, %0d vectors failed ***\n", 
                 VECT_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
  endfunction

  function void PASS();
    VECT_CNT++;
    PASS_CNT++;
  endfunction

  function void ERROR();
    VECT_CNT++;
    ERROR_CNT++;
  endfunction

endclass