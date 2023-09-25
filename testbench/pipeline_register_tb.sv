`include "pipeline_register_if.vh"
`include "cpu_types_pkg.vh"
`timescale 1 ns / 1 ns
import cpu_types_pkg::*;

module pipeline_register_tb;
  parameter PERIOD = 10;
  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  pipeline_register_if dpif();

  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  pipeline_register DUT(CLK, nRST, dpif);
`else//rf[0] = '0
  datapath DUT(CLK, nRST, dpif);
`endif

endmodule



program test;
int testcase = 0;
integer i, j, k, l;
string   tb_test_case;
initial begin



end	
endprogram
