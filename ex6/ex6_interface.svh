interface ex6_interface;
  logic clock;
  logic reset;

  int unsigned value1, value2, result, correct;
  typedef enum {ADD, SUB, MUL, DIV} op_type;
  rand op_type mode;

  modport dut_mp(
    input clock,
    input reset,
    input value1,
    input value2,
    output result,
    output correct
  );

  modport clock_driver_mp(
    output clock,
    output reset
  );
endinterface: ex6_interface
