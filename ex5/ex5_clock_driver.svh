module ex5_clock_driver(ex5_interface.clock_driver_mp clock_interface);
  initial begin
    clock_interface.reset <= 1;
    clock_interface.clock <= 0;
  end

  always begin
    clock_interface.reset <= 0;
    forever #10 clock_interface.clock = ~clock_interface.clock;
  end
endmodule: ex5_clock_driver
