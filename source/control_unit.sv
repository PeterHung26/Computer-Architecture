`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

module control_unit(
    input logic CLK,
    input logic nRST,
    control_unit_if.cu cuif
);

import cpu_types_pkg::*;
//logic haltt;
always_comb begin : CONTROL
    cuif.ExtOp = 1'b0;
    cuif.ALUSrc = 1'b0;
    cuif.MemtoReg = 1'b0;
    cuif.BEQ = 1'b0;
    cuif.BNE = 1'b0;
    cuif.Jump = 1'b0;
    cuif.JR = 1'b0;
    cuif.RegDst = 2'b0;
    cuif.RegWr = 1'b0;
    cuif.ALUCtr = ALU_SLL;
    cuif.JumpReg = 1'b0;
    cuif.LUI = 1'b0;
    //cuif.LDsel = 2'b0;
    //cuif.SVsel = 2'b0;
    //cuif.iread = 1'b1;
    cuif.dread = 1'b0;
    cuif.dwrite = 1'b0;
    cuif.halt = 1'b0;
    /*if(cuif.halt)
        cuif.iread = 1'b0;
    else
        cuif.iread = 1'b1;*/
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
        cuif.BEQ = 1'b1;
    end
    BNE: begin
        cuif.ExtOp = 1'b1; // Sign extension
        cuif.ALUSrc = 1'b0;
        cuif.ALUCtr = ALU_SUB;
        cuif.BNE = 1'b1;
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
    SW: begin
        cuif.ExtOp = 1'b1;
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_ADD;
        cuif.dwrite = 1'b1;
    end
    HALT: begin
        cuif.halt = 1'b1;
    end 
    LL: begin
        cuif.ExtOp = 1'b1;
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_ADD;
        cuif.MemtoReg = 1'b1;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'b0;
        cuif.dread = 1'b1;
    end
    SC: begin
        cuif.ExtOp = 1'b1;
        cuif.ALUSrc = 1'b1;
        cuif.ALUCtr =  ALU_ADD;
        cuif.dwrite = 1'b1;
        cuif.MemtoReg = 1'b1;
        cuif.RegWr = 1'b1;
        cuif.RegDst = 2'b0;
    end
    endcase
end

/*always_ff @( posedge CLK, negedge nRST ) begin : HALT_LATCH
    if(!nRST) begin
        cuif.halt <= '0;
    end
    else begin
        cuif.halt <= haltt;
    end
end*/

endmodule