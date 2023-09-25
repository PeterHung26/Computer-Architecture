`include "alu_if.vh"
`timescale 1 ns / 1 ns
import cpu_types_pkg::*;

module alu_tb;
  parameter PERIOD = 10;
  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // interface
  alu_if aluif ();
  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else//rf[0] = '0
  alu DUT(
    .\aluif.a (aluif.a),
    .\aluif.b (aluif.b),
    .\aluif.out (aluif.out),
    .\aluif.ops (aluif.ops),
    .\aluif.negative (aluif.negative),
    .\aluif.overflow (aluif.overflow),
    .\aluif.zero (aluif.zero)
    //.\nRST (nRST),
    //.\CLK (CLK)
  );
`endif

endmodule



program test;
  int testcase = 0;
  integer i;
initial begin
    
    
		//


    alu_tb.aluif.a = 1;
    alu_tb.aluif.b = 4;
    alu_tb.aluif.ops = ALU_SLL;
    #5ns;

    testcase++;
    alu_tb.aluif.a = 16;
    alu_tb.aluif.b = 4;
    alu_tb.aluif.ops = ALU_SRL;
    #5ns;

    testcase++;
    alu_tb.aluif.ops = ALU_ADD;
    #5ns;

    testcase++;
    alu_tb.aluif.a = 32'b01111111111111111111111111111111;
    alu_tb.aluif.b = 32'b01111111111111111111111111111111;
    #5ns;


    testcase++;
    alu_tb.aluif.ops = ALU_SUB;
    alu_tb.aluif.a = 32'b01111111111111111111111111111111;
    alu_tb.aluif.b = 32'b01111111111111111111111111111111;
    #5ns;

    testcase++;
    alu_tb.aluif.ops = ALU_ADD;
    alu_tb.aluif.a = 32'h00000002;
    alu_tb.aluif.b = '1;
    #5ns;


    testcase++;
    alu_tb.aluif.ops = ALU_OR;
    alu_tb.aluif.a = 32'h0000000F;
    alu_tb.aluif.b = 32'h000000F0;
    #5ns;

    testcase++;
    alu_tb.aluif.ops = ALU_NOR;
    alu_tb.aluif.a = 32'h0000000F;
    alu_tb.aluif.b = 32'h000000F0;
    #5ns;



    testcase++;
    alu_tb.aluif.ops = ALU_AND;
    alu_tb.aluif.a = 32'h0000000F;
    alu_tb.aluif.b = 32'h000000F0;
    #5ns;

    testcase++;
    alu_tb.aluif.ops = ALU_XOR;
    alu_tb.aluif.a = 32'h0000000F;
    alu_tb.aluif.b = 32'h000000F0;
    #5ns;

    testcase++;
    alu_tb.aluif.ops = ALU_XOR;
    alu_tb.aluif.a = 32'h0000000F;
    alu_tb.aluif.b = 32'h0000000F;
    #5ns;

end	
endprogram
