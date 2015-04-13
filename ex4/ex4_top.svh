module top;
  import uvm_pkg::*;
  import ex4_pkg::*;

  ex4_interface _interface();
  ex4_dut dut(_interface.dut_mp);
  ex4_clock_driver clk(_interface.clock_driver_mp);
  ex4_env env;

  initial begin
    uvm_config_db #(virtual ex4_interface)::set(null, "*", "top_interface", _interface);
    run_test();
  end
endmodule: top
