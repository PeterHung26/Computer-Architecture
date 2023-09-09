`include "extender_if.vh"
`include "cpu_types_pkg.vh"

module extender(
    input logic CLK, 
    extender_if.ex exif
);

import cpu_types_pkg::*;

always_comb begin : EXTENDER
    if(exif.ExtOp) begin // Sign Extend
        if(exif.imm[15])
            exif.ext_imm = {16'hffff, exif.imm};
        else
            exif.ext_imm = {16'b0, exif.imm};
    end
    else begin // Unsign Extend
        exif.ext_imm = {16'b0, exif.imm};
    end
end

endmodule