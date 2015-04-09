module top;
  import uvm_pkg::*;
  import ex3_pkg::*;

  ex3_interface _interface();
  ex3_dut dut(_interface.dut_mp);
  ex3_clock_driver clk(_interface.clock_driver_mp);
  ex3_env env;

  initial begin
    uvm_config_db #(virtual ex3_interface)::set(null, "*", "top_interface", _interface);
    run_test();
  end
endmodule: top
