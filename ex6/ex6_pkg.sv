package ex6_pkg;
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  `include "ex6_config.svh"
  `include "ex6_agent_config.svh"

  `include "ex6_transaction.svh"
  `include "ex6_sequence.svh"

  typedef uvm_sequencer #( ex6_transaction ) ex6_sequencer;

  `include "ex6_driver.svh"
  `include "ex6_monitor.svh"
  `include "ex6_agent.svh"
  `include "ex6_analysis.svh"
  `include "ex6_env.svh"
  `include "ex6_test.svh"
endpackage: ex6_pkg