package ex4_pkg;
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  `include "ex4_config.svh"

  `include "ex4_transaction.svh"
  `include "ex4_sequence.svh"

  typedef uvm_sequencer #( ex4_transaction ) ex4_sequencer;

  `include "ex4_driver.svh"
  `include "ex4_env.svh"
  `include "ex4_test.svh"
endpackage: ex4_pkg