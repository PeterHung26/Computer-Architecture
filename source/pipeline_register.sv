`include "cpu_types_pkg.vh"
`include "pipeline_register_if.vh"



module pipeline_register(
 input logic CLK, input logic nRST,
 pipeline_register_if ppif
 );
 import cpu_types_pkg::*;
// pipeline registers


always_ff @ (posedge CLK, negedge nRST) 
begin
  if(!nRST)  
  begin: PIPELINE_RESET
    //IF/ID
    ppif.IF_instr      <= '0;
    ppif.IF_pc4        <= '0;
    

    //ID/EX
    ppif.ID_instr       <= '0;
    ppif.ID_pc4         <= '0;
    ppif.ID_RegDst      <= '0;
    ppif.ID_RegWrite    <= '0;
    ppif.ID_PCSrc       <= '0;
    ppif.ID_rdat1       <= '0;
    ppif.ID_rdat2       <= '0;
    ppif.ID_ALUOP       <= ALU_SLL;
    ppif.ID_Mem2Reg     <= '0;
    ppif.ID_JAL         <= '0;
    ppif.ID_dWEN        <= '0;
    ppif.ID_dREN        <= '0;
    ppif.ID_halt        <= '0;
    ppif.ID_Jump2Reg    <= '0;
    ppif.ID_BNE         <= '0;
    ppif.ID_ALUSrc      <= '0;
    ppif.ID_Jump        <= '0;
    ppif.ID_LUI2Reg     <= '0;
    ppif.ID_signExt     <= '0;
    


    //EX/MEM
    ppif.EX_instr       <= '0;
    ppif.EX_pc4         <= '0;
    ppif.EX_RegDst      <= '0;
    ppif.EX_RegWrite    <= '0;
    ppif.EX_PCSrc       <= '0;
    ppif.EX_rdat1       <= '0;
    ppif.EX_rdat2       <= '0;
    ppif.EX_ALUOP       <= ALU_SLL;
    ppif.EX_Mem2Reg     <= '0;
    ppif.EX_JAL         <= '0;
    ppif.EX_dWEN        <= '0;
    ppif.EX_dREN        <= '0;
    ppif.EX_halt        <= '0;
    ppif.EX_Jump2Reg    <= '0;
    ppif.EX_BNE         <= '0;
    ppif.EX_ALUSrc      <= '0;
    ppif.EX_Jump        <= '0;
    ppif.EX_LUI2Reg     <= '0;
    ppif.EX_signExt     <= '0;
    ppif.EX_zero        <= '0;
    ppif.EX_ALUOut      <= '0;


    // MEM/WB
    ppif.MEM_instr       <= '0;
    ppif.MEM_pc4         <= '0;
    ppif.MEM_RegDst      <= '0;
    ppif.MEM_RegWrite    <= '0;
    ppif.MEM_PCSrc       <= '0;
    ppif.MEM_rdat1       <= '0;
    ppif.MEM_rdat2       <= '0;
    ppif.MEM_ALUOP       <= ALU_SLL;
    ppif.MEM_Mem2Reg     <= '0;
    ppif.MEM_JAL         <= '0;
    ppif.MEM_dWEN        <= '0;
    ppif.MEM_dREN        <= '0;
    ppif.MEM_halt        <= '0;
    ppif.MEM_Jump2Reg    <= '0;
    ppif.MEM_BNE         <= '0;
    ppif.MEM_ALUSrc      <= '0;
    ppif.MEM_Jump        <= '0;
    ppif.MEM_LUI2Reg     <= '0;
    ppif.MEM_signExt     <= '0;

    ppif.MEM_dmemload    <= '0;
    ppif.MEM_ALUOut      <= '0;

    ppif.MEMWB_rd_Prev            <= '0;
    ppif.MEMWB_RegWrite_Prev      <= '0;
    ppif.MEMWB_RegWriteData_Prev  <= '0;
  end
  else 
  begin 
    // IF/ID
    if(ppif.IF_EN && !ppif.IF_FLUSH) 
    begin:IFID_REGISTER_EN
      // IF/ID
      ppif.IF_instr       <= ppif.IF_instr_in;
      ppif.IF_pc4         <= ppif.IF_pc4_in;
    end
    else if(ppif.IF_EN && ppif.IF_FLUSH) 
    begin:IFID_REGISTER_FLUSH
      ppif.IF_instr      <= '0;
      ppif.IF_pc4        <= '0;
    end

     // ID/EX
    if(ppif.ID_EN && !ppif.ID_FLUSH) 
    begin:IDEX_REGISTER_EN
      ppif.ID_instr       <= ppif.ID_instr_in;
      ppif.ID_pc4         <= ppif.IF_pc4;
      ppif.ID_RegDst      <= ppif.RegDst_in;
      ppif.ID_RegWrite    <= ppif.RegWrite_in;
      ppif.ID_rdat1       <= ppif.rdat1_in;
      ppif.ID_rdat2       <= ppif.rdat2_in;
      ppif.ID_ALUOP       <= ppif.ALUOP_in;
      ppif.ID_Mem2Reg     <= ppif.Mem2Reg_in;
      ppif.ID_JAL         <= ppif.JAL_in;
      ppif.ID_dWEN        <= ppif.dWEN_in;
      ppif.ID_dREN        <= ppif.dREN_in;
      ppif.ID_halt        <= ppif.halt_in;
      ppif.ID_Jump2Reg    <= ppif.Jump2Reg_in;
      ppif.ID_BNE         <= ppif.BNE_in;
      ppif.ID_ALUSrc      <= ppif.ALUSrc_in;
      ppif.ID_PCSrc       <= ppif.PCSrc_in;
      ppif.ID_Jump        <= ppif.Jump_in;
      ppif.ID_LUI2Reg     <= ppif.LUI2Reg_in;
      ppif.ID_signExt     <= ppif.signExt_in;
    end
    else if(ppif.ID_EN && ppif.IF_FLUSH) 
    begin:IDEX_REGISTER_FLUSH
      ppif.ID_instr       <= '0;
      ppif.ID_pc4         <= '0;
      ppif.ID_RegDst      <= '0;
      ppif.ID_RegWrite    <= '0;
      ppif.ID_PCSrc       <= '0;
      ppif.ID_rdat1       <= '0;
      ppif.ID_rdat2       <= '0;
      ppif.ID_ALUOP       <= ALU_SLL;
      ppif.ID_Mem2Reg     <= '0;
      ppif.ID_JAL         <= '0;
      ppif.ID_dWEN        <= '0;
      ppif.ID_dREN        <= '0;
      ppif.ID_halt        <= '0;
      ppif.ID_Jump2Reg    <= '0;
      ppif.ID_BNE         <= '0;
      ppif.ID_ALUSrc      <= '0;
      ppif.ID_Jump        <= '0;
      ppif.ID_LUI2Reg     <= '0;
      ppif.ID_signExt     <= '0;
    end
    
    // EX/MEM
    if(ppif.EX_EN && !ppif.EX_FLUSH) 
    begin:EXMEM_REGISTER_EN

      ppif.EX_instr       <= ppif.ID_instr;
      ppif.EX_pc4         <= ppif.ID_pc4;
      ppif.EX_RegDst      <= ppif.ID_RegDst;
      ppif.EX_RegWrite    <= ppif.ID_RegWrite;
      ppif.EX_rdat1       <= ppif.ID_rdat1;
      ppif.EX_ALUOP       <= ppif.ID_ALUOP;
      ppif.EX_Mem2Reg     <= ppif.ID_Mem2Reg;
      ppif.EX_JAL         <= ppif.ID_JAL;
      ppif.EX_LUI2Reg     <= ppif.ID_LUI2Reg;
      ppif.EX_dWEN        <= ppif.ID_dWEN;
      ppif.EX_dREN        <= ppif.ID_dREN;
      ppif.EX_halt        <= ppif.ID_halt;
      ppif.EX_Jump2Reg    <= ppif.ID_Jump2Reg;
      ppif.EX_BNE         <= ppif.ID_BNE;
      ppif.EX_ALUSrc      <= ppif.ID_ALUSrc;
      ppif.EX_PCSrc       <= ppif.ID_PCSrc;
      ppif.EX_Jump        <= ppif.ID_Jump;
      ppif.EX_signExt     <= ppif.ID_signExt;
      
      ppif.EX_zero        <= ppif.EX_zero_in;
      ppif.EX_ALUOut      <= ppif.EX_ALUOut_in;
      ppif.EX_rdat2       <= ppif.EX_rdat2_in;
    end
    else if(ppif.EX_EN && ppif.EX_FLUSH) 
    begin:EXMEM_REGISTER_FLUSH
      ppif.EX_instr       <= '0;
      ppif.EX_pc4         <= '0;
      ppif.EX_RegDst      <= '0;
      ppif.EX_RegWrite    <= '0;
      ppif.EX_PCSrc       <= '0;
      ppif.EX_rdat1       <= '0;
      ppif.EX_rdat2       <= '0;
      ppif.EX_ALUOP       <= ALU_SLL;
      ppif.EX_Mem2Reg     <= '0;
      ppif.EX_JAL         <= '0;
      ppif.EX_dWEN        <= '0;
      ppif.EX_dREN        <= '0;
      ppif.EX_halt        <= '0;
      ppif.EX_Jump2Reg    <= '0;
      ppif.EX_BNE         <= '0;
      ppif.EX_ALUSrc      <= '0;
      ppif.EX_Jump        <= '0;
      ppif.EX_LUI2Reg     <= '0;
      ppif.EX_signExt     <= '0;
      ppif.EX_zero        <= '0;
      ppif.EX_ALUOut      <= '0;
    end    


    // MEM/WB
    if(ppif.MEM_EN && !ppif.MEM_FLUSH) 
    begin:MEMWB_REGISTER_EN
    
      ppif.MEM_instr       <= ppif.EX_instr;
      ppif.MEM_pc4         <= ppif.EX_pc4;
      ppif.MEM_RegDst      <= ppif.EX_RegDst;
      ppif.MEM_RegWrite    <= ppif.EX_RegWrite;
      ppif.MEM_rdat1       <= ppif.EX_rdat1;
      ppif.MEM_rdat2       <= ppif.EX_rdat2;
      ppif.MEM_ALUOP       <= ppif.EX_ALUOP;
      ppif.MEM_Mem2Reg     <= ppif.EX_Mem2Reg;
      ppif.MEM_JAL         <= ppif.EX_JAL;
      ppif.MEM_dWEN        <= ppif.EX_dWEN;
      ppif.MEM_dREN        <= ppif.EX_dREN;
      ppif.MEM_halt        <= ppif.EX_halt;
      ppif.MEM_Jump2Reg    <= ppif.EX_Jump2Reg;
      ppif.MEM_BNE         <= ppif.EX_BNE;
      ppif.MEM_ALUSrc      <= ppif.EX_ALUSrc;
      ppif.MEM_PCSrc       <= ppif.EX_PCSrc;
      ppif.MEM_Jump        <= ppif.EX_Jump;
      ppif.MEM_LUI2Reg     <= ppif.EX_LUI2Reg;
      ppif.MEM_signExt     <= ppif.EX_signExt;

      
      ppif.MEM_dmemload    <= ppif.MEM_dmemload_in;
      ppif.MEM_ALUOut      <= ppif.EX_ALUOut;

      ppif.MEMWB_rd_Prev            <= ppif.MEMWB_rd_Prev_in;
      ppif.MEMWB_RegWrite_Prev      <= ppif.MEMWB_RegWrite_Prev_in;
      ppif.MEMWB_RegWriteData_Prev  <= ppif.MEMWB_RegWriteData_Prev_in;
      
  
    end
    else if(ppif.MEM_EN && ppif.MEM_FLUSH) 
    begin:MEM_WB_REGISTER_FLUSH
      ppif.MEM_instr       <= '0;
      ppif.MEM_pc4         <= '0;
      ppif.MEM_RegDst      <= '0;
      ppif.MEM_RegWrite    <= '0;
      ppif.MEM_PCSrc       <= '0;
      ppif.MEM_rdat1       <= '0;
      ppif.MEM_rdat2       <= '0;
      ppif.MEM_ALUOP       <= ALU_SLL;
      ppif.MEM_Mem2Reg     <= '0;
      ppif.MEM_JAL         <= '0;
      ppif.MEM_dWEN        <= '0;
      ppif.MEM_dREN        <= '0;
      ppif.MEM_halt        <= '0;
      ppif.MEM_Jump2Reg    <= '0;
      ppif.MEM_BNE         <= '0;
      ppif.MEM_ALUSrc      <= '0;
      ppif.MEM_Jump        <= '0;
      ppif.MEM_LUI2Reg     <= '0;
      ppif.MEM_signExt     <= '0;

      ppif.MEM_dmemload    <= '0;
      ppif.MEM_ALUOut      <= '0;

      ppif.MEMWB_rd_Prev            <= '0;
      ppif.MEMWB_RegWrite_Prev      <= '0;
      ppif.MEMWB_RegWriteData_Prev  <= '0;
      
    end    
  end
end






endmodule