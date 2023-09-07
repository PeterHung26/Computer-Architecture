`include "alu_if.vh"
`include "cpu_types_pkg.vh"

module alu(
    input logic clk,
    alu_if aluif
);

import cpu_types_pkg::*;
assign aluif.zero = (aluif.portout == '0) ? 1'b1 : 1'b0;
assign aluif.negative = (aluif.portout[31] == 1'b1) ? 1'b1 : 1'b0;

always_comb begin : ALU
    aluif.overflow = 1'b0;
    aluif.portout = '0;
    casez (aluif.aluop)
    ALU_SLL: begin
        aluif.portout = aluif.portb << aluif.porta[4:0];
        aluif.overflow = 1'b0;
    end
    ALU_SRL: begin
        aluif.portout = aluif.portb >> aluif.porta[4:0];
        aluif.overflow = 1'b0;
    end
    ALU_ADD: begin
        aluif.portout = signed'(aluif.porta) + signed'(aluif.portb);
        aluif.overflow = (aluif.porta[31] == aluif.portb[31]) && (aluif.porta[31] != aluif.portout[31]);
    end
    ALU_SUB: begin
        aluif.portout = signed'(aluif.porta) - signed'(aluif.portb);
        aluif.overflow = (aluif.porta[31] != aluif.portb[31]) && (aluif.porta[31] != aluif.portout[31]);
    end
    ALU_AND: begin
        aluif.portout = aluif.porta & aluif.portb;
        aluif.overflow = 1'b0;
    end
    ALU_OR: begin
        aluif.portout = aluif.porta | aluif.portb;
        aluif.overflow = 1'b0;
    end
    ALU_XOR: begin
        aluif.portout = aluif.porta ^ aluif.portb;
        aluif.overflow = 1'b0;
    end
    ALU_NOR: begin
        aluif.portout = ~(aluif.porta | aluif.portb);
        aluif.overflow = 1'b0;
    end
    ALU_SLT: begin
        aluif.portout = (signed'(aluif.porta)< signed'(aluif.portb)) ? 32'd1 : 32'b0;
        aluif.overflow = 1'b0;
    end
    ALU_SLTU: begin
        aluif.portout = (aluif.porta < aluif.portb) ? 32'd1 : 32'b0;
        aluif.overflow = 1'b0;
    end
    endcase
end

endmodule
