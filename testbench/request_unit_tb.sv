`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns/1 ns

module request_unit_tb;

    parameter PERIOD = 10;
    logic CLK = 0;
    // clock
    always #(PERIOD/2) CLK++;

    //interface
    request_unit_if ruif();
    // test program
    test #(.PERIOD (PERIOD)) PROG (
        .clk(CLK),
        .ruif(ruif)
    );
    `ifndef MAPPED
        request_unit RU(CLK, ruif);
    `else
        request_unti RU(
            .\ruif.dhit (ruif.dhit),
            .\ruif.ihit (ruif.ihit),
            .\ruif.dread (ruif.dread),
            .\ruif.dwrite (ruif.dwrite),
            .\ruif.iread (ruif.iread),
            .\ruif.datomic (ruif.datomic),
            .\ruif.dmemWEN (ruif.dmemWEN),
            .\ruif.dmemREN (ruif.dmemREN),
            .\ruif.imemREN (ruif.imemREN),
            .\CLK (CLK)
        );
    `endif

endmodule

program test(
  input logic clk,
  request_unit_if ruif
);
    import cpu_types_pkg::*;
    parameter PERIOD = 10;
    int tb_test_num;
    string tb_test_case;

    task d_enable;
    input string dcase;
    input logic hit;
    input logic dwen;
    input logic dren;
    begin
        tb_test_case = dcase;
        tb_test_num++;
        ruif.dhit = hit;
        ruif.dwrite = dwen;
        ruif.dread = dren;
        #PERIOD;
    end
    endtask

    task i_enable;
    input string icase;
    input logic hit;
    input logic iren;
    begin
        tb_test_case = icase;
        tb_test_num++;
        ruif.ihit = hit;
        ruif.iread = iren;
        #PERIOD;
    end
    endtask

    task check_ioutput;
    begin
        if(ruif.ihit) begin
            if(ruif.imemREN)
                $display("Error imemREN value when ihit = 1");
            else
                $display("Correct imemREN value when ihit = 1");
        end
        else begin
            if(ruif.imemREN == ruif.iread)
                $display("Correct imemREN value when ihit = 0");
            else
                $display("Error imemREN value when ihit = 0");
        end
    end
    endtask
    
    task check_doutput;
    begin
        if(ruif.dhit) begin
            if(ruif.dmemREN || ruif.dmemWEN)
                $display("Error dmemREN or dmemWEN value when dhit = 1");
            else
                $display("Correct dmemREN and dmemWEN value when dhit = 1");
        end
        else begin
            if(ruif.dmemREN == ruif.dread)
                $display("Correct dmemREN value when dhit = 0");
            else
                $display("Error dmemREN value when dhit = 0");
            if(ruif.dmemWEN == ruif.dwrite)
                $display("Correct dmemWEN value when dhit = 0");
            else
                $display("Error dmemWEN value when dhit = 0");
        end
    end
    endtask

    initial begin
        tb_test_num = 0;
        tb_test_case = "Start testing";
        #PERIOD;
        // ihit = 0, iread = 0
        i_enable("ihit = 0, iread = 0", 0, 0);
        check_ioutput();
        // ihit = 0, iread = 1
        i_enable("ihit = 0, iread = 1", 0, 1);
        check_ioutput();
        // ihit = 1, iread = 0
        i_enable("ihit = 1, iread = 0", 1, 0);
        check_ioutput();
        // ihit = 1, iread = 1
        i_enable("ihit = 1, iread = 1", 1, 1);
        check_ioutput();
        // dhit = 0, dwrite = 0, dread = 0
        d_enable("dhit = 0, dwrite = 0, dread = 0", 0, 0, 0);
        check_doutput();
        // dhit = 0, dwrite = 1, dread = 0
        d_enable("dhit = 0, dwrite = 1, dread = 0", 0, 1, 0);
        check_doutput();
        // dhit = 0, dwrite = 0, dread = 1
        d_enable("dhit = 0, dwrite = 0, dread = 1", 0, 0, 1);
        check_doutput();
        // dhit = 1, dwrite = 0, dread = 0
        d_enable("dhit = 1, dwrite = 0, dread = 0", 1, 0, 0);
        check_doutput();
        // dhit = 1, dwrite = 1, dread = 0
        d_enable("dhit = 1, dwrite = 1, dread = 0", 1, 1, 0);
        check_doutput();
        // dhit = 1, dwrite = 0, dread = 1
        d_enable("dhit = 1, dwrite = 0, dread = 1", 1, 0, 1);
        check_doutput();
    end


endprogram