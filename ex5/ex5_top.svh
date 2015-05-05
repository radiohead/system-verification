module top;
  import uvm_pkg::*;
  import ex5_pkg::*;

  ex5_interface _interface();
  ex5_dut dut(_interface.dut_mp);
  ex5_clock_driver clk(_interface.clock_driver_mp);
  ex5_env env;

  initial begin
    uvm_config_db #(virtual ex5_interface)::set(null, "*", "top_interface", _interface);
    run_test();
  end
endmodule: top
