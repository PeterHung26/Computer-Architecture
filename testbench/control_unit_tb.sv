`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"
`timescale 1 ns / 1 ns
import cpu_types_pkg::*;

module control_unit_tb;
  parameter PERIOD = 10;
  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  control_unit_if cuif();

  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  control_unit DUT(cuif);
`else//rf[0] = '0
  control_unit DUT(cuif);
`endif

endmodule



program test;
int testcase = 0;
integer i;
string   tb_test_case;
  initial begin

// 0. reset
    tb_test_case = "Initilization";
    cuif.inst = '0;
    @(posedge control_unit_tb.CLK);

    testcase++;
    tb_test_case = "ADD";
    cuif.inst = {RTYPE, 5'd5, 5'd4, 5'd3,5'd0, ADD};
    @(posedge control_unit_tb.CLK);

    testcase++;
    tb_test_case = "J";
    cuif.inst = {J, 26'd1357};
    @(posedge control_unit_tb.CLK);

    testcase++;
    tb_test_case = "JAL";
    cuif.inst = {JAL, 26'd1357};
    @(posedge control_unit_tb.CLK);

    testcase++;
    tb_test_case = "BEQ";
    cuif.inst = {BEQ, 5'd5, 5'd4, 16'd1357};
    @(posedge control_unit_tb.CLK);


    testcase++;
    tb_test_case = "BNE";
    cuif.inst = {BNE, 5'd5, 5'd4, 16'd1357};
    @(posedge control_unit_tb.CLK);



    testcase++;
    tb_test_case = "LW";
    cuif.inst = {LW, 5'd5, 5'd4, 16'd1357};
    @(posedge control_unit_tb.CLK);


    testcase++;
    tb_test_case = "SW";
    cuif.inst = {SW, 5'd5, 5'd4, 16'd1357};
    @(posedge control_unit_tb.CLK);

    testcase++;
    tb_test_case = "HALT";
    cuif.inst = '1;
    @(posedge control_unit_tb.CLK);


    


end	
endprogram
