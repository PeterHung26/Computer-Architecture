`include "caches_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;
`timescale 1 ns / 1 ns
import cpu_types_pkg::*;

module caches_tb;
  parameter PERIOD = 10;
  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  datapath_cache_if dcif();
  caches_if cif();

  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  caches DUT(CLK, nRST, dcif,cif);
`else//rf[0] = '0
  caches DUT(CLK, nRST, dcif,cif);
`endif

endmodule



program test;
int testcase = 0;
integer i, j, k, l;
string   tb_test_case;
initial begin



end	
endprogram
