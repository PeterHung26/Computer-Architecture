`include "cpu_types_pkg.vh"
`include "pipeline_register_if.vh"



module pipeline_register(
 input logic CLK, input logic nRST,
 pipeline_register_if.pr prif
 );
 import cpu_types_pkg::*;
// pipeline registers
//IF
logic [31:0]  nxt_IF_instr;
logic [31:0]  nxt_IF_pc4;
//ID
logic [31:0]  nxt_ID_pc4;
logic [1:0]   nxt_ID_RegDst;
logic         nxt_ID_RegWrite;
logic         nxt_ID_MemtoReg;
logic         nxt_ID_dread;
logic         nxt_ID_dwrite;
logic         nxt_ID_BEQ;
logic         nxt_ID_BNE;
logic         nxt_ID_JumpReg;
logic         nxt_ID_ExtOP;
logic         nxt_ID_ALUSrc;
logic         nxt_ID_LUI;
aluop_t       nxt_ID_ALUCtr;
logic [31:0]  nxt_ID_rdat1;
logic [31:0]  nxt_ID_rdat2;
logic [4:0]   nxt_ID_rs;
logic [4:0]   nxt_ID_rt;
logic [4:0]   nxt_ID_rd;
logic [15:0]  nxt_ID_imm16;
logic         nxt_ID_halt;
logic         nxt_ID_JR;
opcode_t      nxt_ID_opcode;
//EX
logic [31:0]  nxt_EX_pc4;
logic         nxt_EX_JumpReg;
logic         nxt_EX_BEQ;
logic         nxt_EX_BNE;
logic         nxt_EX_MemtoReg;
logic         nxt_EX_RegWrite;
logic         nxt_EX_dread;
logic         nxt_EX_dwrite;
logic         nxt_EX_zero;
logic [31:0]  nxt_EX_portout;
logic [31:0]  nxt_EX_ext_imm_16;
logic [4:0]   nxt_EX_wsel;
logic         nxt_EX_halt;
logic [31:0]  nxt_EX_dmemstore;
opcode_t      nxt_EX_opcode;
//MEM
logic [31:0]  nxt_MEM_pc4;
logic         nxt_MEM_JumpReg;
logic         nxt_MEM_MemtoReg;
logic         nxt_MEM_RegWrite;
logic [31:0]  nxt_MEM_dmemload;
logic [31:0]  nxt_MEM_portout;
logic [4:0]   nxt_MEM_wsel;
logic         nxt_MEM_halt;

