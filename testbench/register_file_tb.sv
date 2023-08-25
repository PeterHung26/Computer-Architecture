/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;
  
  //int i;
  //int tb_test_num;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif();
  // test program
  test #(.PERIOD (PERIOD)) PROG (
    .clk(CLK),
    .n_rst(nRST),
    .rfif(rfif.tb)
  );
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif.rf);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.dat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\n_rst (nRST),
    .\clk (CLK)
  );
`endif

  /*task reset_dut;
  begin
    nRST = 0;
    @(posedge CLK);
    @(posedge CLK);
    @(negedge CLK);
    nRST = 1;
    @(posedge CLK);
  end
  endtask

  task write_reg;
  input int num;
  input int data;
  begin
    @(negedge CLK);
    rfif.WEN = 1'b1;
    rfif.wsel = num;
    rfif.wdat = data;
    @(negedge CLK);
    rfif.WEN = 1'b0;
  end
  endtask

  task read1_reg;
  input int num;
  input int exp_rdat;
  begin
    @(negedge CLK);
    rfif.rsel1 = num;
    @(negedge CLK);
    assert (rfif.rdat1 == exp_rdat) 
      $info("Register %0d is as expected read by rdat1", num);
    else
      $error("Register %0d is not as expected read by rdat1", num);
  end
  endtask

  task read2_reg;
  input int num;
  input int exp_rdat;
  begin
    @(negedge CLK);
    rfif.rsel2 = num;
    @(negedge CLK);
    assert (rfif.rdat2 == exp_rdat)
      $info("Register %0d is as expected read by rdat1", num);
    else
      $error("Register %0d is not as expected read by rdat2", num);
  end
  endtask*/

  /*initial begin
    //Test case 1: Reset the DUT
    tb_test_num = 1;
    reset_dut();
    for(i = 0; i < 32; i++) begin
      read1_reg(i, 0);
      read2_reg(i, 0);
    end
    //Test case 2: Write and Read Register 0
    tb_test_num ++;
    write_reg(0, 500);
    read1_reg(0,0);
    read2_reg(0,0);
    //Test case 3: Write and read other register
    tb_test_num++;
    for(i = 0; i < 32; i++) begin
      write_reg(i, i);
      read1_reg(i, i);
      read2_reg(i, i);
    end
    $stop();
  end*/
endmodule

program test(
  input logic clk,
  output logic n_rst,
  register_file_if rfif
);
parameter PERIOD = 10;
int i;
int tb_test_num;

task reset_dut;
  begin
    n_rst = 0;
    @(posedge clk);
    @(posedge clk);
    @(negedge clk);
    n_rst = 1;
    @(posedge clk);
  end
  endtask

task write_reg;
  input int num;
  input int data;
  begin
    @(negedge clk);
    rfif.WEN = 1'b1;
    rfif.wsel = num;
    rfif.wdat = data;
    @(negedge clk);
    rfif.WEN = 1'b0;
  end
endtask

task read1_reg;
  input int num;
  input int exp_rdat;
  begin
    @(negedge clk);
    rfif.rsel1 = num;
    @(negedge clk);
    assert (rfif.rdat1 == exp_rdat) 
      $info("Register %0d is as expected read by rdat1", num);
    else
      $error("Register %0d is not as expected read by rdat1", num);
  end
endtask

task read2_reg;
  input int num;
  input int exp_rdat;
  begin
    @(negedge clk);
    rfif.rsel2 = num;
    @(negedge clk);
    assert (rfif.rdat2 == exp_rdat)
      $info("Register %0d is as expected read by rdat1", num);
    else
      $error("Register %0d is not as expected read by rdat2", num);
  end
endtask

initial begin
//Test case 1: Reset the DUT
  tb_test_num = 1;
  reset_dut();
  for(i = 0; i < 32; i++) begin
    read1_reg(i, 0);
    read2_reg(i, 0);
  end
  //Test case 2: Write and Read Register 0
  tb_test_num ++;
  write_reg(0, 500);
  read1_reg(0,0);
  read2_reg(0,0);
  //Test case 3: Write and read other register
  tb_test_num++;
  for(i = 0; i < 32; i++) begin
    write_reg(i, i);
    read1_reg(i, i);
    read2_reg(i, i);
  end
  $stop();
end
endprogram
