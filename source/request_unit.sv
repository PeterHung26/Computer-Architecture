`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"
module request_unit(
    input logic CLK, nRST, request_unit_if.ru ruif
);
    import cpu_types_pkg::*;

    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            ruif.dMemREN <= '0;
            ruif.dMemWEN <= '0;
        end
        else if(ruif.dhit) begin
            ruif.dMemREN <= '0;
            ruif.dMemWEN <= '0;
        end
        else if(ruif.ihit) begin
            ruif.dMemREN <= ruif.dREN;
            ruif.dMemWEN <= ruif.dWEN;
        end


    end
    





endmodule