module top;  
  import uvm_pkg::*;
  import ex1_pkg::*;
  
  ex1_interface _interface();
  ex1_dut dut(_interface.dut_mp);
  ex1_clock_driver clk(_interface.clock_driver_mp);
  ex1_env env;
  
  initial begin
    env = new("environment");
    uvm_config_db #(virtual ex1_interface)::set(null, "*", "top_interface", _interface);
    run_test();
  end
endmodule: top