always_ff @ (posedge CLK, negedge nRST) 
begin
  if(!nRST) begin
    //IF
    prif.IF_instr <= '0;
    prif.IF_pc4 <= '0;
    //ID
    prif.ID_pc4 <= '0;
    prif.ID_RegDst <= '0;
    prif.ID_RegWrite <= '0;
    prif.ID_MemtoReg <= '0;
    prif.ID_dread <= '0;
    prif.ID_dwrite <= '0;
    prif.ID_BEQ <= '0;
    prif.ID_BNE <= '0;
    prif.ID_JumpReg <= '0;
    prif.ID_ExtOP <= '0;
    prif.ID_ALUSrc <= '0;
    prif.ID_LUI <= '0;
    prif.ID_ALUCtr <= ALU_SLL;
    prif.ID_rdat1 <= '0;
    prif.ID_rdat2 <= '0;
    prif.ID_rs <= '0;
    prif.ID_rt <= '0;
    prif.ID_rd <= '0;
    prif.ID_imm16 <= '0;
    prif.ID_halt <= '0;
    prif.ID_JR <= '0;
    prif.ID_opcode <= RTYPE;
    //EX
    prif.EX_pc4 <= '0;
    prif.EX_JumpReg <= '0;
    prif.EX_BEQ <= '0;
    prif.EX_BNE <= '0;
    prif.EX_MemtoReg <= '0;
    prif.EX_RegWrite <= '0;
    prif.EX_dread <= '0;
    prif.EX_dwrite <= '0;
    prif.EX_zero <= '0;
    prif.EX_portout <= '0;
    prif.EX_ext_imm_16 <= '0;
    prif.EX_wsel <= '0;
    prif.EX_halt <= '0;
    prif.EX_dmemstore <= '0;
    prif.EX_opcode <= RTYPE;
    //MEM
    prif.MEM_pc4 <= '0;
    prif.MEM_JumpReg <= '0;
    prif.MEM_MemtoReg <= '0;
    prif.MEM_RegWrite <= '0;
    prif.MEM_dmemload <= '0;
    prif.MEM_portout <= '0;
    prif.MEM_wsel <= '0;
    prif.MEM_halt <= '0;
  end
  else begin
    //IF
    prif.IF_instr <= nxt_IF_instr;
    prif.IF_pc4 <= nxt_IF_pc4;
    //ID
    prif.ID_pc4 <= nxt_ID_pc4;
    prif.ID_RegDst <= nxt_ID_RegDst;
    prif.ID_RegWrite <= nxt_ID_RegWrite;
    prif.ID_MemtoReg <= nxt_ID_MemtoReg;
    prif.ID_dread <= nxt_ID_dread;
    prif.ID_dwrite <= nxt_ID_dwrite;
    prif.ID_BEQ <= nxt_ID_BEQ;
    prif.ID_BNE <= nxt_ID_BNE;
    prif.ID_JumpReg <= nxt_ID_JumpReg;
    prif.ID_ExtOP <= nxt_ID_ExtOP;
    prif.ID_ALUSrc <= nxt_ID_ALUSrc;
    prif.ID_LUI <= nxt_ID_LUI;
    prif.ID_ALUCtr <= nxt_ID_ALUCtr;
    prif.ID_rdat1 <= nxt_ID_rdat1;
    prif.ID_rdat2 <= nxt_ID_rdat2;
    prif.ID_rs <= nxt_ID_rs;
    prif.ID_rt <= nxt_ID_rt;
    prif.ID_rd <= nxt_ID_rd;
    prif.ID_imm16 <= nxt_ID_imm16;
    prif.ID_halt <= nxt_ID_halt;
    prif.ID_JR <= nxt_ID_JR;
    prif.ID_opcode <= nxt_ID_opcode;
    //EX
    prif.EX_pc4 <= nxt_EX_pc4;
    prif.EX_JumpReg <= nxt_EX_JumpReg;
    prif.EX_BEQ <= nxt_EX_BEQ;
    prif.EX_BNE <= nxt_EX_BNE;
    prif.EX_MemtoReg <= nxt_EX_MemtoReg;
    prif.EX_RegWrite <= nxt_EX_RegWrite;
    prif.EX_dread <= nxt_EX_dread;
    prif.EX_dwrite <= nxt_EX_dwrite;
    prif.EX_zero <= nxt_EX_zero;
    prif.EX_portout <= nxt_EX_portout;
    prif.EX_ext_imm_16 <= nxt_EX_ext_imm_16;
    prif.EX_wsel <= nxt_EX_wsel;
    prif.EX_halt <= nxt_EX_halt;
    prif.EX_dmemstore <= nxt_EX_dmemstore;
    prif.EX_opcode <= nxt_EX_opcode;
    //MEM
    prif.MEM_pc4 <= nxt_MEM_pc4;
    prif.MEM_JumpReg <= nxt_MEM_JumpReg;
    prif.MEM_MemtoReg <= nxt_MEM_MemtoReg;
    prif.MEM_RegWrite <= nxt_MEM_RegWrite;
    prif.MEM_dmemload <= nxt_MEM_dmemload;
    prif.MEM_portout <= nxt_MEM_portout;
    prif.MEM_wsel <= nxt_MEM_wsel;
    prif.MEM_halt <= nxt_MEM_halt;
  end
end

