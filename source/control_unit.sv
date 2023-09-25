`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

module control_unit(
    control_unit_if.cu cuif
);
import cpu_types_pkg::*;

    
    

    always_comb begin
        cuif.aluop      = ALU_ADD;
        cuif.RegWrite   = '0;
        cuif.ALUSrc     = '0;
        cuif.PCSrc      = '0;
        cuif.dWEN       = '0;
        cuif.dREN       = '0;
        cuif.Mem2Reg    = '0;
        cuif.RegDst     = '0;
        cuif.Jump       = '0;
        cuif.Jump2Reg   = '0;
        cuif.JAL        = '0;
        cuif.signExt    = '0;
        cuif.halt       = '0;
        cuif.LUI2Reg    = '0;
        cuif.BNE        = '0;
        //cuif.rs         = '0;
        //cuif.rt         = '0;
        //cuif.rd         = '0;
        //cuif.imm        = '0;
        
        if(cuif.inst[31:26] == RTYPE[5:0]) begin
            cuif.RegDst = 1;
            unique casez(cuif.inst[5:0])
                SLLV:   begin cuif.RegWrite = 1; cuif.aluop = ALU_SLL; end
                SRLV:   begin cuif.RegWrite = 1; cuif.aluop = ALU_SRL; end
                JR:     begin cuif.Jump2Reg = 1; end
                ADD:    begin cuif.RegWrite = 1; cuif.aluop = ALU_ADD; end
                ADDU:   begin cuif.RegWrite = 1; cuif.aluop = ALU_ADD; end
                SUB:    begin cuif.RegWrite = 1; cuif.aluop = ALU_SUB; end
                SUBU:   begin cuif.RegWrite = 1; cuif.aluop = ALU_SUB; end
                AND:    begin cuif.RegWrite = 1; cuif.aluop = ALU_AND; end
                OR:     begin cuif.RegWrite = 1; cuif.aluop = ALU_OR; end
                XOR:    begin cuif.RegWrite = 1; cuif.aluop = ALU_XOR; end
                NOR:    begin cuif.RegWrite = 1; cuif.aluop = ALU_NOR; end
                SLT:    begin cuif.RegWrite = 1; cuif.aluop = ALU_SLT; end
                SLTU:   begin cuif.RegWrite = 1; cuif.aluop = ALU_SLTU; end
                default: ;   
            endcase end
        
        else if(cuif.inst[31:26] == J[5:0])    begin cuif.Jump = 1; end //?
        else if(cuif.inst[31:26] == JAL[5:0])  begin cuif.Jump = 1; cuif.JAL = 1; cuif.RegWrite = 1; end //?
        else begin
            //cuif.rs     = cuif.inst[25:21];
            //cuif.rt     = cuif.inst[20:16];
            //cuif.imm    = cuif.inst[15:0];
            unique casez(cuif.inst[31:26])
                BEQ:    begin cuif.aluop = ALU_SUB; cuif.PCSrc = 1; end
                BNE:    begin cuif.aluop = ALU_SUB; cuif.PCSrc = 1; cuif.BNE = 1; end
                ADDI:   begin cuif.RegWrite = 1; cuif.aluop = ALU_ADD; cuif.ALUSrc = 1; cuif.signExt = 1; end
                ADDIU:  begin cuif.RegWrite = 1; cuif.aluop = ALU_ADD; cuif.ALUSrc = 1; cuif.signExt = 1; end
                SLTI:   begin cuif.RegWrite = 1; cuif.aluop = ALU_SLT; cuif.ALUSrc = 1; cuif.signExt = 1; end
                SLTIU:  begin cuif.RegWrite = 1; cuif.aluop = ALU_SLT; cuif.ALUSrc = 1; cuif.signExt = 1; end
                ANDI:   begin cuif.RegWrite = 1; cuif.aluop = ALU_AND; cuif.ALUSrc = 1; end
                ORI:    begin cuif.RegWrite = 1; cuif.aluop = ALU_OR;  cuif.ALUSrc = 1; end
                XORI:   begin cuif.RegWrite = 1; cuif.aluop = ALU_XOR; cuif.ALUSrc = 1; end
                LUI:    begin cuif.RegWrite = 1; cuif.LUI2Reg = 1;     cuif.ALUSrc = 1; end
                LW:     begin cuif.RegWrite = 1; cuif.aluop = ALU_ADD; cuif.ALUSrc = 1;cuif.Mem2Reg = 1; cuif.signExt = 1; cuif.dREN = 1; end
                SW:     begin cuif.dWEN = 1; cuif.aluop = ALU_ADD;     cuif.ALUSrc = 1; cuif.signExt = 1; end
                //LBU:    begin  end
                //LHU:    begin  end
                //SB:     begin  end
                //SH:     begin  end
                //LL:     begin  end
                //SC:     begin  end
                HALT:   begin cuif.halt = 1; end
                default: ;  
            endcase end
        
        
 
    end 





endmodule
