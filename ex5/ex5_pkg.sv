package ex5_pkg;
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  `include "ex5_config.svh"
  `include "ex5_agent_config.svh"

  `include "ex5_transaction.svh"
  `include "ex5_sequence.svh"

  typedef uvm_sequencer #( ex5_transaction ) ex5_sequencer;

  `include "ex5_driver.svh"
  `include "ex5_monitor.svh"
  `include "ex5_agent.svh"
  `include "ex5_analysis.svh"
  `include "ex5_env.svh"
  `include "ex5_test.svh"
endpackage: ex5_pkg