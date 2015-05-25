class ex6_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(ex6_scoreboard)

  uvm_analysis_export #(ex6_transaction) axp_in;
  uvm_analysis_export #(ex6_transaction) axp_out;

  ex6_predictor prd;
  ex6_comparator cmp;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    axp_in = new("axp_in", this);
    axp_out = new("axp_out", this);

    prd = ex6_predictor::type_id::create("prd", this);
    cmp = ex6_comparator::type_id::create("cmp", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    // Connect predictor & comparator to respective analysis exports
    axp_in.connect (prd.analysis_export);
    axp_out.connect (cmp.axp_out);

    // Connect predictor to comparator
    prd.results_ap.connect(cmp.axp_in);
  endfunction

endclass