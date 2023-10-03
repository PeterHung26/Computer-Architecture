`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns/1 ns

module hazard_unit_tb;
    parameter PERIOD = 10;
    logic CLK = 0, nRST;
    // clock
    always #(PERIOD/2) CLK++;

    //interface
    hazard_unit_if huif();
    //test program
    test #(.PERIOD (PERIOD)) PROG (
        .CLK(CLK),
        .nRST(nRST),
        .huif(huif)
    );
    // DUT
    `ifndef MAPPED
        hazard_unit DUT(CLK, nRST, huif);
    `else
        hazard_unit DUT(
            .\huif.dhit (huif.dhit),
            .\huif.ihit (huif.ihit),
            .\huif.cu_halt (huif.cu_halt),
            .\huif.cu_Jump (huif.cu_Jump),
            .\huif.ID_JR (huif.ID_JR),
            .\huif.ID_dread (huif.ID_dread),
            .\huif.PCSrc (huif.PCSrc),
            .\huif.ID_rt (huif.ID_rt),
            .\huif.IF_rs (huif.IF_rs),
            .\huif.IF_rt (huif.IF_rt),
            .\huif.IF_EN (huif.IF_EN),
            .\huif.ID_EN (huif.ID_EN),
            .\huif.EX_EN (huif.EX_EN),
            .\huif.MEM_EN (huif.MEM_EN),
            .\huif.IF_FLUSH (huif.IF_FLUSH),
            .\huif.ID_FLUSH (huif.ID_FLUSH),
            .\huif.EX_FLUSH (huif.EX_FLUSH),
            .\huif.MEM_FLUSH (huif.MEM_FLUSH),
            .\huif.PC_EN (huif.PC_EN),
            .\huif.iREN (huif.iREN),
            .\huif.pr_halt (huif.pr_halt),
            .\nRST (nRST),
            .\CLK (CLK)
        );
    `endif
endmodule

