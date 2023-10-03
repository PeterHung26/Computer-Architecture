`include "forwarding_unit_if.vh"
`include "cpu_types_pkg.vh"

module forwarding_unit(
    input logic CLK, 
    forwarding_unit_if.fu fuif
);

import cpu_types_pkg::*;

always_comb begin : FORWARDING
    fuif.forwarda = 2'd0;
    fuif.forwardb = 2'd0;
    if((fuif.ID_rs == fuif.EX_wsel) && fuif.EX_RegWrite) begin
        fuif.forwarda = 2'd1;
    end
    else if((fuif.ID_rs == fuif.MEM_wsel) && fuif.MEM_RegWrite) begin
        fuif.forwarda = 2'd2;
    end
    if((fuif.ID_rt == fuif.EX_wsel) && fuif.EX_RegWrite) begin
        fuif.forwardb = 2'd1;
    end
    else if((fuif.ID_rt == fuif.MEM_wsel) && fuif.MEM_RegWrite) begin
        fuif.forwardb = 2'd2;
    end
end

endmodule