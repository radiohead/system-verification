class ex6_predictor extends uvm_subscriber #(ex6_transaction);
  `uvm_component_utils(ex6_predictor)

  ex6_transaction out_txn;
  uvm_analysis_port #(ex6_transaction) results_ap;

  covergroup transaction_coverage;
    // God praise idiots -_-
    d1: coverpoint out_txn.data[0];
    cov_value1: coverpoint out_txn.value1 {
      bins zero = {0};
      bins f1to10 = {[1:9]};
      bins f10to100 = {[10:100]};
      bins rest = default;
    };
    cov_value2: coverpoint out_txn.value2 {
      bins zero = {0};
      bins f1to10 = {[1:9]};
      bins f10to100 = {[10:100]};
      bins rest = default;
    };
    mode_value: coverpoint out_txn.mode {
      bins add = {ADD};
      bins sub = {SUB};
      bins mul = {MUL};
      bins div = {DIV};
    }
  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    transaction_coverage = new;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    results_ap = new("results_ap", this);
  endfunction

  function void write (ex6_transaction t);
    $cast(out_txn, t.clone());

    switch (t.mode)
      ADD: out_txn.result = t.value1 + t.value2;
      SUB: out_txn.result = t.value1 - t.value2;
      MUL: out_txn.result = t.value1 * t.value2;
      DIV: out_txn.result = t.value1 / t.value2;

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
