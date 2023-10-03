`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"

module hazard_unit(
    input logic CLK, nRST, 
    hazard_unit_if.hu huif
);

import cpu_types_pkg::*;

logic nxt_iREN;

always_comb begin : HAZARD
    nxt_iREN = 1'b1;
    huif.IF_EN = 1'b1;
    huif.ID_EN = 1'b1;
    huif.EX_EN = 1'b1;
    huif.MEM_EN = 1'b1;
    huif.IF_FLUSH = 1'b0;
    huif.ID_FLUSH = 1'b0;
    huif.EX_FLUSH = 1'b0;
    huif.MEM_FLUSH = 1'b0;
    huif.PC_EN = 1'b1;
    huif.pr_halt = 1'b0;
    if(!huif.ihit && !huif.dhit) begin
        huif.PC_EN = 1'b0;
        huif.IF_EN = 1'b0;
        huif.ID_EN = 1'b0;
        huif.EX_EN = 1'b0;
        huif.MEM_EN = 1'b0;
    end
    else if(huif.PCSrc) begin
        huif.EX_FLUSH = 1'b1;
        huif.ID_FLUSH = 1'b1;
        huif.IF_FLUSH = 1'b1;
    end
    else if(huif.ID_dread && ((huif.ID_rt == huif.IF_rs) || (huif.ID_rt == huif.IF_rt))) begin
        if(huif.cu_Jump) begin
            huif.IF_FLUSH = 1'b1;
        end
        else if(huif.cu_halt) begin
            nxt_iREN = 1'b0;
            huif.IF_EN = 1'b0;
            huif.ID_FLUSH = 1'b1;
            huif.PC_EN = 1'b0;
        end
        else begin
            huif.ID_FLUSH = 1'b1;
            huif.IF_EN = 1'b0;
            huif.PC_EN = 1'b0;
        end
    end
    else if(huif.ID_JR) begin  // JR control flow hazard (found at EX stage)
        huif.ID_FLUSH = 1'b1;
        huif.IF_FLUSH = 1'b1;
    end
    else if(huif.cu_Jump) begin //Jump and JAL control flow hazard (found at DCD stage)
        huif.IF_FLUSH = 1'b1;
    end
    else if(huif.cu_halt) begin // Halt
        nxt_iREN = 1'b0;
        huif.IF_EN = 1'b0;
        huif.ID_FLUSH = 1'b1;
        huif.PC_EN = 1'b0;
        huif.pr_halt = 1'b1;
    end
    else if(huif.dhit) begin //Structural hazard
        huif.PC_EN = 1'b0;
        huif.IF_FLUSH = 1'b1;
    end
end

always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST) begin
        huif.iREN <= 1'b1;
    end
    else begin
        huif.iREN <= nxt_iREN;
    end
end

endmodule