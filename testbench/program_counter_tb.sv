`include "program_counter_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns/1 ns

module program_counter_tb;

    parameter PERIOD = 10;
    logic CLK = 0, nRST;
    // clock
    always #(PERIOD/2) CLK++;

    //interface
    program_counter_if pcif();
    // test program
    test #(.PERIOD (PERIOD)) PROG (
        .CLK(CLK),
        .nRST(nRST),
        .pcif(pcif)
    );

    // DUT
    `ifndef MAPPED
    program_counter DUT(CLK, nRST, pcif);
    `else
    program_counter DUT(
        .\pcif.Branch (pcif.Branch),
        .\pcif.Jump (pcif.Jump),
        .\pcif.JR (pcif.JR),
        .\pcif.ihit (pcif.ihit),
        .\pcif.bimm (pcif.bimm),
        .\pcif.jimm (pcif.jimm),
        .\pcif.jraddr (pcif.jraddr),
        .\pcif.nxt_pc (pcif.nxt_pc),
        .\pcif.pcaddr (pcif.pcaddr),
        .\CLK (CLK),
        .\nRST(nRST)
    );
    `endif
endmodule

program test(
  input logic CLK,
  output logic nRST,
  program_counter_if.tb pcif
);
    import cpu_types_pkg::*;
    parameter PERIOD = 10;
    int tb_test_num;
    string tb_test_case;

    task reset_dut;
    begin
        nRST = 0;
        @(posedge CLK);
        @(posedge CLK);
        @(negedge CLK);
        nRST = 1;
    end
    endtask

    task branch_pc;
    input logic hit;
    input logic bsig;
    input word_t imm;
    begin
        pcif.ihit = hit;
        pcif.Branch = bsig;
        pcif.bimm = imm;
        @(negedge CLK);
    end
    endtask

    task jump_pc;
    input logic hit;
    input logic jsig;
    input logic [ADDR_W-1:0] imm;
    begin
        pcif.ihit = hit;
        pcif.Jump = jsig;
        pcif.jimm = imm;
        @(negedge CLK);
    end
    endtask

    task jr_pc;
    input logic hit;
    input logic jrsig;
    input word_t jadr;
    begin
        pcif.ihit = hit;
        pcif.JR = jrsig;
        pcif.jraddr = jadr;
        @(negedge CLK);
    end
    endtask

    task check_addr;
    input word_t exp_pc;
    begin
        if(pcif.pcaddr == exp_pc)
            $display("The Address is as expected: %0h",pcif.pcaddr);
        else
            $error("The Address is not as expected: %0h",pcif.pcaddr);
        pcif.Branch = 1'b0;
        pcif.Jump = 1'b0;
        pcif.JR = 1'b0;
    end
    endtask

    initial begin
        tb_test_num = 0;
        tb_test_case = "Start";
        // Reset
        tb_test_num++;
        tb_test_case = "Reset";
        reset_dut();
        check_addr(32'b0);
        // Branch not taken, ihit = 1
        tb_test_num++;
        tb_test_case = "Branch not taken, ihit = 1";
        branch_pc(1'b1, 1'b0, 32'd15);
        check_addr(32'd4);
        //Branch taken, ihit = 1
        tb_test_num++;
        tb_test_case = "Branch taken, ihit = 1";
        branch_pc(1'b1, 1'b1, 32'd15);
        check_addr(32'd64);
        //Jump or JAL not taken, ihit = 1
        tb_test_num++;
        tb_test_case = "Jump or JAL not taken, ihit = 1";
        jump_pc(1'b1, 1'b0, 26'd8787);
        check_addr(32'd68);
        //Jump or JAL taken, ihit = 1
        tb_test_num++;
        tb_test_case = "Jump or JAL taken, ihit = 1";
        jump_pc(1'b1, 1'b1, 26'd8787);
        check_addr(32'd35148);
        //JR not taken, ihit = 1
        tb_test_num++;
        tb_test_case = "JR not taken, ihit = 1";
        jr_pc(1'b1, 1'b0, 32'd84264);
        check_addr(32'd35152);
        //JR taken, ihit = 1
        tb_test_num++;
        tb_test_case = "JR taken, ihit = 1";
        jr_pc(1'b1, 1'b1, 32'd84264);
        check_addr(32'd84264);
        //Branch taken, ihit = 0
        tb_test_num++;
        tb_test_case = "Branch taken, ihit = 0";
        branch_pc(1'b0, 1'b1, 32'd15);
        check_addr(32'd84264);
        //Jump or JAL taken, ihit = 0
        tb_test_num++;
        tb_test_case = "Jump or JAL taken, ihit = 0";
        jump_pc(1'b0, 1'b1, 26'd8787);
        check_addr(32'd84264);
        //JR taken, ihit = 0
        tb_test_num++;
        tb_test_case = "JR taken, ihit = 0";
        jr_pc(1'b0, 1'b1, 32'd88000);
        check_addr(32'd84264);
    end
endprogram