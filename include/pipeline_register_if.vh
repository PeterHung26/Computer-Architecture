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
  logic [31:0]  ID_pc4;
  logic [1:0]   ID_RegDst;
  logic         ID_RegWrite;
  logic         ID_MemtoReg;
  logic         ID_dread;
  logic         ID_dwrite;
  logic         ID_BEQ;
  logic         ID_BNE;
  logic         ID_JumpReg;
  logic         ID_ExtOP;
  logic         ID_ALUSrc;
  logic         ID_LUI;
  aluop_t       ID_ALUCtr;
  logic [31:0]  ID_rdat1;
  logic [31:0]  ID_rdat2;
  logic [4:0]   ID_rs;
  logic [4:0]   ID_rt;
  logic [4:0]   ID_rd;
  logic [15:0]  ID_imm16;
  logic         ID_halt;
  logic         ID_JR;

  logic [31:0]  ID_pc4_in;
  logic [1:0]   ID_RegDst_in;
  logic         ID_RegWrite_in;
  logic         ID_MemtoReg_in;
  logic         ID_dread_in;
  logic         ID_dwrite_in;
  logic         ID_BEQ_in;
  logic         ID_BNE_in;
  logic         ID_JumpReg_in;
  logic         ID_ExtOP_in;
  logic         ID_ALUSrc_in;
  logic         ID_LUI_in;
  aluop_t       ID_ALUCtr_in;
  logic [31:0]  ID_rdat1_in;
  logic [31:0]  ID_rdat2_in;
  logic [4:0]   ID_rs_in;
  logic [4:0]   ID_rt_in;
  logic [4:0]   ID_rd_in;
  logic [15:0]  ID_imm16_in;
  logic         ID_halt_in;
  logic         ID_JR_in;


 

  // EX/MEM
  logic [31:0]  EX_pc4;
  logic         EX_JumpReg;
  logic         EX_BEQ;
  logic         EX_BNE;
  logic         EX_MemtoReg;
  logic         EX_RegWrite;
  logic         EX_dread;
  logic         EX_dwrite;
  logic         EX_zero;
  logic [31:0]  EX_portout;
  logic [31:0]  EX_ext_imm_16;
  logic [4:0]   EX_wsel;
  logic         EX_halt;
  logic [31:0]  EX_dmemstore;

  logic [31:0]  EX_pc4_in;
  logic         EX_JumpReg_in;
  logic         EX_BEQ_in;
  logic         EX_BNE_in;
  logic         EX_MemtoReg_in;
  logic         EX_RegWrite_in;
  logic         EX_dread_in;
  logic         EX_dwrite_in;
  logic         EX_zero_in;
  logic [31:0]  EX_portout_in;
  logic [31:0]  EX_ext_imm_16_in;
  logic [4:0]   EX_wsel_in;
  logic         EX_halt_in;
  logic [31:0]  EX_dmemstore_in;

  // MEM/WB
  logic [31:0]  MEM_pc4;
  logic         MEM_JumpReg;
  logic         MEM_MemtoReg;
  logic         MEM_RegWrite;
  logic [31:0]  MEM_dmemload;
  logic [31:0]  MEM_portout;
  logic [4:0]   MEM_wsel;
  logic         MEM_halt;
  
  logic [31:0]  MEM_pc4_in;
  logic         MEM_JumpReg_in;
  logic         MEM_MemtoReg_in;
  logic         MEM_RegWrite_in;
  logic [31:0]  MEM_dmemload_in;
  logic [31:0]  MEM_portout_in;
  logic [4:0]   MEM_wsel_in;
  logic         MEM_halt_in;

  //Flush and enable signals
  logic         IF_FLUSH;
  logic         ID_FLUSH;
  logic         EX_FLUSH;
  logic         MEM_FLUSH;

  logic         IF_EN;
  logic         ID_EN;
  logic         EX_EN;
  logic         MEM_EN;

  logic         halt;


  logic [31:0]  ID_instr;
  logic [31:0]  EX_instr;
  
  logic [31:0]  ID_instr_in;
  logic [31:0]  EX_instr_in;


  modport pr (
  input IF_instr_in, IF_pc4_in, 
        ID_pc4_in, ID_RegDst_in, ID_RegWrite_in, ID_MemtoReg_in, ID_dread_in, ID_dwrite_in, ID_BEQ_in, ID_BNE_in, ID_JumpReg_in, ID_ExtOP_in, ID_ALUSrc_in, ID_LUI_in, ID_ALUCtr_in, ID_rdat1_in, ID_rdat2_in, ID_rs_in, ID_rt_in, ID_rd_in, ID_imm16_in, ID_halt_in, ID_JR_in, 
        EX_pc4_in, EX_JumpReg_in, EX_BEQ_in, EX_BNE_in, EX_MemtoReg_in, EX_RegWrite_in, EX_dread_in, EX_dwrite_in, EX_zero_in, EX_portout_in, EX_ext_imm_16_in, EX_wsel_in, EX_halt_in, EX_dmemstore_in, 
        MEM_pc4_in, MEM_JumpReg_in, MEM_MemtoReg_in, MEM_RegWrite_in, MEM_dmemload_in, MEM_portout_in, MEM_wsel_in, MEM_halt_in, 
        IF_FLUSH, ID_FLUSH, EX_FLUSH, MEM_FLUSH, IF_EN, ID_EN, EX_EN, MEM_EN, halt, ID_instr_in, EX_instr_in,

  output IF_instr, IF_pc4,
        ID_pc4, ID_RegDst, ID_RegWrite, ID_MemtoReg, ID_dread, ID_dwrite, ID_BEQ, ID_BNE, ID_JumpReg, ID_ExtOP, ID_ALUSrc, ID_LUI, ID_ALUCtr, ID_rdat1, ID_rdat2, ID_rs, ID_rt, ID_rd, ID_imm16, ID_halt, ID_JR, 
        EX_pc4, EX_JumpReg, EX_BEQ, EX_BNE, EX_MemtoReg, EX_RegWrite, EX_dread, EX_dwrite, EX_zero, EX_portout, EX_ext_imm_16, EX_wsel, EX_halt, EX_dmemstore, 
        MEM_pc4, MEM_JumpReg, MEM_MemtoReg, MEM_RegWrite, MEM_dmemload, MEM_portout, MEM_wsel, MEM_halt, ID_instr, EX_instr
  );
  modport tb (
  input IF_instr, IF_pc4,
        ID_pc4, ID_RegDst, ID_RegWrite, ID_MemtoReg, ID_dread, ID_dwrite, ID_BEQ, ID_BNE, ID_JumpReg, ID_ExtOP, ID_ALUSrc, ID_LUI, ID_ALUCtr, ID_rdat1, ID_rdat2, ID_rs, ID_rt, ID_rd, ID_imm16, ID_halt, ID_JR, 
        EX_pc4, EX_JumpReg, EX_BEQ, EX_BNE, EX_MemtoReg, EX_RegWrite, EX_dread, EX_dwrite, EX_zero, EX_portout, EX_ext_imm_16, EX_wsel, EX_halt, EX_dmemstore, 
        MEM_pc4, MEM_JumpReg, MEM_MemtoReg, MEM_RegWrite, MEM_dmemload, MEM_portout, MEM_wsel, MEM_halt, 
  output IF_instr_in, IF_pc4_in,
        ID_pc4_in, ID_RegDst_in, ID_RegWrite_in, ID_MemtoReg_in, ID_dread_in, ID_dwrite_in, ID_BEQ_in, ID_BNE_in, ID_JumpReg_in, ID_ExtOP_in, ID_ALUSrc_in, ID_LUI_in, ID_ALUCtr_in, ID_rdat1_in, ID_rdat2_in, ID_rs_in, ID_rt_in, ID_rd_in, ID_imm16_in, ID_halt_in, ID_JR_in, 
        EX_pc4_in, EX_JumpReg_in, EX_BEQ_in, EX_BNE_in, EX_MemtoReg_in, EX_RegWrite_in, EX_dread_in, EX_dwrite_in, EX_zero_in, EX_portout_in, EX_ext_imm_16_in, EX_wsel_in, EX_halt_in, EX_dmemstore_in, 
        MEM_pc4_in, MEM_JumpReg_in, MEM_MemtoReg_in, MEM_RegWrite_in, MEM_dmemload_in, MEM_portout_in, MEM_wsel_in, MEM_halt_in, 
        IF_FLUSH, ID_FLUSH, EX_FLUSH, MEM_FLUSH, IF_EN, ID_EN, EX_EN, MEM_EN, halt
  );
endinterface
`endif
