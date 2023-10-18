`include "caches_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;
`timescale 1 ns / 1 ns
import cpu_types_pkg::*;

module icache_tb;
  parameter PERIOD = 10;
  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  datapath_cache_if dcif();
  caches_if cif();

  // test program
   test #(.PERIOD (PERIOD)) PROG (
    .CLK(CLK),
    .nRST(nRST),
    .dcif(dcif),
    .cif(cif)
  );

  // DUT
`ifndef MAPPED
  icache DUT(CLK, nRST, dcif,cif);
`else//rf[0] = '0
  icache DUT(CLK, nRST, dcif,cif);
`endif

endmodule



program test(
  input logic CLK,
  output logic nRST,
  datapath_cache_if dcif,
  caches_if cif
);
parameter PERIOD = 10;
integer i, j, k, l;
int tb_test_num;
string   tb_test_case;

task reset_dut;
  begin
    nRST = 0;
    @(posedge CLK);
    @(posedge CLK);
    @(posedge CLK);
    nRST = 1;
    @(posedge CLK);
  end
  endtask


initial begin
tb_test_num = 0;
dcif.imemREN = 1;
dcif.dmemREN = 0;
dcif.dmemWEN = 0;
dcif.imemaddr = 0;
dcif.dmemaddr = 0;
dcif.dmemstore = 0;
dcif.halt = 0;
cif.iwait = 1;
cif.dwait = 1;
cif.iload = 0;
cif.dload = 0;
reset_dut();

@(posedge CLK);
@(posedge CLK);

tb_test_num ++;
dcif.imemaddr = {26'd135 ,4'd1,2'b00};
cif.iwait = 0;
cif.iload = 32'hAAAAAAAA;
@(posedge CLK);
cif.iwait = 1;
dcif.imemaddr = {26'd135 ,4'd1,2'b00};
cif.iload = 32'hBBBBBBBB;
@(posedge CLK);
cif.iwait = 0;

//forever begin
 // wait(dcif.ihit==1);
//end
$display("index 1");



tb_test_num ++;
dcif.imemaddr = {26'd136 ,4'd2,2'b00};
cif.iwait = 0;


@(posedge CLK);
cif.iwait = 1;
cif.iload = '0;
@(posedge CLK);
cif.iwait = 0;

//forever begin
 // wait(dcif.ihit==1);
//end
$display("index 2");

/*
tb_test_num ++;
dcif.imemaddr = {26'd135 ,4'd1,2'b00};

#(5)

@(posedge CLK);

@(posedge CLK);


tb_test_num ++;
*/

$finish;

end	

endprogram
