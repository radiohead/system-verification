module ex5_dut(ex5_interface.dut_mp dut_interface);
  always @(posedge dut_interface.clock or negedge dut_interface.reset)
  begin
    $display("DUT @ %0t data = %p", $time, dut_interface.data);

    if (dut_interface.reset)
      dut_interface.result <= "00000000";
    else
      dut_interface.result <= dut_interface.data;
  end
endmodule: ex5_dut
