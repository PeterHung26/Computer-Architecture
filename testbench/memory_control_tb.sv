`include "register_file_if.vh"
`include "cpu_types_pkg.vh"
`include "cpu_ram_if.vh"
`include "cache_control_if.vh"
import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;

  parameter PERIOD = 10;
  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;
    
  // interface
  caches_if cif0();
  caches_if cif1();
  cache_control_if #(1) ccif(cif0, cif1);
  cpu_ram_if ramif();
  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  memory_control DUT(CLK, nRST,  ccif);
  ram ram(CLK, nRST,  ramif);
`else//rf[0] = '0
  memory_control DUT(
    .\CLK(CLK), 
    .\nRST(nRST),
    .\ccif.iREN(ccif.iREN), 
    .\ccif.dREN(ccif.dREN), .\ccif.dWEN(ccif.dWEN), .\ccif.dstore(ccif.dstore), .\ccif.iaddr(ccif.iaddr), .\ccif.daddr(ccif.daddr),
    // ram inputs
    .\ccif.ramload(ccif.ramload), .\ccif.ramstate(ccif.ramstate),
    // coherence inputs from cache
    // ccwrite, cctrans, ??
    // cache outputs
    .\ccif.iwait(ccif.iwait), .\ccif.dwait(ccif.dwait), .\iload(ccif.iload), .\dload(ccif.dload),
    // ram outputs
    .\ccif.ramstore(ccif..ramstore), .\ccif.ramaddr(ccif.ramaddr), .\ccif.ramWEN(ccif.ramWEN), .\ccif.ramREN(ccif.ramREN)
    // coherence outputs to cache
    // ccwait, ccinv, ccsnoopaddr ??
  );
  ram ram(CLK, nRST,  ramif);
`endif

  
  assign ccif.ramstate    = ramif.ramstate;
  assign ccif.ramload     = ramif.ramload;
  assign ramif.ramstore   = ccif.ramstore;
  assign ramif.ramaddr    = ccif.ramaddr;
  assign ramif.ramWEN     = ccif.ramWEN;
  assign ramif.ramREN     = ccif.ramREN;

endmodule


program test;
int testcase = 0;
integer i;
string   tb_test_case;
  initial begin

// 0. reset
    tb_test_case = "Initilization";
    cif0.dWEN = '0;
    cif0.dREN = '0;
    cif0.iREN = '0;
    @(posedge memory_control_tb.CLK);
    memory_control_tb.nRST = '0;
		@(posedge memory_control_tb.CLK);
		memory_control_tb.nRST = 1;
		@(posedge memory_control_tb.CLK);
    
// 1. dstore
    tb_test_case = "dstore";
    testcase++;
    cif0.dWEN = '1;
    cif0.dREN = '0;
    cif0.iREN = '0;
    cif0.daddr = 32'h0100;
    cif0.dstore = 32'hFFF;
    @(posedge memory_control_tb.CLK);
    @(posedge memory_control_tb.CLK);
    @(negedge memory_control_tb.CLK);


// 2. dload
    tb_test_case = "dload";
    testcase++;
    cif0.dWEN = '0;
    cif0.dREN = '1;
    cif0.iREN = '0;
    cif0.daddr = 32'h0100;
    cif0.dstore = 32'hEEE;
    @(posedge memory_control_tb.CLK);
    @(posedge memory_control_tb.CLK);

    
// 3. dload && iload
    tb_test_case = "dload then iload";
    testcase++;
    cif0.dWEN = '0;
    cif0.dREN = '1;
    cif0.iREN = '1;
    cif0.daddr = 32'h0100;
    cif0.dstore = 32'hEEE;
    @(posedge memory_control_tb.CLK);
    @(posedge memory_control_tb.CLK);
    cif0.dWEN = '0;
    cif0.dREN = '0;
    cif0.iREN = '1;
    cif0.daddr = 32'h0100;
    cif0.iaddr = 32'h0100;
    cif0.dstore = 32'hEEE;
    @(posedge memory_control_tb.CLK);
    @(posedge memory_control_tb.CLK);



// iload
    tb_test_case = "iload";
    for(i=0;i<5;i++) begin
      testcase++;
      memory_control_tb.cif0.iaddr = '0 +i*4;
      cif0.dWEN = '0;
      cif0.dREN = '0;
      cif0.iREN = '1;
      cif0.daddr = '0 + 4*i;
      cif0.dstore = 32'hEEE;
      #(memory_control_tb.PERIOD);
      #(memory_control_tb.PERIOD);
    end




    tb_test_case = "dump";
    dump_memory();
  end


  
  task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    cif0.daddr = 0;
    cif0.dWEN = 0;
    cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif0.daddr = i << 2;
      cif0.dREN = 1;
      repeat (4) @(posedge memory_control_tb.CLK);
      if (cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask
endprogram