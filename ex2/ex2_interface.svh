interface ex2_interface;
  logic clock;
  logic reset;
  
  logic data[7:0];
  logic result[7:0];

  modport dut_mp(
    input clock,
    input reset,
    input data,
    output result
  );

  modport clock_driver_mp(
    output clock,
    output reset
  );
endinterface: ex2_interface
