package ex2_pkg;
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  `include "ex2_transaction.svh"
  `include "ex2_sequence.svh"

  typedef uvm_sequencer #( ex2_transaction ) ex2_sequencer;

  `include "ex2_driver.svh"
  `include "ex2_env.svh"
endpackage: ex2_pkg