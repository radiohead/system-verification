module top;  
  import uvm_pkg::*;
  import ex2_pkg::*;
  
  ex2_interface _interface();
  ex2_dut dut(_interface.dut_mp);
  ex2_clock_driver clk(_interface.clock_driver_mp);
  ex2_env env;
  
  initial begin
    env = new("environment");
    uvm_config_db #(virtual ex2_interface)::set(null, "*", "top_interface", _interface);
    run_test();
  end
endmodule: top
