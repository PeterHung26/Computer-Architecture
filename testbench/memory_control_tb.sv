// mapped needs this
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "caches_if.vh"
// types
`include "cpu_types_pkg.vh"
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
    cache_control_if #(.CPUS(1)) ccif(cif0, cif1);
    cpu_ram_if ramif();

    //Connect signals between ccif and ramif
    assign ccif.ramload = ramif.ramload;
    assign ccif.ramstate = ramif.ramstate;
    assign ramif.ramstore = ccif.ramstore;
    assign ramif.ramaddr = ccif.ramaddr;
    assign ramif.ramWEN = ccif.ramWEN;
    assign ramif.ramREN = ccif.ramREN;

    //test program
    test #(.PERIOD(PERIOD)) PROG(CLK, nRST, cif0, ramif);

    // DUT
    `ifndef MAPPED
        memory_control DUT(CLK, nRST, ccif);
    `else
        memory_control DUT(
            .\ccif.iREN (ccif.iREN),
            .\ccif.dREN (ccif.dREN),
            .\ccif.dWEN (ccif.dWEN),
            .\ccif.iaddr (ccif.iaddr),
            .\ccif.daddr (ccif.daddr),
            .\ccif.dstore (ccif.dstore),
            .\ccif.iwait (ccif.iwait),
            .\ccif.dwait (ccif.dwait),
            .\ccif.dload (ccif.dload),
            .\ccif.iload (ccif.iload),
            .\ccif.ramload (ccif.ramload),
            .\ccif.ramstate (ccif.ramstate),
            .\ccif.ramstore (ccif.ramstore),
            .\ccif.ramaddr (ccif.ramaddr),
            .\ccif.ramWEN (ccif.ramWEN),
            .\ccif.ramREN (ccif.ramREN),
            .\ccif.ccwrite (ccif.ccwrite),
            .\ccif.cctrans (ccif.cctrans),
            .\ccif.ccwait (ccif.ccwait),
            .\ccif.ccinv (ccif.ccinv),
            .\ccif.ccsnoopaddr (ccif.ccsnoopaddr),
            .\nRST (nRST),
            .\CLK (CLK)
        );
    `endif
    `ifndef MAPPED
        ram RAM(CLK, nRST, ramif);
    `else
        ram RAM(
            .\ramif.ramaddr (ramif.ramaddr),
            .\ramif.ramstore (ramif.ramstore),
            .\ramif.ramREN (ramif.ramREN),
            .\ramif.ramWEN (ramif.ramWEN),
            .\ramif.ramstate (ramif.ramstate),
            .\ramif.ramload (ramif.ramload),
            .\nRST (nRST),
            .\CLK (CLK)
        );
    `endif
endmodule

program test(
    input logic CLK,
    output logic nRST,
    caches_if cif0,
    cpu_ram_if ramif
);
    parameter PERIOD = 10;
    int tb_test_num;
    int i;
    string tb_test_case;

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
        begin
            $display("Failed to open %s.",filename); $finish; 
        end

        for (int unsigned i = 0; memfd && i < 16384; i++)
        begin
            int chksum = 0;
            bit [7:0][7:0] values;
            string ihex;

            cif0.daddr = i << 2;
            cif0.dREN = 1;
            repeat (4) @(posedge CLK);
            if (cif0.dload === 0)
                continue;
            values = {8'h04,16'(i),8'h00,cif0.dload};
            foreach (values[j])
                chksum += values[j];
            chksum = 16'h100 - chksum;
            ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
            $fdisplay(memfd,"%s",ihex.toupper());
        end //for
        if (memfd) begin
            cif0.dREN = 0;
            $fdisplay(memfd,":00000001FF");
            $fclose(memfd);
            $display("Finished memory dump.");
        end
    endtask

    task reset_ram();
        nRST = 0;
        @(posedge CLK);
        @(posedge CLK);
        @(negedge CLK);
        nRST = 1;
        @(negedge CLK);
    endtask

    initial begin
        //Reset
        tb_test_num = 0;
        tb_test_case = "Reset";
        cif0.iREN = 0;
        cif0.dREN = 0;
        cif0.dWEN = 0;
        cif0.daddr = 0;
        cif0.dstore = 0;
        cif0.iaddr = 0;
        reset_ram();
        //Test case 1: read 30 instruction from ram
        tb_test_num ++;
        tb_test_case = "read 30 instruction from ram";
        $display("read 30 instruction from ram");
        for(i = 0; i < 30; i++) begin
            cif0.iREN = 1;
            cif0.iaddr = i << 2;
            @(posedge CLK);
            @(posedge CLK);
            @(negedge CLK);
            $display("Addr: %d, Instruction: %0h", i << 2, cif0.iload);
        end
        cif0.iREN = 0;
        cif0.iaddr = 0;
        tb_test_case = "stop";
        @(negedge CLK);
        @(negedge CLK);
        //Test case 2: read 30 data from ram
        tb_test_num ++;
        tb_test_case = "read 30 data from ram";
        $display("read 30 data from ram");
        for(i = 0; i < 30; i++) begin
            cif0.dREN = 1;
            cif0.daddr = i << 2;
            @(posedge CLK);
            @(posedge CLK);
            @(negedge CLK);
            $display("Addr: %d, Data: %0h", i << 2, cif0.dload);
        end
        cif0.dREN = 0;
        cif0.daddr = 0;
        tb_test_case = "stop";
        @(negedge CLK);
        @(negedge CLK);
        //Test case 3: write 30 data to ram
        tb_test_num ++;
        tb_test_case = "write 30 data to ram";
        for(i = 30; i < 60; i++) begin
            cif0.dWEN = 1;
            cif0.daddr = i << 2;
            cif0.dstore = 32'h54875487;
            @(posedge CLK);
            @(posedge CLK);
            @(negedge CLK);
        end
        cif0.dWEN = 0;
        cif0.daddr = 0;
        cif0.dstore = 0;
        tb_test_case = "stop";
        @(negedge CLK);
        @(negedge CLK);
        //Test case 4: test arbitration
        tb_test_num ++;
        tb_test_case = "test arbitration";
        for(i = 0; i < 30; i++) begin
            cif0.iREN = 1;
            cif0.iaddr = i << 2;
            cif0.dREN = 1;
            cif0.daddr = (i+30) << 2;
            @(posedge CLK);
            @(posedge CLK);
            @(negedge CLK);
            $display("Address: %d, Instruction: %0h", i, cif0.iload);
            $display("Address: %d, Data: %0h", (i+30) << 2, cif0.dload);
        end
        cif0.dREN = 0;
        cif0.iREN = 0;
        cif0.daddr = 0;
        cif0.iaddr = 0;
        tb_test_case = "stop";
        @(negedge CLK);
        @(negedge CLK);
        // Dump memory
        tb_test_num ++;
        tb_test_case = "Dump memory";
        dump_memory();
    end
endprogram