`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns/1 ns

module datapath_tb;

    parameter PERIOD = 10;
    logic CLK = 0, nRST;
    // clock
    always #(PERIOD/2) CLK++;

    //interface
    datapath_cache_if dpif();
    // test program
    test #(.PERIOD (PERIOD)) PROG (
        .CLK(CLK),
        .nRST(nRST),
        .dpif(dpif)
    );
    // DUT
    `ifndef MAPPED
        datapath DUT(CLK, nRST, dpif);
    `else
        datapath DUT(
            .\dpif.ihit (dpif.ihit),
            .\dpif.imemload (dpif.imemload),
            .\dpif.dhit (dpif.dhit),
            .\dpif.dmemload (dpif.dmemload),
            .\dpif.halt (dpif.halt),
            .\dpif.imemREN (dpif.imemREN),
            .\dpif.imemaddr (dpif.imemaddr),
            .\dpif.dmemREN (dpif.dmemREN),
            .\dpif.dmemWEN (dpif.dmemWEN),
            .\dpif.datomic (dpif.datomic),
            .\dpif.dmemstore (dpif.dmemstore),
            .\dpif.dmemaddr (dpif.dmemaddr),
            .\nRST (nRST),
            .\CLK (CLK)
        );
    `endif
endmodule

program test(
    input logic CLK,
    output logic nRST,
    datapath_cache_if dpif
);
    import cpu_types_pkg::*;
    parameter PERIOD = 10;
    int tb_test_num;
    string tb_test_case;

    parameter [31:0] addins = {6'b000000, 5'd1, 5'd2, 5'd3, 5'b0, 6'b100000}; // R[3] <= R[1] + R[2]
    parameter [31:0] orireg1 = {6'b001101, 5'd0, 5'd1, 16'd60}; // R[1] <= R[0] OR 16'd60
    parameter [31:0] orireg2 = {6'b001101, 5'd0, 5'd2, 16'd40}; // R[2] <= R[0] OR 16'd40
    parameter [31:0] sbreg3 = {6'b101000, 5'b1, 5'd3, 16'd200}; // Store byte
    parameter [31:0] stop = 32'hffffffff;

    task reset_dut;
    begin
        nRST = 0;
        @(posedge CLK);
        @(posedge CLK);
        @(negedge CLK);
        nRST = 1;
    end
    endtask

    task check_iaddr;
    input logic [31:0] exp_addr;
    begin
        if(dpif.imemaddr == exp_addr)
            $display("The instruction address is as expected: %0h", dpif.imemaddr);
        else
            $display("The instruction address is not as expected: %0h", dpif.imemaddr);
    end
    endtask

    task check_daddr;
    input logic [31:0] exp_addr;
    begin
        if(dpif.dmemaddr == exp_addr)
            $display("The data address is as expected: %0h", dpif.dmemaddr);
        else
            $display("The data address is not as expected: %0h", dpif.dmemaddr);
    end
    endtask

    task set_ins;
    input logic [31:0] setup;
    begin
        dpif.imemload = setup;
        dpif.ihit = 1;
    end
    endtask

    task check_rdwr;
    input logic exp_iren;
    input logic exp_dren;
    input logic exp_dwen;
    begin
        if(dpif.imemREN == exp_iren)
            $display("The iREN is as expected: %0b", dpif.imemREN);
        else
            $display("The iREN is not as expected: %0b", dpif.imemREN);
        if(dpif.dmemREN == exp_dren)
            $display("The dREN is as expected: %0b", dpif.dmemREN);
        else
            $display("The dREN is not as expected: %0b", dpif.dmemREN);
        if(dpif.dmemWEN == exp_dwen)
            $display("The dWEN is as expected: %0b", dpif.dmemWEN);
        else
            $display("The dWEN is not as expected: %0b", dpif.dmemWEN);
    end
    endtask
    
    task check_store;
    input logic [31:0] exp_store;
    begin
        if(dpif.dmemstore == exp_store)
            $display("The store value is as expected: %0h", dpif.dmemstore);
        else
            $display("The store value is not as expected: %0h", dpif.dmemstore);
    end
    endtask

    initial begin
        tb_test_num = 0;
        tb_test_case = "Start";
        dpif.ihit = 0;
        dpif.dhit = 0;
        #PERIOD;
        // Reset
        tb_test_num++;
        tb_test_case = "Reset";
        reset_dut();
        // Ori Reg1 = 60
        tb_test_num++;
        tb_test_case = "Ori Reg1 = 60";
        check_iaddr(32'b0);
        set_ins(orireg1);
        check_rdwr(1,0,0);
        @(posedge CLK);
        dpif.ihit = 0;
        // Ori Reg2 = 40
        @(negedge CLK);
        tb_test_num++;
        tb_test_case = "Ori Reg2 = 40";
        check_iaddr(32'd4);
        set_ins(orireg2);
        #3;
        check_rdwr(0,0,0);
        @(posedge CLK);
        dpif.ihit = 0;
        // Add Reg3 = Reg1 + Reg2 = 100
        @(negedge CLK);
        tb_test_num++;
        tb_test_case = "Add Reg3 = Reg1 + Reg2 = 100";
        dpif.ihit = 0;
        check_iaddr(32'd8);
        set_ins(addins);
        #3;
        check_rdwr(0,0,0);
        @(posedge CLK);
        dpif.ihit = 0;
        // Store byte of Reg3 to Reg1 + 200 address
        @(negedge CLK);
        tb_test_num++;
        tb_test_case = "Store byte of Reg3 to Reg1 + 200 address";
        dpif.ihit = 0;
        check_iaddr(32'd12);
        set_ins(sbreg3);
        dpif.ihit = 1;
        dpif.dhit = 0;
        #3;
        check_store(32'd100);
        check_daddr(32'd260);
        check_rdwr(0,0,1);
        @(posedge CLK);
        dpif.ihit = 0;
        @(negedge CLK);
        check_iaddr(32'd16);
        dpif.ihit = 0;
        dpif.dhit = 1;
        #3;
        check_store(32'd100);
        check_daddr(32'd260);
        check_rdwr(1,0,0);
        @(posedge CLK);
        dpif.dhit = 0;
        @(negedge CLK);
        // halt
        tb_test_num++;
        tb_test_case = "Halt";
        dpif.ihit = 0;
        dpif.dhit = 0;
        check_iaddr(32'd16);
        set_ins(stop);
        dpif.ihit = 1;
        dpif.dhit = 0;
        #3;
        check_rdwr(0,0,0);
        #PERIOD;
        $stop();
    end

endprogram