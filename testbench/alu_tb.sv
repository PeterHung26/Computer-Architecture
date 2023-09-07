`include "alu_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns/1 ns

module alu_tb;

  parameter PERIOD = 10;
  logic CLK = 0;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  alu_if aluif();
  // test program
  test #(.PERIOD (PERIOD)) PROG (
    .clk(CLK),
    .aluif(aluif.tb)
  );
  //DUT
  `ifndef MAPPED
    alu ALU(CLK, aluif.alu);
  `else
    alu ALU(
        .\aluif.porta (aluif.porta),
        .\aluif.portb (aluif.portb),
        .\aluif.aluop (aluif.aluop),
        .\aluif.portout (aluif.portout),
        .\aluif.negative (aluif.negative),
        .\aluif.overflow (aluif.overflow),
        .\aluif.zero (aluif.zero),
        .\clk (CLK)
    );
  `endif


endmodule


program test(
  input logic clk,
  alu_if aluif
);
  import cpu_types_pkg::*;
  task check_portout;
    input logic [31:0] exp;
    input string op;
    begin
        if(aluif.portout == exp)
            $display("Output of %s operation is correct",op);
        else
            $display("Output of %s operation is not correct",op);
        #5;
    end
  endtask

  task check_flag;
    input logic exp_neg;
    input logic exp_over;
    input logic exp_zero;
    begin
        if(aluif.negative == exp_neg)
            $display("Negative flag is as expected.");
        else
            $display("Negative flag is not as expected");

        if(aluif.overflow == exp_over)
            $display("Overflow flag is as expected.");
        else
            $display("Overflow flag is not as expected");
        
        if(aluif.zero == exp_zero)
            $display("Zero flag is as expected.");
        else
            $display("Zero flag is not as expected");
        #5;
    end
  endtask

  task setup;
    input aluop_t op;
    input logic [31:0] pa;
    input logic [31:0] pb;
    begin
        aluif.aluop = op;
        aluif.porta = pa;
        aluif.portb = pb;
        #5;
    end
  endtask

  parameter PERIOD = 10;
  int tb_test_num;

  initial begin
    tb_test_num = 0;
    //Test case 1: SLL and SRL
    tb_test_num ++;
    setup(ALU_SLL, 32'd8, 32'hffffffff);
    check_portout(32'hffffff00, "SLL");
    check_flag(1,0,0);
    setup(ALU_SRL, 32'd8, 32'hffffffff);
    check_portout(32'h00ffffff, "SRL");
    check_flag(0,0,0);

    //Test case 2: ADD and SUB without overflow
    tb_test_num ++;
    setup(ALU_ADD, 32'h00ffffff, 32'd1);
    check_portout(32'h01000000, "ADD");
    check_flag(0,0,0);
    setup(ALU_SUB, 32'hffffffff, 32'd1);
    check_portout(32'hfffffffe, "SUB");
    check_flag(1,0,0);

    //Test case 3: ADD and SUB with overflow
    tb_test_num ++;
    setup(ALU_ADD, 32'h7fffffff, 32'd1);
    check_portout(32'h80000000, "ADD");
    check_flag(1,1,0);
    setup(ALU_SUB, 32'h80000000, 32'd1);
    check_portout(32'h7fffffff, "SUB");
    check_flag(0,1,0);

    //Test case 4: AND, OR, XOR, NOR
    tb_test_num ++;
    setup(ALU_AND, 32'h00000000, 32'hffffff0f);
    check_portout(32'h00000000, "AND");
    check_flag(0,0,1);
    setup(ALU_OR, 32'h00000000, 32'hffffff0f);
    check_portout(32'hffffff0f, "OR");
    check_flag(1,0,0);
    setup(ALU_XOR, 32'hf0000000, 32'hffffff0f);
    check_portout(32'h0fffff0f, "XOR");
    check_flag(0,0,0);
    setup(ALU_NOR, 32'hf0000000, 32'hffffff0f);
    check_portout(32'h000000f0, "NOR");
    check_flag(0,0,0);

    //Test case 4: SLT and SLTU
    tb_test_num ++;
    setup(ALU_SLT, 32'h00000000, 32'hffffff0f);
    check_portout(32'd0, "SLT");
    check_flag(0,0,1);
    setup(ALU_SLTU, 32'h00000000, 32'hffffff0f);
    check_portout(32'd1, "SLTU");
    check_flag(0,0,0);
    $stop();

  end

endprogram