always_comb begin : NXT_LOGIC
  //IF
  nxt_IF_instr = prif.IF_instr;
  nxt_IF_pc4 = prif.IF_pc4;
  //ID
  nxt_ID_pc4 = prif.ID_pc4;
  nxt_ID_RegDst = prif.ID_RegDst;
  nxt_ID_RegWrite = prif.ID_RegWrite;
  nxt_ID_MemtoReg = prif.ID_MemtoReg;
  nxt_ID_dread = prif.ID_dread;
  nxt_ID_dwrite = prif.ID_dwrite;
  nxt_ID_BEQ = prif.ID_BEQ;
  nxt_ID_BNE = prif.ID_BNE;
  nxt_ID_JumpReg = prif.ID_JumpReg;
  nxt_ID_ExtOP = prif.ID_ExtOP;
  nxt_ID_ALUSrc = prif.ID_ALUSrc;
  nxt_ID_LUI = prif.ID_LUI;
  nxt_ID_ALUCtr = prif.ID_ALUCtr;
  nxt_ID_rdat1 = prif.ID_rdat1;
  nxt_ID_rdat2 = prif.ID_rdat2;
  nxt_ID_rs = prif.ID_rs;
  nxt_ID_rt = prif.ID_rt;
  nxt_ID_rd = prif.ID_rd;
  nxt_ID_imm16 = prif.ID_imm16;
  nxt_ID_halt = prif.ID_halt;
  nxt_ID_JR = prif.ID_JR;
  nxt_ID_opcode = prif.ID_opcode;
  //EX
  nxt_EX_pc4 = prif.EX_pc4;
  nxt_EX_JumpReg = prif.EX_JumpReg;
  nxt_EX_BEQ = prif.EX_BEQ;
  nxt_EX_BNE = prif.EX_BNE;
  nxt_EX_MemtoReg = prif.EX_MemtoReg;
  nxt_EX_RegWrite = prif.EX_RegWrite;
  nxt_EX_dread = prif.EX_dread;
  nxt_EX_dwrite = prif.EX_dwrite;
  nxt_EX_zero = prif.EX_zero;
  nxt_EX_portout = prif.EX_portout;
  nxt_EX_ext_imm_16 = prif.EX_ext_imm_16;
  nxt_EX_wsel = prif.EX_wsel;
  nxt_EX_halt = prif.EX_halt;
  nxt_EX_dmemstore = prif.EX_dmemstore;
  nxt_EX_opcode = prif.EX_opcode;
  //MEM
  nxt_MEM_pc4 = prif.MEM_pc4;
  nxt_MEM_JumpReg = prif.MEM_JumpReg;
  nxt_MEM_MemtoReg = prif.MEM_MemtoReg;
  nxt_MEM_RegWrite = prif.MEM_RegWrite;
  nxt_MEM_dmemload = prif.MEM_dmemload;
  nxt_MEM_portout = prif.MEM_portout;
  nxt_MEM_wsel = prif.MEM_wsel;
  nxt_MEM_halt = prif.MEM_halt;
  //IF
  if(prif.IF_FLUSH) begin
    nxt_IF_instr = '0;
    nxt_IF_pc4 = '0;
  end
  else if(prif.IF_EN) begin
    nxt_IF_instr = prif.IF_instr_in;
    nxt_IF_pc4 = prif.IF_pc4_in;
  end
  //ID
  if(prif.ID_FLUSH) begin
    if(prif.halt)
      nxt_ID_halt = prif.ID_halt_in;
    else
      nxt_ID_halt = '0;
    nxt_ID_pc4 = '0;
    nxt_ID_RegDst = '0;
    nxt_ID_RegWrite = '0;
    nxt_ID_MemtoReg = '0;
    nxt_ID_dread = '0;
    nxt_ID_dwrite = '0;
    nxt_ID_BEQ = '0;
    nxt_ID_BNE = '0;
    nxt_ID_JumpReg = '0;
    nxt_ID_ExtOP = '0;
    nxt_ID_ALUSrc = '0;
    nxt_ID_LUI = '0;
    nxt_ID_ALUCtr = ALU_SLL;
    nxt_ID_rdat1 = '0;
    nxt_ID_rdat2 = '0;
    nxt_ID_rs = '0;
    nxt_ID_rt = '0;
    nxt_ID_rd = '0;
    nxt_ID_imm16 = '0;
    //nxt_ID_halt = '0;
    nxt_ID_JR = '0;
    nxt_ID_opcode = RTYPE;
  end
  else if(prif.ID_EN) begin
    nxt_ID_pc4 = prif.ID_pc4_in;
    nxt_ID_RegDst = prif.ID_RegDst_in;
    nxt_ID_RegWrite = prif.ID_RegWrite_in;
    nxt_ID_MemtoReg = prif.ID_MemtoReg_in;
    nxt_ID_dread = prif.ID_dread_in;
    nxt_ID_dwrite = prif.ID_dwrite_in;
    nxt_ID_BEQ = prif.ID_BEQ_in;
    nxt_ID_BNE = prif.ID_BNE_in;
    nxt_ID_JumpReg = prif.ID_JumpReg_in;
    nxt_ID_ExtOP = prif.ID_ExtOP_in;
    nxt_ID_ALUSrc = prif.ID_ALUSrc_in;
    nxt_ID_LUI = prif.ID_LUI_in;
    nxt_ID_ALUCtr = prif.ID_ALUCtr_in;
    nxt_ID_rdat1 = prif.ID_rdat1_in;
    nxt_ID_rdat2 = prif.ID_rdat2_in;
    nxt_ID_rs = prif.ID_rs_in;
    nxt_ID_rt = prif.ID_rt_in;
    nxt_ID_rd = prif.ID_rd_in;
    nxt_ID_imm16 = prif.ID_imm16_in;
    nxt_ID_halt = prif.ID_halt_in;
    nxt_ID_JR = prif.ID_JR_in;
    nxt_ID_opcode = prif.ID_opcode_in;
  end
  //EX
  if(prif.EX_FLUSH) begin
    if(prif.halt)
      nxt_EX_halt = prif.EX_halt_in;
    else
      nxt_EX_halt = '0;
    nxt_EX_pc4 = '0;
    nxt_EX_JumpReg = '0;
    nxt_EX_BEQ = '0;
    nxt_EX_BNE = '0;
    nxt_EX_MemtoReg = '0;
    nxt_EX_RegWrite = '0;
    nxt_EX_dread = '0;
    nxt_EX_dwrite = '0;
    nxt_EX_zero = '0;
    nxt_EX_portout = '0;
    nxt_EX_ext_imm_16 = '0;
    nxt_EX_wsel = '0;
    //nxt_EX_halt = '0;
    nxt_EX_dmemstore = '0;
    nxt_EX_opcode = RTYPE;
  end
  else if(prif.EX_EN) begin
    nxt_EX_pc4 = prif.EX_pc4_in;
    nxt_EX_JumpReg = prif.EX_JumpReg_in;
    nxt_EX_BEQ = prif.EX_BEQ_in;
    nxt_EX_BNE = prif.EX_BNE_in;
    nxt_EX_MemtoReg = prif.EX_MemtoReg_in;
    nxt_EX_RegWrite = prif.EX_RegWrite_in;
    nxt_EX_dread = prif.EX_dread_in;
    nxt_EX_dwrite = prif.EX_dwrite_in;
    nxt_EX_zero = prif.EX_zero_in;
    nxt_EX_portout = prif.EX_portout_in;
    nxt_EX_ext_imm_16 = prif.EX_ext_imm_16_in;
    nxt_EX_wsel = prif.EX_wsel_in;
    nxt_EX_halt = prif.EX_halt_in;
    nxt_EX_dmemstore = prif.EX_dmemstore_in;
    nxt_EX_opcode = prif.EX_opcode_in;
  end
  //MEM
  if(prif.MEM_FLUSH) begin
    if(prif.halt)
      nxt_MEM_halt = prif.MEM_halt_in;
    else
      nxt_MEM_halt = '0;
    nxt_MEM_pc4 = '0;
    nxt_MEM_JumpReg = '0;
    nxt_MEM_MemtoReg = '0;
    nxt_MEM_RegWrite = '0;
    nxt_MEM_dmemload = '0;
    nxt_MEM_portout = '0;
    nxt_MEM_wsel = '0;
    nxt_MEM_halt = '0;
  end
  else if(prif.MEM_EN) begin
    nxt_MEM_pc4 = prif.MEM_pc4_in;
    nxt_MEM_JumpReg = prif.MEM_JumpReg_in;
    nxt_MEM_MemtoReg = prif.MEM_MemtoReg_in;
    nxt_MEM_RegWrite = prif.MEM_RegWrite_in;
    nxt_MEM_dmemload = prif.MEM_dmemload_in;
    nxt_MEM_portout = prif.MEM_portout_in;
    nxt_MEM_wsel = prif.MEM_wsel_in;
    nxt_MEM_halt = prif.MEM_halt_in;
  end
end




endmodule