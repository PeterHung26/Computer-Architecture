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

    
endprogram