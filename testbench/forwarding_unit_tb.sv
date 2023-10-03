`include "forwarding_unit_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns/1 ns

module forwarding_unit_tb;
    parameter PERIOD = 10;
    logic CLK = 0;
    // clock
    always #(PERIOD/2) CLK++;

    //interface
    forwarding_unit_if fuif();
    //test program
    test #(.PERIOD (PERIOD)) PROG (
        .CLK(CLK),
        .fuif(fuif)
    );
    // DUT
    `ifndef MAPPED
        forwarding_unit DUT(CLK, fuif);
    `else
        hazard_unit DUT(
            .\fuif.ID_rs (fuif.ID_rs),
            .\fuif.ID_rt (fuif.ID_rt),
            .\fuif.EX_RegWrite (fuif.EX_RegWrite),
            .\fuif.EX_wsel (fuif.EX_wsel),
            .\fuif.MEM_RegWrite (fuif.MEM_RegWrite),
            .\fuif.MEM_wsel (fuif.MEM_wsel),
            .\fuif.forwarda (fuif.forwarda),
            .\fuif.forwardb (fuif.forwardb),
            .\CLK (CLK)
        );
    `endif
endmodule

program test(
    input logic CLK,
    forwarding_unit_if fuif
);
    import cpu_types_pkg::*;
    parameter PERIOD = 10;
    int tb_test_num;
    string tb_test_case;

    task check_output;
    input logic [1:0] exp_fa;
    input logic [1:0] exp_fb;
    begin
        $display(tb_test_case);
        if(exp_fa == fuif.forwarda) begin
            $display("Forwarding a is as expected: %0d", fuif.forwarda);
        end
        else begin
            $display("Forwarding a is as expected: %0d", fuif.forwarda);
        end
        if(exp_fb == fuif.forwardb) begin
            $display("Forwarding b is as expected: %0d", fuif.forwardb);
        end
        else begin
            $display("Forwarding b not is as expected: %0d", fuif.forwardb);
        end
    end
    endtask

    initial begin
        tb_test_num = 0;
        tb_test_case = "Start";
        fuif.EX_RegWrite = 1'b0;
        fuif.MEM_RegWrite = 1'b0;
        fuif.ID_rs = 5'b0;
        fuif.ID_rt = 5'b0;
        fuif.EX_wsel = 5'b0;
        fuif.MEM_wsel = 5'b0;
        @(negedge CLK);
        // Case 1: rs of EX stage is same as wsel of MEM stage and RegWrite of MEM stage is 1
        tb_test_num++;
        tb_test_case = "rs of EX stage is same as wsel of MEM stage and RegWrite of MEM stage is 1";
        fuif.EX_RegWrite = 1'b1;
        fuif.ID_rs = 5'd3;
        fuif.EX_wsel = 5'd3;
        @(negedge CLK);
        check_output(2'd1, 2'd0);
        fuif.EX_RegWrite = 1'b0;
        fuif.ID_rs = 5'd0;
        fuif.EX_wsel = 5'd0;
        // Case 2: rs of EX stage is same as wsel of WB stage and RegWrite of WB stage is 1
        tb_test_num++;
        tb_test_case = "rs of EX stage is same as wsel of WB stage and RegWrite of WB stage is 1";
        fuif.MEM_RegWrite = 1'b1;
        fuif.ID_rs = 5'd3;
        fuif.MEM_wsel = 5'd3;
        @(negedge CLK);
        check_output(2'd2, 2'd0);
        fuif.MEM_RegWrite = 1'b0;
        fuif.ID_rs = 5'd0;
        fuif.MEM_wsel = 5'd0;
        // Case 3: rt of EX stage is same as wsel of MEM stage and RegWrite of MEM stage is 1
        tb_test_num++;
        tb_test_case = "rt of EX stage is same as wsel of MEM stage and RegWrite of MEM stage is 1";
        fuif.EX_RegWrite = 1'b1;
        fuif.ID_rt = 5'd3;
        fuif.EX_wsel = 5'd3;
        @(negedge CLK);
        check_output(2'd0, 2'd1);
        fuif.EX_RegWrite = 1'b0;
        fuif.ID_rt = 5'd0;
        fuif.EX_wsel = 5'd0;
        // Case 4: rt of EX stage is same as wsel of WB stage and RegWrite of WB stage is 1
        tb_test_num++;
        tb_test_case = "rs of EX stage is same as wsel of WB stage and RegWrite of WB stage is 1";
        fuif.MEM_RegWrite = 1'b1;
        fuif.ID_rt = 5'd3;
        fuif.MEM_wsel = 5'd3;
        @(negedge CLK);
        check_output(2'd0, 2'd2);
        fuif.MEM_RegWrite = 1'b0;
        fuif.ID_rt = 5'd0;
        fuif.MEM_wsel = 5'd0;
        // Case 5: RegWrites are all zero in MEM stage and WB stage
        tb_test_num++;
        tb_test_case = "RegWrites are all zero in MEM stage and WB stage";
        fuif.ID_rt = 5'd3;
        fuif.ID_rs = 5'd3;
        fuif.MEM_wsel = 5'd3;
        fuif.EX_wsel = 5'd3;
        @(negedge CLK);
        check_output(2'd0, 2'd0);
        fuif.ID_rt = 5'd0;
        fuif.ID_rs = 5'd0;
        fuif.MEM_wsel = 5'd0;
        fuif.EX_wsel = 5'd0;
        // Case 6: RegWrite are all one in MEM stage and WB stage
        tb_test_num++;
        tb_test_case = "RegWrites are all one in MEM stage and WB stage";
        fuif.EX_RegWrite = 1'b1;
        fuif.MEM_RegWrite = 1'b1;
        fuif.ID_rt = 5'd3;
        fuif.ID_rs = 5'd3;
        fuif.MEM_wsel = 5'd3;
        fuif.EX_wsel = 5'd3;
        @(negedge CLK);
        check_output(2'd1, 2'd1);
        fuif.EX_RegWrite = 1'b0;
        fuif.MEM_RegWrite = 1'b0;
        fuif.ID_rt = 5'd0;
        fuif.ID_rs = 5'd0;
        fuif.MEM_wsel = 5'd0;
        fuif.EX_wsel = 5'd0;
        // Case 7: rs and rt of EX stage is same as wsel of MEM stage and Regwrite of MEM stage is 1
        tb_test_num++;
        tb_test_case = "rs and rt of EX stage is same as wsel of MEM stage and Regwrite of MEM stage is 1";
        fuif.EX_RegWrite = 1'b1;
        fuif.ID_rs = 5'd3;
        fuif.ID_rt = 5'd3;
        fuif.EX_wsel = 5'd3;
        @(negedge CLK);
        check_output(2'd1, 2'd1);
        fuif.EX_RegWrite = 1'b0;
        fuif.ID_rs = 5'd0;
        fuif.ID_rt = 5'd0;
        fuif.EX_wsel = 5'd0;
        // Case 8: rs and rt of EX stage is same as wsel of WB stage and Regwrite of WB stage is 1
        tb_test_num++;
        tb_test_case = "rs and rt of EX stage is same as wsel of WB stage and Regwrite of WB stage is 1";
        fuif.MEM_RegWrite = 1'b1;
        fuif.ID_rs = 5'd3;
        fuif.ID_rt = 5'd3;
        fuif.MEM_wsel = 5'd3;
        @(negedge CLK);
        check_output(2'd2, 2'd2);
        fuif.MEM_RegWrite = 1'b0;
        fuif.ID_rs = 5'd0;
        fuif.ID_rt = 5'd0;
        fuif.MEM_wsel = 5'd0;
        @(posedge CLK);
        @(posedge CLK);
        $stop();
    end
endprogram