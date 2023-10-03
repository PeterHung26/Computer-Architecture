`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"

module request_unit(
    input logic CLK,
    input logic nRST,
    request_unit_if.ru ruif
);

import cpu_types_pkg::*;

always_ff @( posedge CLK, negedge nRST ) begin : READ_AND_WRITE_REQUEST
    if(!nRST) begin
        ruif.dmemREN <= '0;
        ruif.dmemWEN <= '0;
    end
    else begin
        if(ruif.ihit) begin
            ruif.dmemREN <= ruif.dread;
            ruif.dmemWEN <= ruif.dwrite;
        end
        else if(ruif.dhit) begin
            ruif.dmemREN <= 1'b0;
            ruif.dmemWEN <= 1'b0;
        end
        /*else
            ruif.dmemREN <= ruif.dmemREN;
            ruif.dmemWEN <= ruif.dmemWEN;*/
    end
end

assign ruif.imemREN = ruif.iread;

endmodule