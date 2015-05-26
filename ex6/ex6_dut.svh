module ex6_dut(ex6_interface.dut_mp dut_interface);
  always @(posedge dut_interface.clock or negedge dut_interface.reset)
  begin
    $display("DUT @ %0t value1 = %p, value2 = %p", $time, dut_interface.value1, dut_interface.value2);

    dut_interface.correct = 1;
    if (dut_interface.reset)
    	dut_interface.result = 0;
    else
	    case(dit_interface.mode)
	    	ADD: dut_interface.result = dut_interface.value1 + dut_interface.value2;
	    	SUB: dut_interface.result = dut_interface.value1 - dut_interface.value2;
	    	MUL: dut_interface.result = dut_interface.value1 * dut_interface.value2;
	    	DIV: if (dut_interface.value2 == 0) begin
          dut_interface.result = 0;
          dut_interface.correct = 0;
        end
        else
          dut_interface.result = dut_interface.value1 / dut_interface.value2;

    $display("DUT @ %0t result = %p, correct = %p", $time, dut_interface.result, dut_interface.correct);
  end
endmodule: ex6_dut
