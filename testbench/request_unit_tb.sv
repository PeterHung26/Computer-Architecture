`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"
`timescale 1 ns / 1 ns
import cpu_types_pkg::*;

module request_unit_tb;
  parameter PERIOD = 10;
  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  request_unit_if ruif();

  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  request_unit DUT(CLK, nRST, ruif);
`else//rf[0] = '0
  request_unit DUT(CLK, nRST, ruif);
`endif

endmodule



program test;
int testcase = 0;
integer i, j, k, l;
string   tb_test_case;
  initial begin

request_unit_tb.nRST = '1;
request_unit_tb.ruif.dWEN = '0;
request_unit_tb.ruif.dREN = '0;
request_unit_tb.ruif.dhit = '0;
request_unit_tb.ruif.ihit = '0;


    @(posedge request_unit_tb.CLK);
    tb_test_case = "Initilization";
    request_unit_tb.nRST = 0;
    @(posedge request_unit_tb.CLK);
    request_unit_tb.nRST = 1;
    @(posedge request_unit_tb.CLK);

 	for(i = 0; i < 2; i++) begin
	    for(j = 0; j < 2; j++) begin
	        for(k = 0; k < 2; k++) begin
	            for(l = 0; l < 2; l++) begin
		            request_unit_tb.ruif.dWEN = i;
		            request_unit_tb.ruif.dREN = j;
		            request_unit_tb.ruif.dhit = k;
		            request_unit_tb.ruif.ihit = l;
		            @(posedge request_unit_tb.CLK);
	            end
	        end
	    end
	end
    


end	
endprogram
