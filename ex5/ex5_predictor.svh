class ex5_predictor extends uvm_subscriber #(ex5_transaction);
  `uvm_component_utils(ex5_predictor)

  ex5_transaction out_txn;
  uvm_analysis_port #(ex5_transaction) results_ap;

  covergroup transaction_coverage;
    // God praise idiots -_-
    d1: coverpoint out_txn.data[0];
    d2: coverpoint out_txn.data[1];
    d3: coverpoint out_txn.data[2];
    d4: coverpoint out_txn.data[3];
    d5: coverpoint out_txn.data[4];
    d6: coverpoint out_txn.data[5];
    d7: coverpoint out_txn.data[6];
    d8: coverpoint out_txn.data[7];
  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    transaction_coverage = new;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    results_ap = new("results_ap", this);
  endfunction

  function void write (ex5_transaction t);
    $cast(out_txn, t.clone());

    // our DUT for now should return in result the data that it got in input
    foreach(t.data[i]) begin
      out_txn.result[i] = t.data[i];
      transaction_coverage.sample();
    end
    results_ap.write(out_txn);
  endfunction

  function void report_phase(uvm_phase phase);
    real pct;
    int unsigned covered;
    int unsigned total;

    pct = transaction_coverage.get_coverage(covered, total);
    $display("REQ Coverage: covered = %0d, total = %0d (%5.2f%%)", covered, total , pct);
    $display("Instance coverage is %e", transaction_coverage.get_coverage());
  endfunction 

endclass
