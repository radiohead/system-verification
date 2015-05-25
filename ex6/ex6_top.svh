module top;
  import uvm_pkg::*;
  import ex6_pkg::*;

  ex6_interface _interface();
  ex6_dut dut(_interface.dut_mp);
  ex6_clock_driver clk(_interface.clock_driver_mp);
  ex6_env env;

  initial begin
    uvm_config_db #(virtual ex6_interface)::set(null, "*", "top_interface", _interface);
    run_test();
  end
endmodule: top
