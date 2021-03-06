package ex6_pkg;
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import types_pkg::*;
  `include "ex6_config.svh"
  `include "ex6_agent_config.svh"

  `include "ex6_transaction.svh"
  `include "ex6_sequence.svh"

  typedef uvm_sequencer #( ex6_transaction ) ex6_sequencer;

  `include "ex6_driver.svh"
  `include "ex6_monitor.svh"
  `include "ex6_agent.svh"
  `include "ex6_analysis.svh"
  `include "ex6_predictor.svh"
  `include "ex6_comparator.svh"
  `include "ex6_scoreboard.svh"
  `include "ex6_env.svh"
  `include "ex6_test.svh"
  `include "ex6_test_zero.svh"
  `include "ex6_test_lt_zero.svh"

endpackage: ex6_pkg