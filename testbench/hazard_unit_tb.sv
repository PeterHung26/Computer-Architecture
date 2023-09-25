`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module hazard_unit_tb;

  parameter PERIOD = 10;
  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  hazard_unit_if huif();

  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  hazard_unit DUT(huif);
`else//rf[0] = '0
  hazard_unit DUT(huif);
`endif

endmodule



program test;
int testcase = 0;
integer i, j, k, l;
string   tb_test_case;
initial begin

hazard_unit_tb.nRST = '1;
hazard_unit_tb.huif.IDEX_rd = '0;
hazard_unit_tb.huif.IDEX_rs = '0;
hazard_unit_tb.huif.IDEX_rt = '0; 
hazard_unit_tb.huif.EXMEM_rd = '0;
hazard_unit_tb.huif.MEMWB_rd = '0;
hazard_unit_tb.huif.IDEX_RegWrite = '0;
hazard_unit_tb.huif.IDEX_dREN = '0;
hazard_unit_tb.huif.EXMEM_dREN = '0;
hazard_unit_tb.huif.MEMWB_dREN = '0;
hazard_unit_tb.huif.EXMEM_RegWrite = '0;
hazard_unit_tb.huif.MEMWB_RegWrite = '0;
hazard_unit_tb.huif.IDEX_dWEN = '0;
hazard_unit_tb.huif.EXMEM_dWEN = '0;
hazard_unit_tb.huif.MEMWB_dWEN = '0;
hazard_unit_tb.huif.IFID_rt = '0;
hazard_unit_tb.huif.IFID_rs = '0;
hazard_unit_tb.huif.IFID_opc = '0;


    @(posedge hazard_unit_tb.CLK);
    tb_test_case = "Initilization";
    hazard_unit_tb.nRST = 0;
    @(posedge hazard_unit_tb.CLK);
    hazard_unit_tb.nRST = 1;
    @(posedge hazard_unit_tb.CLK);


    @(posedge hazard_unit_tb.CLK);
    tb_test_case = "ForwordA_10";
    hazard_unit_tb.huif.EXMEM_RegWrite = 1;
    hazard_unit_tb.huif.IDEX_rs = 3;
    hazard_unit_tb.huif.EXMEM_rd = 3;
    @(posedge hazard_unit_tb.CLK);


    @(posedge hazard_unit_tb.CLK);
    tb_test_case = "ForwordA_01";
    hazard_unit_tb.huif.EXMEM_rd = 0;
    hazard_unit_tb.huif.MEMWB_RegWrite = 1;
    hazard_unit_tb.huif.IDEX_rs = 3;
    hazard_unit_tb.huif.MEMWB_rd = 3;
    @(posedge hazard_unit_tb.CLK);


    @(posedge hazard_unit_tb.CLK);
    tb_test_case = "ForwordB_10";
    hazard_unit_tb.huif.EXMEM_RegWrite = 1;
    hazard_unit_tb.huif.IDEX_rt = 3;
    hazard_unit_tb.huif.EXMEM_rd = 3;
    @(posedge hazard_unit_tb.CLK);


    @(posedge hazard_unit_tb.CLK);
    tb_test_case = "ForwordB_01";
    hazard_unit_tb.huif.EXMEM_rd = 0;
    hazard_unit_tb.huif.MEMWB_RegWrite = 1;
    hazard_unit_tb.huif.IDEX_rt = 3;
    hazard_unit_tb.huif.MEMWB_rd = 3;
    @(posedge hazard_unit_tb.CLK);

    

    @(posedge hazard_unit_tb.CLK);
    tb_test_case = "RegWrite off";
    hazard_unit_tb.huif.MEMWB_RegWrite = 0;
    hazard_unit_tb.huif.IDEX_rt = 3;
    hazard_unit_tb.huif.MEMWB_rd = 3;
    @(posedge hazard_unit_tb.CLK);



    hazard_unit_tb.huif.IDEX_rt = 0;
    hazard_unit_tb.huif.MEMWB_rd = 0;
    hazard_unit_tb.huif.IDEX_rt = 0;
    hazard_unit_tb.huif.MEMWB_rd = 0;




    @(posedge hazard_unit_tb.CLK);
    tb_test_case = "ForwardSW_01";
    hazard_unit_tb.huif.IFID_opc = SW;
    hazard_unit_tb.huif.IDEX_RegWrite = 1;
    hazard_unit_tb.huif.IDEX_rd = 3;
    hazard_unit_tb.huif.IFID_rt = 3;
    @(posedge hazard_unit_tb.CLK);


    @(posedge hazard_unit_tb.CLK);
    tb_test_case = "ForwardSW_10";
    hazard_unit_tb.huif.IFID_opc = SW;
     hazard_unit_tb.huif.IDEX_rd = 0;
    hazard_unit_tb.huif.IDEX_RegWrite = 1;
    hazard_unit_tb.huif.EXMEM_rd = 3;
    hazard_unit_tb.huif.IFID_rt = 3;
    @(posedge hazard_unit_tb.CLK);


 @(posedge hazard_unit_tb.CLK);
    tb_test_case = "ForwardSW_11";
    hazard_unit_tb.huif.IFID_opc = SW;
     
    hazard_unit_tb.huif.IDEX_RegWrite = 1;
    hazard_unit_tb.huif.EXMEM_dREN = 1;
    hazard_unit_tb.huif.IDEX_rd = 3;
    hazard_unit_tb.huif.EXMEM_rd = 3;
    hazard_unit_tb.huif.IFID_rt = 3;
    @(posedge hazard_unit_tb.CLK);

   
   



    @(posedge hazard_unit_tb.CLK);
    tb_test_case = "Stall";
    hazard_unit_tb.huif.IDEX_dREN = 1;
    hazard_unit_tb.huif.IDEX_rt = 3;
    hazard_unit_tb.huif.IDEX_rs = 3;
    @(posedge hazard_unit_tb.CLK);


    @(posedge hazard_unit_tb.CLK);
    @(posedge hazard_unit_tb.CLK);

end	
endprogram