program test(
    input logic CLK,
    output logic nRST,
    hazard_unit_if huif
);
    import cpu_types_pkg::*;
    parameter PERIOD = 10;
    int tb_test_num;
    string tb_test_case;

    task reset_iread;
    begin
        nRST = 0;
        @(posedge CLK);
        @(posedge CLK);
        @(negedge CLK);
        nRST = 1;
        if(huif.iREN == 1'b1)
            $display("iREN is as expected: 1'b1");
        else
            $display("iREN is as expected: 1'b1");
    end
    endtask

    task check_preg_en;
    begin
        $display(tb_test_case);
        if((huif.ihit == 0) && (huif.dhit == 0)) begin
            if(huif.PC_EN == 1'b0) begin
                $display("PC_EN is as expected: 1'b0");
            end
            else begin
                $display("PC_EN is not as expected: 1'b1");
            end
            if(huif.IF_EN == 1'b0) begin
                $display("IF_EN is as expected: 1'b0");
            end
            else begin
                $display("IF_EN is not as expected: 1'b1");
            end
            if(huif.ID_EN == 1'b0) begin
                $display("ID_EN is as expected: 1'b0");
            end
            else begin
                $display("ID_EN is not as expected: 1'b1");
            end
            if(huif.EX_EN == 1'b0) begin
                $display("EX_EN is as expected: 1'b0");
            end
            else begin
                $display("EX_EN is not as expected: 1'b1");
            end
            if(huif.MEM_EN == 1'b0) begin
                $display("MEM_EN is as expected: 1'b0");
            end
            else begin
                $display("MEM_EN is not as expected: 1'b1");
            end
        end
        else if(huif.ID_dread && !huif.PCSrc && ((huif.ID_rt == huif.IF_rs) || (huif.ID_rt == huif.IF_rt))) begin
            if(huif.cu_Jump) begin
                if(huif.PC_EN == 1'b0) begin
                    $display("PC_EN not is as expected: 1'b0");
                end
                else begin
                    $display("PC_EN is as expected: 1'b1");
                end
                if(huif.IF_EN == 1'b0) begin
                    $display("IF_EN is not as expected: 1'b0");
                end
                else begin
                    $display("IF_EN is as expected: 1'b1");
                end
            end
            else if(huif.cu_halt) begin
                if(huif.PC_EN == 1'b0) begin
                    $display("PC_EN is as expected: 1'b0");
                end
                else begin
                    $display("PC_EN is not as expected: 1'b1");
                end
                if(huif.IF_EN == 1'b0) begin
                    $display("IF_EN is as expected: 1'b0");
                end
                else begin
                    $display("IF_EN is not as expected: 1'b1");
                end
            end
            else begin
                if(huif.PC_EN == 1'b0) begin
                    $display("PC_EN is as expected: 1'b0");
                end
                else begin
                    $display("PC_EN is not as expected: 1'b1");
                end
                if(huif.IF_EN == 1'b0) begin
                    $display("IF_EN is as expected: 1'b0");
                end
                else begin
                    $display("IF_EN is not as expected: 1'b1");
                end
            end
        end
        else if(!huif.ID_JR && !huif.cu_Jump && huif.cu_halt) begin
            if(huif.PC_EN == 1'b0) begin
                $display("PC_EN is as expected: 1'b0");
            end
            else begin
                $display("PC_EN is not as expected: 1'b1");
            end
            if(huif.IF_EN == 1'b0) begin
                $display("IF_EN is as expected: 1'b0");
            end
            else begin
                $display("IF_EN is not as expected: 1'b1");
            end
        end
        else if(huif.dhit) begin
            if(huif.PC_EN == 1'b0) begin
                $display("PC_EN is as expected: 1'b0");
            end
            else begin
                $display("PC_EN is not as expected: 1'b1");
            end
        end
        else begin
            if(huif.PC_EN == 1'b1) begin
                $display("PC_EN is as expected: 1'b1");
            end
            else begin
                $display("PC_EN is not as expected: 1'b0");
            end
            if(huif.IF_EN == 1'b1) begin
                $display("IF_EN is as expected: 1'b1");
            end
            else begin
                $display("IF_EN is not as expected: 1'b0");
            end
            if(huif.ID_EN == 1'b1) begin
                $display("ID_EN is as expected: 1'b1");
            end
            else begin
                $display("ID_EN is not as expected: 1'b0");
            end
            if(huif.EX_EN == 1'b1) begin
                $display("EX_EN is as expected: 1'b1");
            end
            else begin
                $display("EX_EN is not as expected: 1'b0");
            end
            if(huif.MEM_EN == 1'b1) begin
                $display("MEM_EN is as expected: 1'b1");
            end
            else begin
                $display("MEM_EN is not as expected: 1'b0");
            end
        end
    end
    endtask

    task check_preg_flush;
    begin
        if(huif.PCSrc && !((huif.ihit == 0) && (huif.dhit == 0))) begin
            if(huif.MEM_FLUSH) begin
                $display("MEM_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("MEM_FLUSH is as expected: 1'b0");
            end
            if(huif.EX_FLUSH) begin
                $display("EX_FLUSH is as expected: 1'b1");
            end
            else begin
                $display("EX_FLUSH is not as expected: 1'b0");
            end
            if(huif.ID_FLUSH) begin
                $display("ID_FLUSH is as expected: 1'b1");
            end
            else begin
                $display("ID_FLUSH is not as expected: 1'b0");
            end
            if(huif.IF_FLUSH) begin
                $display("IF_FLUSH is as expected: 1'b1");
            end
            else begin
                $display("IF_FLUSH is not as expected: 1'b0");
            end
        end
        else if(huif.ID_dread && ((huif.ID_rt == huif.IF_rs) || (huif.ID_rt == huif.IF_rt))) begin
            if(huif.cu_Jump) begin
                if(huif.IF_FLUSH) begin
                    $display("IF_FLUSH is as expected: 1'b1");
                end
                else begin
                    $display("IF_FLUSH is not as expected: 1'b0");
                end
                if(huif.ID_FLUSH) begin
                    $display("ID_FLUSH is not as expected: 1'b1");
                end
                else begin
                    $display("ID_FLUSH is as expected: 1'b0");
                end
            end
            else begin
                if(huif.IF_FLUSH) begin
                    $display("IF_FLUSH is not as expected: 1'b1");
                end
                else begin
                    $display("IF_FLUSH is as expected: 1'b0");
                end
                if(huif.ID_FLUSH) begin
                    $display("ID_FLUSH is as expected: 1'b1");
                end
                else begin
                    $display("ID_FLUSH is not as expected: 1'b0");
                end
            end
            if(huif.MEM_FLUSH) begin
                $display("MEM_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("MEM_FLUSH is as expected: 1'b0");
            end
            if(huif.EX_FLUSH) begin
                $display("EX_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("EX_FLUSH is as expected: 1'b0");
            end
        end
        else if(huif.ID_JR) begin  // JR control flow hazard (found at EX stage)
            if(huif.IF_FLUSH) begin
                $display("IF_FLUSH is as expected: 1'b1");
            end
            else begin
                $display("IF_FLUSH is not as expected: 1'b0");
            end
            if(huif.ID_FLUSH) begin
                $display("ID_FLUSH is as expected: 1'b1");
            end
            else begin
                $display("ID_FLUSH is not as expected: 1'b0");
            end
            if(huif.MEM_FLUSH) begin
                $display("MEM_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("MEM_FLUSH is as expected: 1'b0");
            end
            if(huif.EX_FLUSH) begin
                $display("EX_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("EX_FLUSH is as expected: 1'b0");
            end
        end
        else if(huif.cu_Jump) begin //Jump and JAL control flow hazard (found at DCD stage)
            if(huif.IF_FLUSH) begin
                $display("IF_FLUSH is as expected: 1'b1");
            end
            else begin
                $display("IF_FLUSH is not as expected: 1'b0");
            end
            if(huif.ID_FLUSH) begin
                $display("ID_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("ID_FLUSH is as expected: 1'b0");
            end
            if(huif.MEM_FLUSH) begin
                $display("MEM_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("MEM_FLUSH is as expected: 1'b0");
            end
            if(huif.EX_FLUSH) begin
                $display("EX_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("EX_FLUSH is as expected: 1'b0");
            end
        end
        else if(huif.cu_halt) begin // Halt
            if(huif.IF_FLUSH) begin
                $display("IF_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("IF_FLUSH is as expected: 1'b0");
            end
            if(huif.ID_FLUSH) begin
                $display("ID_FLUSH is as expected: 1'b1");
            end
            else begin
                $display("ID_FLUSH is not as expected: 1'b0");
            end
            if(huif.MEM_FLUSH) begin
                $display("MEM_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("MEM_FLUSH is as expected: 1'b0");
            end
            if(huif.EX_FLUSH) begin
                $display("EX_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("EX_FLUSH is as expected: 1'b0");
            end
        end
        else if(huif.dhit) begin //Structural hazard
            huif.IF_FLUSH = 1'b1;
            if(huif.IF_FLUSH) begin
                $display("IF_FLUSH is as expected: 1'b1");
            end
            else begin
                $display("IF_FLUSH is not as expected: 1'b0");
            end
            if(huif.ID_FLUSH) begin
                $display("ID_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("ID_FLUSH is as expected: 1'b0");
            end
            if(huif.MEM_FLUSH) begin
                $display("MEM_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("MEM_FLUSH is as expected: 1'b0");
            end
            if(huif.EX_FLUSH) begin
                $display("EX_FLUSH is not as expected: 1'b1");
            end
            else begin
                $display("EX_FLUSH is as expected: 1'b0");
            end
        end
    end
    endtask

    task haltt;
    begin
        if(!(!huif.ihit && !huif.dhit) && !(huif.PCSrc) && 
        !(huif.ID_dread && ((huif.ID_rt == huif.IF_rs) || (huif.ID_rt == huif.IF_rt))) && !(huif.ID_JR) && !(huif.cu_Jump)
        && (huif.cu_halt)) begin
            if(huif.pr_halt) begin
                $display("pr_halt is as expected: 1'b1");
            end
            else begin
                $display("pr_halt is not as expected: 1'b0");
            end
        end
        else begin
            if(huif.pr_halt) begin
                $display("pr_halt is not as expected: 1'b1");
            end
            else begin
                $display("pr_halt is as expected: 1'b0");
            end
        end
    end
    endtask

    task mem_iREN;
    input logic exp_iREN;
    begin
        if(exp_iREN == huif.iREN) begin
            $display("iREN is as espected: %0b", huif.iREN);
        end
        else begin
            $display("iREN is not as espected: %0b", huif.iREN);
        end
    end
    endtask

    initial begin
        tb_test_num = 0;
        tb_test_case = "Start";
        nRST = 1'b1;
        huif.dhit = 1'b0;
        huif.ihit = 1'b1;
        huif.cu_halt = 1'b0;
        huif.cu_Jump = 1'b0;
        huif.ID_JR = 1'b0;
        huif.ID_dread = 1'b0;
        huif.PCSrc = 1'b0;
        huif.ID_rt = 5'b0;
        huif.IF_rs = 5'b0;
        huif.IF_rt = 5'b0;
        reset_iread();
        // Case 1: ihit and dhit = 0
        tb_test_num++;
        tb_test_case = "ihit and dhit = 0";
        huif.dhit = 1'b0;
        huif.ihit = 1'b0;
        @(negedge CLK);
        check_preg_en();
        check_preg_flush();
        haltt();
        mem_iREN(1'b1);
        huif.dhit = 1'b0;
        huif.ihit = 1'b1;
        // Case 2: Branch
        tb_test_num++;
        tb_test_case = "Branch";
        huif.PCSrc = 1'b1;
        @(negedge CLK);
        check_preg_en();
        check_preg_flush();
        haltt();
        mem_iREN(1'b1);
        huif.PCSrc = 1'b0;
        // Case 3: Load dependency and Jump in Decode stage
        tb_test_num++;
        tb_test_case = "Load dependency and Jump in Decode stage";
        huif.ID_dread = 1'b1;
        huif.ID_rt = 5'd3;
        huif.IF_rs = 5'd3;
        huif.cu_Jump = 1'b1;
        @(negedge CLK);
        check_preg_en();
        check_preg_flush();
        haltt();
        mem_iREN(1'b1);
        huif.cu_Jump = 1'b0;
        // Case 4: Load dependency and halt in Decode stage
        tb_test_num++;
        tb_test_case = "Load dependency and halt in Decode stage";
        huif.cu_halt = 1'b1;
        @(negedge CLK);
        check_preg_en();
        check_preg_flush();
        haltt();
        mem_iREN(1'b0);
        huif.cu_halt = 1'b0;
        // Case 5: Load dependency without Jump and Halt in Decode stage
        tb_test_num++;
        tb_test_case = "Load dependency without Jump and Halt in Decode stage";
        @(negedge CLK);
        check_preg_en();
        check_preg_flush();
        haltt();
        mem_iREN(1'b1);
        huif.ID_dread = 1'b0;
        huif.ID_rt = 5'd0;
        huif.IF_rs = 5'd0;
        // Case 6: JR control flow hazard (found at EX stage)
        tb_test_num++;
        tb_test_case = "JR control flow hazard (found at EX stage)";
        huif.ID_JR = 1'b1;
        @(negedge CLK);
        check_preg_en();
        check_preg_flush();
        haltt();
        mem_iREN(1'b1);
        huif.ID_JR = 1'b0;
        // Case 7: Jump and JAL control flow hazard (found at DCD stage)
        tb_test_num++;
        tb_test_case = "Jump and JAL control flow hazard (found at DCD stage)";
        huif.cu_Jump = 1'b1;
        @(negedge CLK);
        check_preg_en();
        check_preg_flush();
        haltt();
        mem_iREN(1'b1);
        huif.cu_Jump = 1'b0;
        // Case 8: Halt
        tb_test_num++;
        tb_test_case = "Halt at DCD stage";
        huif.cu_halt = 1'b1;
        @(negedge CLK);
        check_preg_en();
        check_preg_flush();
        haltt();
        mem_iREN(1'b0);
        huif.cu_halt = 1'b0;
        // Case 9: Structural hazard (read insturcion and memory at the same time)
        tb_test_num++;
        tb_test_case = "Structural hazard (read insturcion and memory at the same time)";
        huif.ihit = 1'b0;
        huif.dhit = 1'b1;
        @(negedge CLK);
        check_preg_en();
        check_preg_flush();
        haltt();
        mem_iREN(1'b1);
        huif.ihit = 1'b1;
        huif.dhit = 1'b0;
        @(posedge CLK);
        @(posedge CLK);
        $stop();
    end


endprogram