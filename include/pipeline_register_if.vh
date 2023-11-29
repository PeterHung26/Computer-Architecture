`ifndef PIPELINE_REGISTER_IF_VH
`define PIPELINE_REGISTER_IF_VH

`include "cpu_types_pkg.vh"

interface pipeline_register_if;
  // import types
  import cpu_types_pkg::*;

  // IF/ID
  logic [31:0]  IF_instr_in;
  logic [31:0]  IF_instr;
  logic [31:0]  IF_pc4;
  logic [31:0]  IF_pc4_in;


    // ID/EX
  logic [31:0]  ID_instr;
  logic [31:0]  ID_pc4;
  logic         ID_RegDst;
  logic         ID_RegWrite;
  logic         ID_PCSrc;
  logic [31:0]  ID_rdat1;
  logic [31:0]  ID_rdat2;
  aluop_t       ID_ALUOP;
  logic         ID_Mem2Reg;
  logic         ID_JAL;     
  logic         ID_dWEN;    
  logic         ID_dREN;    
  logic         ID_halt;    
  logic         ID_Jump2Reg;
  logic         ID_BNE;     
  logic         ID_signExt;
  logic         ID_ALUSrc;
  logic         ID_Jump;
  logic         ID_LUI2Reg;
  


  logic         RegDst_in;
  logic         RegWrite_in;
  logic         PCSrc_in;
  logic [31:0]  rdat1_in;
  logic [31:0]  rdat2_in;
  logic [31:0]  ID_instr_in;
  aluop_t       ALUOP_in;
  logic         Mem2Reg_in;
  logic         JAL_in;     
  logic         dWEN_in;    
  logic         dREN_in;    
  logic         halt_in;    
  logic         Jump2Reg_in;
  logic         BNE_in;     
  logic         signExt_in;
  logic         ALUSrc_in;
  logic         Jump_in;
  logic         LUI2Reg_in;


 

  // EX/MEM
  logic [31:0]  EX_instr;
  logic [31:0]  EX_pc4;
  logic         EX_RegDst;
  logic         EX_RegWrite;
  logic         EX_PCSrc;
  logic [31:0]  EX_rdat1;
  logic [31:0]  EX_rdat2;
  logic [31:0]  EX_rdat2_in;
  aluop_t       EX_ALUOP;
  logic         EX_Mem2Reg;
  logic         EX_JAL;     
  logic         EX_dWEN;    
  logic         EX_dREN;    
  logic         EX_halt;    
  logic         EX_Jump2Reg;
  logic         EX_BNE;     
  logic         EX_signExt;
  logic         EX_ALUSrc;
  logic         EX_zero;
  logic         EX_zero_in;


  logic         EX_Jump;
  logic         EX_LUI2Reg;

  logic [31:0]  EX_ALUOut_in;
  logic [31:0]  EX_ALUOut;


  // MEM/WB
  logic [31:0]  MEM_instr;
  logic [31:0]  MEM_pc4;
  logic         MEM_RegDst;
  logic         MEM_RegWrite;
  logic         MEM_PCSrc;
  logic [31:0]  MEM_rdat1;
  logic [31:0]  MEM_rdat2;
  aluop_t       MEM_ALUOP;
  logic         MEM_Mem2Reg;
  logic         MEM_JAL;     
  logic         MEM_dWEN;    
  logic         MEM_dREN;    
  logic         MEM_halt;    
  logic         MEM_Jump2Reg;
  logic         MEM_BNE;     
  logic         MEM_signExt;
  logic         MEM_ALUSrc;
  logic         MEM_Jump;
  logic         MEM_LUI2Reg;
  
  logic [31:0]  MEM_dmemload;  //
  logic [31:0]  MEM_dmemload_in;
  logic [31:0]  MEM_ALUOut;
  logic [31:0]  MEMWB_RegWriteData_Prev;
  logic [31:0]  MEMWB_RegWriteData_Prev_in;
  logic         MEMWB_RegWrite_Prev;
  logic         MEMWB_RegWrite_Prev_in;
  logic [4:0]   MEMWB_rd_Prev;
  logic [4:0]   MEMWB_rd_Prev_in;

  logic         IF_FLUSH;
  logic         ID_FLUSH;
  logic         EX_FLUSH;
  logic         MEM_FLUSH;

  logic         IF_EN;
  logic         ID_EN;
  logic         EX_EN;
  logic         MEM_EN;


endinterface
`endif
