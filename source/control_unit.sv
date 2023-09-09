`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

module control_unit(
    input logic CLK,
    control_unit_if.cu cuif
);

import cpu_types_pkg::*;
always_comb begin : CONTROL
    cuif.ExtOp = 1'b0;
    cuif.ALUSrc = 1'b0;
    cuif.MemtoReg = 1'b0;
    cuif.Branch = 1'b0;
    cuif.Jump = 1'b0;
    cuif.JR = 1'b0;
    cuif.RegDst = 2'b0;
    cuif.RegWr = 1'b0;
    cuif.ALUCtr = ALU_SLL;
    cuif.JumpReg = 1'b0;
    cuif.LUI = 1'b0;
    cuif.LDsel = 2'b0;
    cuif.SVsel = 2'b0;
    cuif.iread = 1'b1;
    cuif.dread = 1'b0;
    cuif.dwrite = 1'b0;
    cuif.halt = 1'b0;
    casez (cuif.opcode)
    RTYPE: begin
        casez (cuif.funct)
        SLLV: begin
            cuif.ALUCtr = ALU_SLL;
            cuif.RegWr = 1'b1;
            cuif.RegDst = 1'b1;
        end
        SRLV: begin
            cuif.ALUCtr = ALU_SRL;
            cuif.RegWr = 1'b1;
            cuif.RegDst = 1'b1;
        end
        JR: begin
            cuif.JR = 1'b1;
        end
        ADD: begin
            cuif.ALUCtr = ALU_ADD;
            cuif.RegWr = 1'b1;
            cuif.RegDst = 1'b1;
        end
        ADDU: begin
            cuif.ALUCtr = ALU_ADD;
            cuif.RegWr = 1'b1;
            cuif.RegDst = 1'b1;
        end
        SUB: begin
            cuif.ALUCtr = ALU_SUB;
            cuif.RegWr = 1'b1;
            cuif.RegDst = 1'b1;
        end
        SUBU: begin
            cuif.ALUCtr = ALU_SUB;
            cuif.RegWr = 1'b1;
            cuif.RegDst = 1'b1;
        end
        AND: begin
            cuif.ALUCtr = ALU_AND;
            cuif.RegWr = 1'b1;
            cuif.RegDst = 1'b1;
        end
        OR: begin
            cuif.ALUCtr = ALU_OR;
            cuif.RegWr = 1'b1;
            cuif.RegDst = 1'b1;
        end
        XOR: begin
            cuif.ALUCtr = ALU_XOR;
            cuif.RegWr = 1'b1;
            cuif.RegDst = 1'b1;
        end
        NOR: begin
            cuif.ALUCtr = ALU_NOR;
            cuif.RegWr = 1'b1;
            cuif.RegDst = 1'b1;
        end
        SLT: begin
            cuif.ALUCtr = ALU_SLT;
            cuif.RegWr = 1'b1;
            cuif.RegDst = 1'b1;
        end
        SLTU: begin
            cuif.ALUCtr = ALU_SLTU;
            cuif.RegWr = 1'b1;
            cuif.RegDst = 1'b1;
        end
        endcase
    end
    J: begin
        cuif.Jump = 1'b1;
    end
    JAL: begin
        cuif.Jump = 1'b1;
        cuif.JumpReg = 1'b1;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'd2;
    end
    BEQ: begin
        cuif.ExtOp = 1'b1; // Sign extension
        cuif.ALUSrc = 1'b0;
        cuif.ALUCtr = ALU_SUB;
        if(cuif.Equal == '0)
            cuif.Branch = 1'b1;
        else
            cuif.Branch = 1'b0;
    end
    BNE: begin
        cuif.ExtOp = 1'b1; // Sign extension
        cuif.ALUSrc = 1'b0;
        cuif.ALUCtr = ALU_SUB;
        if(cuif.Equal == '0)
            cuif.Branch = 1'b0;
        else
            cuif.Branch = 1'b1;
    end
    ADDI: begin
        cuif.ExtOp = 1'b1; // Sign extension
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr = ALU_ADD;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'b0; // write to rt
    end
    ADDIU: begin
        cuif.ExtOp = 1'b1; // Sign extension
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr = ALU_ADD;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'b0; // write to rt
    end
    SLTI: begin
        cuif.ExtOp = 1'b1;
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_SLT;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'b0; // write to rt
    end
    SLTIU: begin
        cuif.ExtOp = 1'b1;
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_SLTU;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'b0; // write to rt
    end
    ANDI: begin
        cuif.ExtOp = 1'b0; // Zero Extension
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_AND;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'b0; // write to rt
    end
    ORI: begin
        cuif.ExtOp = 1'b0; // Zero Extension
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_OR;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'b0; // write to rt
    end
    XORI: begin
        cuif.ExtOp = 1'b0; // Zero Extension
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_XOR;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'b0; // write to rt
    end
    LUI: begin
        cuif.ExtOp = 1'b0; // Zero Extension
        cuif.ALUSrc = 1'b1;
        cuif.LUI = 1'b1;
        cuif.ALUCtr =  ALU_SLL;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'b0; // write to rt
    end
    LW: begin
        cuif.ExtOp = 1'b1;
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_ADD;
        cuif.MemtoReg = 1'b1;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'b0;
        cuif.dread = 1'b1;
    end
    LBU: begin
        cuif.ExtOp = 1'b1;
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_ADD;
        cuif.MemtoReg = 1'b1;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'b0;
        cuif.dread = 1'b1;
        cuif.LDsel = 2'd1;
    end
    LHU: begin
        cuif.ExtOp = 1'b1;
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_ADD;
        cuif.MemtoReg = 1'b1;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'b0;
        cuif.dread = 1'b1;
        cuif.LDsel = 2'd2;
    end
    SB: begin
        cuif.ExtOp = 1'b1;
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_ADD;
        cuif.dwrite = 1'b1;
        cuif.SVsel = 2'd1;
    end
    SH: begin
        cuif.ExtOp = 1'b1;
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_ADD;
        cuif.dwrite = 1'b1;
        cuif.SVsel = 2'd2;
    end
    SW: begin
        cuif.ExtOp = 1'b1;
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_ADD;
        cuif.dwrite = 1'b1;
    end
    HALT: begin
        cuif.iread = 1'b0;
        cuif.halt = 1'b1;
    end 
    endcase
end

endmodule