module ex6_clock_driver(ex6_interface.clock_driver_mp clock_interface);
  initial begin
    clock_interface.reset <= 0;
    clock_interface.clock <= 0;
  end

  always begin
    forever #10 clock_interface.clock = ~clock_interface.clock;
  end
endmodule: ex6_clock_driver
