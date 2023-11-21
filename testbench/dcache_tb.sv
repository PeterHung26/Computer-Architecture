`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns/1 ns

module dcache_tb;
    parameter PERIOD = 10;
    logic CLK = 0, nRST;
    // clock
    always #(PERIOD/2) CLK++;

    //interface
    datapath_cache_if dcif();
    caches_if dif();
    logic have;
    // test program
    test #(.PERIOD (PERIOD)) PROG (
        .CLK(CLK),
        .nRST(nRST),
        .dcif(dcif),
        .dif(dif),
        .have(have)
    );
    // DUT
    `ifndef MAPPED
        dcache DUT(CLK, nRST, dcif, dif, have);
    `else
        dcache DUT(
            .\dcif.halt (dcif.halt),
            .\dcif.dmemREN (dcif.dmemREN),
            .\dcif.dmemWEN (dcif.dmemWEN),
            .\dcif.datomic (dcif.datomic),
            .\dcif.dmemstore (dcif.dmemstore),
            .\dcif.dmemaddr (dcif.dmemaddr),
            .\dcif.dhit (dcif.dhit),
            .\dcif.dmemload (dcif.dmemload),
            .\dcif.flushed (dcif.flushed),
            .\dif.dwait (dif.dwait),
            .\dif.dload (dif.dload),
            .\dif.ccwait (dif.ccwait),
            .\dif.ccinv (dif.ccinv),
            .\dif.ccsnoopaddr (dif.ccsnoopaddr),
            .\dif.dREN (dif.dREN),
            .\dif.dWEN (dif.dWEN),
            .\dif.daddr (dif.daddr),
            .\dif.dstore (dif.dstore),
            .\dif.ccwrite (dif.ccwrite),
            .\dif.cctrans (dif.cctrans),
            .\nRST (nRST),
            .\CLK (CLK),
            .\have(have)
        );
    `endif
endmodule

