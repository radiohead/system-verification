package ex3_pkg;
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  `include "ex3_config.svh"

  `include "ex3_transaction.svh"
  `include "ex3_sequence.svh"

  typedef uvm_sequencer #( ex3_transaction ) ex3_sequencer;

  `include "ex3_driver.svh"
  `include "ex3_env.svh"
  `include "ex3_test.svh"
endpackage: ex3_pkg