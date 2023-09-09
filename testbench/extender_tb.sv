`include "extender_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns/1 ns

module extender_tb;
    parameter PERIOD = 10;
    logic CLK = 0;
    // clock
    always #(PERIOD/2) CLK++;

    // interface
    extender_if exif();
    // test program
    test #(.PERIOD (PERIOD)) PROG (
        .CLK(CLK),
        .exif(exif.tb)
    );
    //DUT
    `ifndef MAPPED
        extender EXT(CLK, exif);
    `else
        extender EXT(
            .\exif.imm (exif.imm),
            .\exif.ExtOp (exif.ExtOp),
            .\exif.ext_imm (exif.ext_imm),
            .\CLK (CLK)
        );
    `endif
endmodule

program test(
  input logic CLK,
  extender_if exif
);
    import cpu_types_pkg::*;
    parameter PERIOD = 10;
    string tb_test_case;
    int tb_test_num;

    task extending;
    input logic op;
    input logic [IMM_W-1:0] num;
    begin
        exif.ExtOp = op;
        exif.imm = num;
        @(negedge CLK);
    end
    endtask

    task check_output;
    input word_t exp;
    begin
        if(exif.ext_imm == exp)
            $display("The extended number is as expected: %0h", exif.ext_imm);
        else
            $display("The extended number is not as expected: %0h", exif.ext_imm);
    end
    endtask

    initial begin
        tb_test_num = 0;
        tb_test_case = "Start";
        #PERIOD;
        // Signed Extension with MSB = 1
        tb_test_num++;
        tb_test_case = "Signed Extension with MSB = 1";
        extending(1'b1, 16'habbb);
        check_output(32'hffffabbb);
        // Signed Extension with MSB = 0
        tb_test_num++;
        tb_test_case = "Signed Extension with MSB = 0";
        extending(1'b1, 16'h7bbb);
        check_output(32'h00007bbb);
        // Unsigned Extension with MSB = 1
        tb_test_num++;
        tb_test_case = "Unsigned Extension with MSB = 1";
        extending(1'b0, 16'habbb);
        check_output(32'h0000abbb);
        // Signed Extension with MSB = 0
        tb_test_num++;
        tb_test_case = "Unsigned Extension with MSB = 0";
        extending(1'b0, 16'h7bbb);
        check_output(32'h00007bbb);
    end
endprogram