program test(
    input logic CLK,
    output logic nRST,
    datapath_cache_if dcif,
    caches_if dif,
    input logic have

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

    task set_load;
    input logic [31:0] load_addr;
    begin
        dcif.dmemaddr = load_addr;
        dcif.dmemREN = 1'b1;
    end
    endtask

    task set_store;
    input logic [31:0] store_addr;
    input logic [31:0] store_data;
    begin
        dcif.dmemaddr = store_addr;
        dcif.dmemWEN = 1'b1;
        dcif.dmemstore = store_data;
    end
    endtask

    task check_out;
    input logic exp_dREN;
    input logic exp_dWEN;
    input logic exp_dhit;
    input logic [31:0] exp_dmemload;
    input logic exp_flushed;
    input logic [31:0] exp_dstore;
    input logic exp_have;
    input logic exp_ccwrite;
    input logic exp_cctrans;
    begin
        $display(tb_test_case);
        if(dif.dREN == exp_dREN)
            $display("The dREN value is as expected: %0h", dif.dREN);
        else
            $display("The dREN value is not as expected: %0h", dif.dREN);
        if(dif.dWEN == exp_dWEN)
            $display("The dWEN value is as expected: %0h", dif.dWEN);
        else
            $display("The dWEN value is not as expected: %0h", dif.dWEN);
        if(dcif.dhit == exp_dhit)
            $display("The dhit value is as expected: %0h", dcif.dhit);
        else
            $display("The dhit value is not as expected: %0h", dcif.dhit);
        if(dcif.dmemload == exp_dmemload)
            $display("The dmemload value is as expected: %0h", dcif.dmemload);
        else
            $display("The dmemload value is not as expected: %0h", dcif.dmemload);
        if(dcif.flushed == exp_flushed)
            $display("The flushed value is as expected: %0h", dcif.flushed);
        else
            $display("The flushed value is not as expected: %0h", dcif.flushed);
        if(dif.dstore == exp_dstore)
            $display("The dstore value is as expected: %0h", dif.dstore);
        else
            $display("The dstore value is not as expected: %0h", dif.dstore);
        if(have == exp_have)
            $display("The have value is as expected: %0h", have);
        else
            $display("The have value is not as expected: %0h", have);
        if(dif.ccwrite == exp_ccwrite)
            $display("The ccwrite value is as expected: %0h", dif.ccwrite);
        else
            $display("The ccwrite value is not as expected: %0h", dif.ccwrite);
        if(dif.cctrans == exp_cctrans)
            $display("The cctrans value is as expected: %0h", dif.cctrans);
        else
            $display("The cctrans value is not as expected: %0h", dif.cctrans);
    end
    endtask

    initial begin
        tb_test_num = -1;
        tb_test_case = "Start";
        dcif.halt = 1'b0;
        dcif.dmemREN = 1'b0;
        dcif.dmemWEN = 1'b0;
        dcif.datomic = 1'b0;
        dcif.dmemstore = '0;
        dcif.dmemaddr = 1'b0;
        dif.dwait = 1'b1;
        dif.dload = '0;
        dif.ccwait = '0;
        dif.ccinv = '0;
        dif.ccsnoopaddr = '0;
        // Case 0: Reset
        tb_test_num++;
        tb_test_case = "Reset";
        reset_dut();
        // Case 1: Initial Load Data Right(DEAD and BADB) 
        tb_test_num++;
        tb_test_case = "Initial Load Data Right(DEAD and BADB)";
        @(negedge CLK);
        set_load(32'h00000000);
        check_out(1'b0,1'b0, 1'b0, '0, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0); // no dhit
        @(negedge CLK); // CHECK
        @(negedge CLK); // IRD1
        check_out(1'b1, 1'b0, 1'b0, '0, 1'b0, 32'b0, 1'b0, 1'b0, 1'b1);
        @(negedge CLK); // Still in IRD1
        dif.dwait = 1'b0;
        dif.dload = 32'h0000DEAD;
        @(negedge CLK); // IRD2
        dif.dwait = 1'b1;
        check_out(1'b1, 1'b0, 1'b0, '0, 1'b0,  32'b0, 1'b0, 1'b0, 1'b1);
        @(negedge CLK); // Still in WAIT2
        dif.dwait = 1'b0;
        dif.dload = 32'h0000BADB;
        @(negedge CLK); // Back to GOOD
        check_out(1'b0, 1'b0, 1'b1, 32'h0000DEAD, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0);
        @(negedge CLK);
        dcif.dmemREN = 1'b0;
        dcif.dmemaddr = '0;
        dif.dwait = 1'b1;
        // Case 2: Initial load Data Left(8787 and 5454)
        tb_test_num++;
        tb_test_case = "Initial load Data Left(8787 and 5454)";
        @(posedge CLK);
        set_load(32'h80000000);
        @(negedge CLK);
        check_out(1'b0,1'b0, 1'b0, '0, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0); // no dhit
        @(negedge CLK); // CHECK
        @(negedge CLK); // IRD1
        check_out(1'b1, 1'b0, 1'b0, '0, 1'b0, 32'b0, 1'b0, 1'b0, 1'b1);
        @(negedge CLK); // Still in IRD1
        dif.dwait = 1'b0;
        dif.dload = 32'h00008787;
        @(negedge CLK); // IRD2
        dif.dwait = 1'b1;
        check_out(1'b1, 1'b0, 1'b0, '0, 1'b0, 32'b0, 1'b0, 1'b0, 1'b1);
        @(negedge CLK); // Still in IRD2
        dif.dwait = 1'b0;
        dif.dload = 32'h00005454;
        @(negedge CLK); // Back to GOOD
        check_out(1'b0, 1'b0, 1'b1, 32'h00008787, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0);
        @(negedge CLK);
        dcif.dmemREN = 1'b0;
        dcif.dmemaddr = '0;
        dif.dwait = 1'b1;
        // Case 3: Load the value(DEAD) at right already on dcache
        tb_test_num++;
        tb_test_case = "Load the value(DEAD) at right already on dcache";
        @(posedge CLK); // GOOD
        set_load(32'h00000000); // First word at right
        @(negedge CLK);
        check_out(1'b0, 1'b0, 1'b1, 32'h0000DEAD, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0); // dhit
        @(negedge CLK);
        dcif.dmemREN = 1'b0;
        dcif.dmemaddr = '0;
        // Case 4: Load the value(5454) at left already on dcache
        tb_test_num++;
        tb_test_case = "Load the value(5454) at left already on dcache";
        @(posedge CLK); // GOOD
        set_load(32'h80000004); // Second word at left
        @(negedge CLK);
        check_out(1'b0, 1'b0, 1'b1, 32'h00005454, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0); // dhit
        @(negedge CLK);
        dcif.dmemREN = 1'b0;
        dcif.dmemaddr = '0;
        // Case 5: Load the value(BADB) at right already on dcache
        tb_test_num++;
        tb_test_case = "Load the value(BADB) at right already on dcache";
        @(posedge CLK); // GOOD
        set_load(32'h00000004); // Second word at right
        @(negedge CLK);
        check_out(1'b0, 1'b0, 1'b1, 32'h0000BADB, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0); // dhit
        @(negedge CLK);
        dcif.dmemREN = 1'b0;
        dcif.dmemaddr = '0;
        // Case 6: Load again the value(BADB) at right already on dcache
        tb_test_num++;
        tb_test_case = "Load again the value(BADB) at right already on dcache";
        @(posedge CLK); // GOOD
        set_load(32'h00000004); // Second word at right
        @(negedge CLK);
        check_out(1'b0, 1'b0, 1'b1, 32'h0000BADB, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0); // dhit
        @(negedge CLK);
        dcif.dmemREN = 1'b0;
        dcif.dmemaddr = '0;
        // Case 8: Initial load Data Left(0857 and 3838)(replace left)
        tb_test_num++;
        tb_test_case = "Initial load Data Left(0857 and 3838)(replace left)";
        @(posedge CLK);
        set_load(32'h40000004);
        @(negedge CLK);
        check_out(1'b0,1'b0, 1'b0, '0, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0); // no dhit
        @(negedge CLK); // CHECK
        @(negedge CLK); // IRD1
        check_out(1'b1, 1'b0, 1'b0, '0, 1'b0, 32'b0, 1'b0, 1'b0, 1'b1);
        @(negedge CLK); // Still in IRD1
        dif.dwait = 1'b0;
        dif.dload = 32'h00000857;
        @(negedge CLK); // IRD2
        dif.dwait = 1'b1;
        check_out(1'b1, 1'b0, 1'b0, '0, 1'b0, 32'b0, 1'b0, 1'b0, 1'b1);
        @(negedge CLK); // Still in IRD2
        dif.dwait = 1'b0;
        dif.dload = 32'h00003838;
        @(negedge CLK); // Back to GOOD
        check_out(1'b0, 1'b0, 1'b1, 32'h00003838, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0);
        @(negedge CLK);
        dcif.dmemREN = 1'b0;
        dcif.dmemaddr = '0;
        dif.dwait = 1'b1;
        // Case 9: Write the part with first block 7777
        tb_test_num++;
        tb_test_case = "Write the right part with first block 7777";
        @(posedge CLK); // GOOD
        set_store(32'h00000000, 32'h00007777);
        @(negedge CLK);
        check_out(1'b0, 1'b0, 1'b0, 32'b0, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0); //  no dhit, go to SRDX1
        @(negedge CLK); // SRDX1
        check_out(1'b1, 1'b0, 1'b0, 32'b0, 1'b0, 32'b0, 1'b0, 1'b1, 1'b1);
        dif.dwait = 1'b0;
        @(negedge CLK); // SRDX2
        check_out(1'b1, 1'b0, 1'b0, 32'b0, 1'b0, 32'b0, 1'b0, 1'b1, 1'b1);
        @(negedge CLK); // GOOD
        check_out(1'b0, 1'b0, 1'b1, 32'b0, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0);
        dif.dwait = 1'b1;
        @(posedge CLK);
        dcif.dmemstore = '0;
        dcif.dmemWEN = 1'b0;
        dcif.dmemREN = 1'b1;
        @(negedge CLK);
        check_out(1'b0, 1'b0, 1'b1, 32'h00007777, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0); // dhit
        @(negedge CLK);
        dcif.dmemREN = 1'b0;
        dcif.dmemaddr = '0;
        // Case 10: Read the left three times to make the left most recently used
        tb_test_num++;
        tb_test_case = "Read the left three times to make the left most recently used";
        @(posedge CLK); // GOOD
        set_load(32'h40000000); // First word at left
        @(negedge CLK);
        check_out(1'b0, 1'b0, 1'b1, 32'h00000857, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0); // dhit
        @(posedge CLK);
        set_load(32'h40000004); // Second word at left
        @(negedge CLK);
        check_out(1'b0, 1'b0, 1'b1, 32'h00003838, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0); // dhit
        @(posedge CLK);
        set_load(32'h40000000); // First word at left
        @(negedge CLK);
        check_out(1'b0, 1'b0, 1'b1, 32'h00000857, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0); // dhit
        @(posedge CLK);
        dcif.dmemREN = 1'b0;
        dcif.dmemaddr = '0;
        // Case 11: Load value from address which is not on dcache
        tb_test_num++;
        tb_test_case = "Load value at address which is not on dcache";
        @(posedge CLK); // GOOD
        set_load(32'h20000000);
        @(negedge CLK);
        check_out(1'b0, 1'b0, 1'b0, 32'b0, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0); // no dhit
        @(negedge CLK); // CHECK
        @(negedge CLK); // WB1
        check_out(1'b0, 1'b1, 1'b0, 32'b0, 1'b0, 32'h00007777, 1'b0, 1'b0, 1'b0);
        @(negedge CLK); // Still in WB1
        check_out(1'b0, 1'b1, 1'b0, 32'b0, 1'b0, 32'h00007777, 1'b0, 1'b0, 1'b0);
        dif.dwait = 1'b0;
        @(negedge CLK); // WB2
        dif.dwait = 1'b1;
        check_out(1'b0, 1'b1, 1'b0, 32'b0, 1'b0, 32'h0000BADB, 1'b0, 1'b0, 1'b0);
        @(negedge CLK); // Still in WB2
        dif.dwait = 1'b0;
        @(negedge CLK); // IRD1
        dif.dload = 32'h00009999;
        check_out(1'b1, 1'b0, 1'b0, 32'b0, 1'b0, 32'b0, 1'b0, 1'b0, 1'b1);
        @(negedge CLK); // IRD2
        dif.dload = 32'h00005555;
        check_out(1'b1, 1'b0, 1'b0, 32'b0, 1'b0, 32'b0, 1'b0, 1'b0, 1'b1);
        @(negedge CLK); // GOOD
        check_out(1'b0, 1'b0, 1'b1, 32'h00009999, 1'b0, 32'b0, 1'b0, 1'b0, 1'b0);
        @(negedge CLK); // GOOD
        dcif.dmemREN = 1'b0;
        dcif.dmemaddr = '0;
        dif.dwait = 1'b1;
        // Case 12: Store value to right part
        @(posedge CLK); // GOOD
        tb_test_num++;
        tb_test_case = "Store value to right part";
        set_store(32'h20000000, 32'h87878787);
        @(negedge CLK); // GOOD
        check_out(1'b0, 1'b0, 1'b0, '0, 1'b0, '0, 1'b0, 1'b0, 1'b0);
        @(negedge CLK); // SRDX1
        check_out(1'b1, 1'b0, 1'b0, '0, 1'b0, '0, 1'b0, 1'b1, 1'b1);
        dif.dwait = 1'b0;
        @(negedge CLK); // SRDX2
        check_out(1'b1, 1'b0, 1'b0, '0, 1'b0, '0, 1'b0, 1'b1, 1'b1);
        @(negedge CLK); // GOOD
        check_out(1'b0, 1'b0, 1'b1, '0, 1'b0, '0, 1'b0, 1'b0, 1'b0);
        @(posedge CLK);
        dcif.dmemWEN = 1'b0;
        dcif.dmemaddr = '0;
        dcif.dmemstore = '0;
        // Case 13: Receive ccwait to shared state block
        @(posedge CLK); // GOOD
        tb_test_num++;
        tb_test_case = "Receive ccinv to shared state block";
        dif.ccwait = 1'b1;
        dif.ccinv = 1'b1;
        dif.ccsnoopaddr = 32'h40000000;
        @(posedge CLK);
        @(negedge CLK); // S_to_I
        check_out(1'b0, 1'b0, 1'b0, '0, 1'b0, '0, 1'b0, 1'b0, 1'b1);
        @(posedge CLK); // GOOD
        dif.ccwait = 1'b0;
        dif.ccinv = 1'b1;
        dif.ccsnoopaddr = '0;
        // Case 14: Receive ccwait to modified state block
        @(posedge CLK); // GOOD
        tb_test_num++;
        tb_test_case = "Receive ccwait to modified state block";
        dif.ccwait = 1'b1;
        dif.ccsnoopaddr = 32'h20000000;
        @(negedge CLK);
        @(negedge CLK); // Reply_RD1
        check_out(1'b0, 1'b1, 1'b0, '0, 1'b0, 32'h87878787, 1'b0, 1'b0, 1'b1);
        dif.dwait = 1'b0;
        @(negedge CLK); // Reply_RD2
        check_out(1'b0, 1'b1, 1'b0, '0, 1'b0, 32'h00005555, 1'b0, 1'b0, 1'b1);
        @(posedge CLK); // GOOD
        dif.ccwait = 1'b0;
        dif.ccsnoopaddr = '0;
        // Case 13: Receive halt from datapath
        tb_test_num++;
        tb_test_case = "Receive halt from datapath";
        dcif.halt = 1'b1;
        @(negedge CLK); // GOOD
        @(negedge CLK); // HCHECK
        #(PERIOD*16); // all invalid, so no need to write back to memory
        @(negedge CLK); // Done
        check_out(1'b0, 1'b0, 1'b0, '0, 1'b1, '0, 1'b0, 1'b0, 1'b0);
        #PERIOD;
        $stop();
    end
endprogram