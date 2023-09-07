`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"

module request_unit(
    input CLK,
    request_unit_if.ru ruif
);

import cpu_types_pkg::*;

always_comb begin : READ_AND_WRITE_REQUEST
    ruif.dmemREN = 1'b0;
    ruif.dmemWEN = 1'b0;
    ruif.imemREN = 1'b0;
    if(ruif.dread) begin
        if(ruif.dhit) begin
            ruif.dmemREN = 1'b0;
        end
        else begin
            ruif.dmemREN = 1'b1;
        end
    end
    if(ruif.dwrite) begin
        if(ruif.dhit) begin
            ruif.dmemWEN = 1'b0;
        end
        else begin
            ruif.dmemWEN = 1'b1;
        end
    end
    if(ruif.iread) begin
        if(ruif.ihit) begin
            ruif.imemREN = 1'b0;
        end
        else begin
            ruif.imemREN = 1'b1;
        end
    end
end

endmodule