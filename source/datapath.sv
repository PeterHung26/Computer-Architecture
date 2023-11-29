// data path interface
`include "datapath_cache_if.vh"
`include "register_file_if.vh"
`include "request_unit_if.vh"
`include "control_unit_if.vh"
`include "alu_if.vh"
`include "pipeline_register_if.vh"
// synthesize -f 200 -t -d -m system_fpga
// testasm -s test.loadstore.asm test.rtype.asm test.halt.asm test.jump.asm test.branch.asm
// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"



module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  // INSTRUCTION DECODE
  logic [OP_W-1:0] IF_opc;
  logic [REG_W-1:0] IF_rt, IF_rs;
  
  logic [OP_W-1:0] ID_opc;
  logic [REG_W-1:0] ID_rs, ID_rt, ID_rd;
  logic [REG_W-1:0] EX_rs, EX_rt, EX_rd;
  logic [REG_W-1:0] exmem_rd, memwb_rd;
  logic [REG_W-1:0] MEM_rs, MEM_rt, MEM_rd;
  logic [FUNC_W-1:0] ID_func;
  logic [IMM_W-1:0] ID_imm, EX_imm, MEM_imm;
  logic [ADDR_W-1:0] ID_addr;
  logic [SHAM_W-1:0] ID_shamt;
  logic porta_hz, portb_hz;
  word_t pc, pcn, pc4;
  word_t ID_imm_LUI, MEM_imm_LUI,EX_imm_LUI, ID_imm_EXT, EX_imm_EXT;
  word_t WB_RegWriteData;
  word_t ALU_Endpoint;

  // interface
  register_file_if     rfif();
  alu_if               aluif();
  control_unit_if      cuif();
  pipeline_register_if ppif();
  hazard_unit_if       huif();

  // connection
  alu               alu(aluif); // comb
  control_unit      cu(cuif);   // comb
  register_file     rf(CLK,nRST, rfif);
  pipeline_register pp(CLK, nRST, ppif);
  hazard_unit    hu(huif);


  always_ff @(posedge CLK, negedge nRST) begin: PC_FF
    if(!nRST)
      pc <= PC_INIT;
    else if(dpif.ihit)
      pc <= pcn;
    else  
      pc <= pc;
  end



  logic [2:0] pc_state;
  logic [31:0] br_addr;
  

  /*
  always_comb begin: PC_COMB_ALWAYS_NOT_TAKEN
    pc4 = pc+4;
    pcn = pc+4;
    pc_state = '0;
    br_addr = ppif.EX_pc4 + (EX_imm_EXT << 2);
    ppif.IF_EN = (dpif.ihit | dpif.dhit);
    ppif.ID_EN = (dpif.ihit | dpif.dhit);
    ppif.EX_EN = (dpif.ihit | dpif.dhit);
    ppif.MEM_EN = (dpif.ihit | dpif.dhit);
    ppif.IF_FLUSH = 0;
    ppif.ID_FLUSH = 0;
    ppif.EX_FLUSH = 0;
    ppif.MEM_FLUSH = 0;

    
    if(ppif.EX_Jump2Reg)
    begin
      pcn = ppif.EX_rdat1; // = aluif.a
      ppif.IF_FLUSH = 1;
      ppif.ID_FLUSH = 1;
      ppif.EX_FLUSH = 1;
      pc_state = 3'd1;
    end
    else if(ppif.EX_Jump)
    begin
      pcn = {ppif.EX_pc4[31:28], ppif.EX_instr[25:0], 2'b00};
      ppif.IF_FLUSH = 1;
      ppif.ID_FLUSH = 1;
      ppif.EX_FLUSH = 1;
      pc_state = 3'd2;
    end
    else if(ppif.EX_PCSrc && ~ppif.EX_BNE && ppif.EX_zero)
    begin
      pcn = ppif.EX_pc4 + (EX_imm_EXT << 2);
      
      ppif.IF_FLUSH = 1;
      ppif.ID_FLUSH = 1;
      ppif.EX_FLUSH = 1;
      pc_state = 3'd3;
    end
    else if(ppif.EX_PCSrc && ppif.EX_BNE && !ppif.EX_zero)
    begin
      pcn = ppif.EX_pc4 + (EX_imm_EXT << 2);

      ppif.IF_FLUSH = 1;
      ppif.ID_FLUSH = 1;
      ppif.EX_FLUSH = 1;
      pc_state = 3'd4;
    end 
    else if(huif.StallLW)
    begin 
      pcn = pc;
      ppif.IF_EN = 0;
      pc_state = 3'd7;
    end
  end
  */
  

  /*
  always_comb begin: PC_COMB_ALWAYS_TAKEN
    pc4 = pc+4;
    pcn = pc+4;
    br_addr = pc4 + ( ( (dpif.imemload[15]) ? {16'hFFFF, dpif.imemload[15:0]} : {16'h0000, dpif.imemload[15:0]} ) << 2 );
    if(dpif.ihit && (dpif.imemload[31:26] == BEQ || dpif.imemload[31:26] == BNE) )
      pcn = br_addr;

    pc_state = '0;
    ppif.IF_EN = (dpif.ihit | dpif.dhit);
    ppif.ID_EN = (dpif.ihit | dpif.dhit);
    ppif.EX_EN = (dpif.ihit | dpif.dhit);
    ppif.MEM_EN = (dpif.ihit | dpif.dhit);
    ppif.IF_FLUSH = 0;
    ppif.ID_FLUSH = 0;
    ppif.EX_FLUSH = 0;
    ppif.MEM_FLUSH = 0;

    
    if(ppif.EX_Jump2Reg)
    begin
      pcn = ppif.EX_rdat1; // = aluif.a
      ppif.IF_FLUSH = 1;
      ppif.ID_FLUSH = 1;
      ppif.EX_FLUSH = 1;
      pc_state = 3'd1;
    end
    else if(ppif.EX_Jump)
    begin
      pcn = {ppif.EX_pc4[31:28], ppif.EX_instr[25:0], 2'b00};
      ppif.IF_FLUSH = 1;
      ppif.ID_FLUSH = 1;
      ppif.EX_FLUSH = 1;
      pc_state = 3'd2;
    end
    else if(ppif.EX_PCSrc && ~ppif.EX_BNE && ~ppif.EX_zero)
    begin
      pcn = ppif.EX_pc4;
      
      ppif.IF_FLUSH = 1;
      ppif.ID_FLUSH = 1;
      ppif.EX_FLUSH = 1;
      pc_state = 3'd3;
    end
    else if(ppif.EX_PCSrc && ppif.EX_BNE && ppif.EX_zero)
    begin
      pcn = ppif.EX_pc4;

      ppif.IF_FLUSH = 1;
      ppif.ID_FLUSH = 1;
      ppif.EX_FLUSH = 1;
      pc_state = 3'd4;
    end 
    else if(huif.StallLW)
    begin 
      pcn = pc;
      ppif.IF_EN = 0;
      pc_state = 3'd7;
    end
  end
  */


  always_comb begin: PC_COMB_ALWAYS_TAKEN
    pc4 = pc+4;
    pcn = pc+4;
    br_addr = pc4 + ( ( (dpif.imemload[15]) ? {16'hFFFF, dpif.imemload[15:0]} : {16'h0000, dpif.imemload[15:0]} ) << 2 );
    if(dpif.ihit && (dpif.imemload[31:26] == BEQ || dpif.imemload[31:26] == BNE) )
      pcn = br_addr;

    pc_state = '0;
    ppif.IF_EN = (dpif.ihit | dpif.dhit);
    ppif.ID_EN = (dpif.ihit | dpif.dhit);
    ppif.EX_EN = (dpif.ihit | dpif.dhit);
    ppif.MEM_EN = (dpif.ihit | dpif.dhit);
    ppif.IF_FLUSH = 0;
    ppif.ID_FLUSH = 0;
    ppif.EX_FLUSH = 0;
    ppif.MEM_FLUSH = 0;

    
    if(ppif.EX_Jump2Reg)
    begin
      pcn = ppif.EX_rdat1; // = aluif.a
      ppif.IF_FLUSH = 1;
      ppif.ID_FLUSH = 1;
      ppif.EX_FLUSH = 1;
      pc_state = 3'd1;
    end
    else if(ppif.EX_Jump)
    begin
      pcn = {ppif.EX_pc4[31:28], ppif.EX_instr[25:0], 2'b00};
      ppif.IF_FLUSH = 1;
      ppif.ID_FLUSH = 1;
      ppif.EX_FLUSH = 1;
      pc_state = 3'd2;
    end
    else if(ppif.EX_PCSrc && ~ppif.EX_BNE && ~ppif.EX_zero)
    begin
      pcn = ppif.EX_pc4;
      
      ppif.IF_FLUSH = 1;
      ppif.ID_FLUSH = 1;
      ppif.EX_FLUSH = 1;
      pc_state = 3'd3;
    end
    else if(ppif.EX_PCSrc && ppif.EX_BNE && ppif.EX_zero)
    begin
      pcn = ppif.EX_pc4;

      ppif.IF_FLUSH = 1;
      ppif.ID_FLUSH = 1;
      ppif.EX_FLUSH = 1;
      pc_state = 3'd4;
    end 
    else if(huif.StallLW)
    begin 
      pcn = pc;
      ppif.IF_EN = 0;
      pc_state = 3'd7;
    end
  end

  
/*
  assign opc     = dpif.imemload[31:26];
  assign rs      = dpif.imemload[25:21];
  assign rt      = dpif.imemload[20:16];
  assign rd      = dpif.imemload[15:11];
  assign shamt   = dpif.imemload[10:6];
  assign func    = dpif.imemload[5:0];
  assign imm     = dpif.imemload[15:0];
  assign addr    = dpif.imemload[25:0];
 */ 
  assign IF_opc     = ppif.IF_instr[31:26];
  assign IF_rs      = ppif.IF_instr[25:21];
  assign IF_rt      = ppif.IF_instr[20:16];
  
  assign ID_opc     = ppif.ID_instr[31:26];
  assign ID_rs      = ppif.ID_instr[25:21];
  assign ID_rt      = ppif.ID_instr[20:16];
  assign ID_rd      = ppif.ID_instr[15:11];
  assign ID_shamt   = ppif.ID_instr[10:6];
  assign ID_func    = ppif.ID_instr[5:0];
  assign ID_addr    = ppif.ID_instr[25:0];
  assign ID_imm     = ppif.ID_instr[15:0];
  assign ID_imm_EXT = (ID_imm[15] & ppif.ID_signExt ) ? {16'hFFFF, ID_imm} : {16'h0000, ID_imm};
  assign ID_imm_LUI = {ppif.ID_instr[15:0],16'h0000};
  
  assign EX_rs      = ppif.EX_instr[25:21];
  assign EX_rt      = ppif.EX_instr[20:16];
  assign EX_rd      = ppif.EX_instr[15:11];
  assign EX_imm     = ppif.EX_instr[15:0];
  assign EX_imm_EXT = (EX_imm[15] & ppif.EX_signExt ) ? {16'hFFFF, EX_imm} : {16'h0000, EX_imm};
  assign EX_imm_LUI = {ppif.EX_instr[15:0],16'h0000};

  assign MEM_rs      = ppif.MEM_instr[25:21];
  assign MEM_rt      = ppif.MEM_instr[20:16];
  assign MEM_rd      = ppif.MEM_instr[15:11];
  assign MEM_imm     = ppif.MEM_instr[15:0];
  assign MEM_imm_LUI = {ppif.MEM_instr[15:0],16'h0000};
  


  


  // IF/ID
  assign ppif.IF_instr_in      = (dpif.ihit) ? dpif.imemload : 0 ;
  assign ppif.IF_pc4_in        = pc4;

  // CONTORL_UNIT     >>  OK
  assign cuif.inst          = ppif.IF_instr;

  // REGISTER FILE
  assign rfif.rsel1       = ppif.IF_instr[25:21];
  assign rfif.rsel2       = ppif.IF_instr[20:16];
  assign rfif.WEN         = ppif.MEM_RegWrite & (dpif.ihit | dpif.dhit);     //?
  assign rfif.wsel        = (ppif.MEM_LUI2Reg)  ? MEM_rt : 
                            (ppif.MEM_JAL)   ? 5'd31 : 
                            (ppif.MEM_RegDst)   ? MEM_rd : MEM_rt;
  assign rfif.wdat        = WB_RegWriteData;
  

  // ID/EX
  assign ppif.ID_instr_in   = (huif.StallLW) ? '0 : ppif.IF_instr;
  assign ppif.RegDst_in     = (huif.StallLW) ? '0 : cuif.RegDst;
  assign ppif.RegWrite_in   = (huif.StallLW) ? '0 : cuif.RegWrite;
  assign ppif.ALUOP_in      = (huif.StallLW) ? ALU_SLL : cuif.aluop;
  assign ppif.Mem2Reg_in    = (huif.StallLW) ? '0 : cuif.Mem2Reg;
  assign ppif.JAL_in        = (huif.StallLW) ? '0 : cuif.JAL;
  assign ppif.LUI2Reg_in    = (huif.StallLW) ? '0 : cuif.LUI2Reg;
  assign ppif.dWEN_in       = (huif.StallLW) ? '0 : cuif.dWEN;
  assign ppif.dREN_in       = (huif.StallLW) ? '0 : cuif.dREN;
  assign ppif.halt_in       = (huif.StallLW) ? '0 : cuif.halt;
  assign ppif.Jump_in       = (huif.StallLW) ? '0 : cuif.Jump;
  assign ppif.Jump2Reg_in   = (huif.StallLW) ? '0 : cuif.Jump2Reg;
  assign ppif.BNE_in        = (huif.StallLW) ? '0 : cuif.BNE;
  assign ppif.signExt_in    = (huif.StallLW) ? '0 : cuif.signExt;
  assign ppif.ALUSrc_in     = (huif.StallLW) ? '0 : cuif.ALUSrc;
  assign ppif.PCSrc_in      = (huif.StallLW) ? '0 : cuif.PCSrc;
  assign ppif.rdat1_in      = (huif.StallLW) ? '0 : rfif.rdat1;
  assign ppif.rdat2_in      = (huif.StallLW) ? '0 : rfif.rdat2;


  assign ppif.EX_rdat2_in   = ppif.ID_rdat2;

 
  
  // EX/MEM
  // RS
  assign aluif.a            = (huif.ForwardA == 2'b10) ? ppif.EX_ALUOut  :
                              (huif.ForwardA == 2'b01) ? WB_RegWriteData   : ppif.ID_rdat1;
  // RT
  assign aluif.b            = (ppif.ID_ALUSrc)         ? ID_imm_EXT      :  
                              (huif.ForwardB == 2'b10) ? ppif.EX_ALUOut  : 
                              (huif.ForwardB == 2'b01) ? WB_RegWriteData   : ppif.ID_rdat2;
                              

                              
  assign aluif.ops          = ppif.ID_ALUOP;   
  assign ppif.EX_zero_in    = aluif.zero;
  assign ALU_Endpoint       = (ppif.ID_LUI2Reg) ? ID_imm_LUI : aluif.out;
  assign ppif.EX_ALUOut_in  = ALU_Endpoint;
  
  

  // MEM/WB
  
  assign ppif.MEM_dmemload_in = dpif.dmemload;
  assign ppif.MEMWB_RegWriteData_Prev_in = WB_RegWriteData;
  assign ppif.MEMWB_RegWrite_Prev_in     = ppif.MEM_RegWrite;
  assign ppif.MEMWB_rd_Prev_in           = (ppif.MEM_RegDst) ? MEM_rd : MEM_rt;

  assign WB_RegWriteData        = (ppif.MEM_LUI2Reg)  ? MEM_imm_LUI :
                                  (ppif.MEM_JAL)      ? ppif.MEM_pc4 : 
                                  (ppif.MEM_Mem2Reg)  ? ppif.MEM_dmemload : ppif.MEM_ALUOut;


  // HAZARD UNIT with FORWARDING
  assign huif.IFID_rt         = IF_rt;
  assign huif.IFID_rs         = IF_rs;
  assign huif.IFID_opc        = IF_opc;
  assign huif.IDEX_RegWrite   = ppif.ID_RegWrite;
  assign huif.IDEX_rd         = (ppif.ID_RegDst) ? ID_rd : ID_rt;
  assign huif.IDEX_rs         = ID_rs;
  assign huif.IDEX_rt         = ID_rt;
  assign huif.EXMEM_rt        = EX_rt;
  assign huif.EXMEM_rd        = (ppif.EX_RegDst) ? EX_rd : EX_rt;
  assign huif.EXMEM_RegWrite  = ppif.EX_RegWrite;
  assign huif.MEMWB_rd        = (ppif.MEM_RegDst) ? MEM_rd : MEM_rt;
  assign huif.MEMWB_RegWrite  = ppif.MEM_RegWrite;
  assign huif.IDEX_dREN       = ppif.ID_dREN;
  assign huif.EXMEM_dREN      = ppif.EX_dREN;
  assign huif.MEMWB_dREN      = ppif.MEM_dREN;

  assign huif.IFID_dWEN       = cuif.dWEN;
  assign huif.IDEX_dWEN       = ppif.ID_dWEN;
  assign huif.EXMEM_dWEN      = ppif.EX_dWEN;
  assign huif.MEMWB_dWEN      = ppif.MEM_dWEN;

  assign huif.MEMWB_RegWrite_Prev = ppif.MEMWB_RegWrite_Prev;
  assign huif.MEMWB_rd_Prev       = ppif.MEMWB_rd_Prev;


  

  // ppif EN/FLUSH

  always_comb begin: PIPELINE_REGS_EN_FULSH

  end

  // dpif
  assign dpif.imemREN     = ~dpif.halt;                                            //?
  assign dpif.imemaddr    = pc;  
  assign dpif.dmemREN     = ppif.EX_dREN;
  assign dpif.dmemWEN     = ppif.EX_dWEN;
  assign dpif.dmemaddr    = ppif.EX_ALUOut; 
  assign dpif.dmemstore   = //(huif.ForwardSW == 2'b11) ? dpif.dmemload :   //?
                            (huif.ForwardSW == 2'b10) ? WB_RegWriteData  :
                            (huif.ForwardSW == 2'b01) ? ppif.MEMWB_RegWriteData_Prev : ppif.EX_rdat2; 


  always_ff @(posedge CLK or negedge nRST) begin: HALT
    if(~nRST) begin
      dpif.halt <= 0;
    end else begin
      dpif.halt <= ppif.EX_halt;
    end
  end 


  assign dpif.datomic = (ppif.EX_instr[31:26] == LL) || (ppif.EX_instr[31:26] == SC);








////////////////////////////
////////////////////////////
///////////////OLD///////////
/////////////////////////////







endmodule