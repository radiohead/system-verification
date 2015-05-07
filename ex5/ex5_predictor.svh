class ex5_predictor extends uvm_subscriber #(ex5_transaction);
  `uvm_component_utils(ex5_predictor)

  ex5_transaction out_txn;

  covergroup transaction_coverage;
    coverpoint out_txn.data {
      bins low = {0,50};
      bins med = {51,150};
      bins high = {151,255};
    }
  endgroup

  uvm_analysis_port #(ex5_transaction) results_ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    results_ap = new("results_ap", this);
  endfunction

  function void write (ex5_transaction t);
    // ex5_transaction out_txn;
    $cast(out_txn, t.clone());
    // our DUT for now should return in result the data that it got in input
    foreach(data[i]) begin
      out_txn.result[i] = t.data[i];
    end
    results_ap.write(out_txn);
  endfunction

  function void report_phase(uvm_phase phase);
    real pct;
    int unsigned covered;
    int unsigned total;

    pct = transaction_coverage.get_coverage(covered, total);
    $display("REQ Coverage: covered = %0d, total = %0d (%5.2f%%)", covered, total , pct);
  endfunction 

endclass
