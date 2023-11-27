/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"
`include "alu_if.vh"
`include "register_file_if.vh"
`include "control_unit_if.vh"
//`include "request_unit_if.vh"
`include "program_counter_if.vh"
`include "extender_if.vh"
`include "pipeline_register_if.vh"
`include "hazard_unit_if.vh"
`include "forwarding_unit_if.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  // Interface
  alu_if aluif();
  register_file_if rfif();
  control_unit_if cuif();
  //request_unit_if ruif();
  program_counter_if pcif();
  extender_if exif();
  pipeline_register_if prif();
  hazard_unit_if huif();
  forwarding_unit_if fuif();
  // DUT
  alu ALU (CLK, aluif);
  register_file RF (CLK, nRST, rfif);
  control_unit CU (CLK, nRST, cuif);
  //request_unit RU (CLK, nRST, ruif);
  program_counter #(.PC_INIT(PC_INIT)) PC (CLK, nRST, pcif);
  extender EX (CLK, exif);
  pipeline_register PR (CLK, nRST, prif);
  hazard_unit HU (CLK, nRST, huif);
  forwarding_unit FU (CLK, fuif);
  // Signal connected
  logic PCSrc;
  word_t douta;
  word_t doutb;
  word_t dout1;
  word_t dout2;
  word_t forwa;
  word_t forwb;

  //Hazard unit
  assign huif.dhit = dpif.dhit;
  assign huif.ihit = dpif.ihit;
  assign huif.cu_halt = cuif.halt;
  assign huif.cu_Jump = cuif.Jump;
  assign huif.ID_JR = prif.ID_JR;
  assign huif.ID_dread = prif.ID_dread;
  assign huif.PCSrc = PCSrc;
  assign huif.ID_rt = prif.ID_rt;
  assign huif.IF_rs = prif.IF_instr[25:21]; // rs 
  assign huif.IF_rt = prif.IF_instr[20:16]; // rt
  assign prif.IF_EN = huif.IF_EN;
  assign prif.ID_EN = huif.ID_EN;
  assign prif.EX_EN = huif.EX_EN;
  assign prif.MEM_EN = huif.MEM_EN;
  assign prif.IF_FLUSH = huif.IF_FLUSH;
  assign prif.ID_FLUSH = huif.ID_FLUSH;
  assign prif.EX_FLUSH = huif.EX_FLUSH;
  assign prif.MEM_FLUSH = huif.MEM_FLUSH;
  assign prif.halt = huif.pr_halt;
  assign pcif.PC_EN = huif.PC_EN;
  assign dpif.imemREN = huif.iREN;
  assign huif.EX_dread = prif.EX_dread;
  assign huif.EX_dwrite = prif.EX_dwrite;

  //Forwarding Unit
  assign fuif.ID_rs = prif.ID_rs;
  assign fuif.ID_rt = prif.ID_rt;
  assign fuif.EX_RegWrite = prif.EX_RegWrite;
  assign fuif.MEM_RegWrite = prif.MEM_RegWrite;
  assign fuif.EX_wsel = prif.EX_wsel;
  assign fuif.MEM_wsel = prif.MEM_wsel;

  // IF stage
  //Program Counter
  always_comb begin : BRANCH
    PCSrc = 1'b0;
    if(prif.EX_BEQ & prif.EX_zero)
      PCSrc = 1'b1;
    else if(prif.EX_BNE & (!prif.EX_zero))
      PCSrc = 1'b1;
  end
  assign pcif.PCSrc = PCSrc;
  assign pcif.Jump = cuif.Jump;
  assign pcif.JR = prif.ID_JR;
  assign pcif.bimm = prif.EX_ext_imm_16;
  assign pcif.jimm = prif.IF_instr[25:0];
  assign pcif.jraddr = forwa;
  assign pcif.branch_pc = prif.EX_pc4;
  assign dpif.imemaddr = pcif.pcaddr;
  //PipeLine Register
  assign prif.IF_pc4_in = pcif.nxt_pc;
  assign prif.IF_instr_in = dpif.imemload;

  // ID stage
  //Register File
  assign rfif.rsel1 = prif.IF_instr[25:21]; // rs 
  assign rfif.rsel2 = prif.IF_instr[20:16]; // rt
  
  // Control Unit
  assign cuif.opcode = opcode_t'(prif.IF_instr[31:26]);
  assign cuif.funct = funct_t'(prif.IF_instr[5:0]);
  assign cuif.shamt = prif.IF_instr[10:6];

  //Pipeline Register
  assign prif.ID_pc4_in = prif.IF_pc4;
  assign prif.ID_JR_in = cuif.JR;
  assign prif.ID_halt_in = cuif.halt;
  assign prif.ID_JumpReg_in = cuif.JumpReg;
  assign prif.ID_BEQ_in = cuif.BEQ;
  assign prif.ID_BNE_in = cuif.BNE;
  assign prif.ID_MemtoReg_in = cuif.MemtoReg;
  assign prif.ID_RegDst_in = cuif.RegDst;
  assign prif.ID_RegWrite_in = cuif.RegWr;
  assign prif.ID_dread_in = cuif.dread;
  assign prif.ID_dwrite_in = cuif.dwrite;
  assign prif.ID_ExtOP_in = cuif.ExtOp;
  assign prif.ID_ALUSrc_in = cuif.ALUSrc;
  assign prif.ID_LUI_in = cuif.LUI;
  assign prif.ID_ALUCtr_in = cuif.ALUCtr;
  assign prif.ID_rdat1_in = rfif.rdat1;
  assign prif.ID_rdat2_in = rfif.rdat2;
  assign prif.ID_rs_in = prif.IF_instr[25:21]; // rs 
  assign prif.ID_rt_in = prif.IF_instr[20:16]; // rt
  assign prif.ID_rd_in = prif.IF_instr[15:11]; // rt
  assign prif.ID_imm16_in = prif.IF_instr[15:0]; // imm16

  /*always_comb begin : RF_MUX
    if(cuif.RegDst == 2'd0)
      rfif.wsel = dpif.imemload[20:16]; // rt
    else if(cuif.RegDst == 2'd1)
      rfif.wsel = dpif.imemload[15:11]; // rd
    else if(cuif.RegDst == 2'd2)
      rfif.wsel = 5'd31; // return address register
    else
      rfif.wsel = dpif.imemload[20:16];
    if(cuif.MemtoReg)
      dout = dpif.dmemload;
    else
      dout = aluif.portout;

    if(cuif.LDsel == 2'd0)
      dout1 = dout;
    else if(cuif.LDsel == 2'd1)
      dout1 = {24'b0, dout[7:0]};
    else if(cuif.LDsel == 2'd2)
      dout1 = {16'b0, dout[15:0]};
    else
      dout1 = dout;

    if(cuif.JumpReg)
      rfif.wdat = pcif.nxt_pc;
    else
      rfif.wdat = dout1;
    if((dpif.ihit == 1) || (dpif.dhit == 1))
      rfif.WEN = cuif.RegWr;
    else
      rfif.WEN = 1'b0;

  end*/
  // EX Stage



  assign prif.EX_instr_in = prif.ID_instr;
  assign prif.ID_instr_in = prif.IF_instr;
  //Pipeline Register
  assign prif.EX_pc4_in = prif.ID_pc4;
  assign prif.EX_halt_in = prif.ID_halt;
  assign prif.EX_JumpReg_in = prif.ID_JumpReg;
  assign prif.EX_BEQ_in = prif.ID_BEQ;
  assign prif.EX_BNE_in = prif.ID_BNE;
  assign prif.EX_MemtoReg_in = prif.ID_MemtoReg;
  assign prif.EX_RegWrite_in = prif.ID_RegWrite;
  assign prif.EX_dread_in = prif.ID_dread;
  assign prif.EX_dwrite_in = prif.ID_dwrite;
  assign prif.EX_zero_in = aluif.zero;
  assign prif.EX_portout_in = aluif.portout;
  assign prif.EX_ext_imm_16_in = exif.ext_imm;
  assign prif.EX_dmemstore_in = forwb;
  always_comb begin : WSEL
    if(prif.ID_RegDst == 2'd0)
      prif.EX_wsel_in = prif.ID_rt; // rt
    else if(prif.ID_RegDst == 2'd1)
      prif.EX_wsel_in = prif.ID_rd; // rd
    else if(prif.ID_RegDst == 2'd2)
      prif.EX_wsel_in = 5'd31; // return address register
    else
      prif.EX_wsel_in = prif.ID_rt;
  end

  // Extender
  assign exif.ExtOp = prif.ID_ExtOP;
  assign exif.imm = prif.ID_imm16;

  // ALU
  assign aluif.aluop = prif.ID_ALUCtr;
  assign aluif.porta = douta;
  assign aluif.portb = doutb;
  always_comb begin : ALU_MUX
    if(fuif.forwarda == 2'd0)
      forwa = prif.ID_rdat1;
    else if(fuif.forwarda == 2'd1)
      forwa = prif.EX_portout;
    else if(fuif.forwarda == 2'd2)
      forwa = dout1;
    else
      forwa = prif.ID_rdat1;
    if(fuif.forwardb == 2'd0)
      forwb = prif.ID_rdat2;
    else if(fuif.forwardb == 2'd1)
      forwb = prif.EX_portout;
    else if(fuif.forwardb == 2'd2)
      forwb = dout1;
    else
      forwb = prif.ID_rdat2;
    if(prif.ID_LUI)
      douta = 32'd16;
    else
      douta = forwa;
    if(prif.ID_ALUSrc)
      doutb = exif.ext_imm;
    else
      doutb = forwb;
  end

  
  //assign cuif.flushed = dpif.flushed;

  // Request Unit
  /*assign ruif.dhit = dpif.dhit;
  assign ruif.ihit = dpif.ihit;
  assign ruif.dread = cuif.dread;
  assign ruif.dwrite = cuif.dwrite;
  assign ruif.iread = cuif.iread;*/

  // MEM Stage

  //Pipeline Register
  assign prif.MEM_pc4_in = prif.EX_pc4;
  assign prif.MEM_halt_in = prif.EX_halt;
  assign prif.MEM_JumpReg_in = prif.EX_JumpReg;
  assign prif.MEM_MemtoReg_in = prif.EX_MemtoReg;
  assign prif.MEM_RegWrite_in = prif.EX_RegWrite;
  assign prif.MEM_dmemload_in = dpif.dmemload;
  assign prif.MEM_portout_in = prif.EX_portout;
  assign prif.MEM_wsel_in = prif.EX_wsel;

  //Data memory
  assign dpif.dmemaddr = prif.EX_portout;
  assign dpif.dmemREN = prif.EX_dread;
  assign dpif.dmemWEN = prif.EX_dwrite;
  assign dpif.dmemstore = prif.EX_dmemstore;

  // WB Stage
  always_comb begin : WB_MUX
    if(prif.MEM_MemtoReg)
      dout1 = prif.MEM_dmemload;
    else
      dout1 = prif.MEM_portout;
    if(prif.MEM_JumpReg)
      dout2 = prif.MEM_pc4;
    else
      dout2 = dout1;
  end
  // Register File Write
  assign rfif.WEN = prif.MEM_RegWrite;
  assign rfif.wsel = prif.MEM_wsel;
  assign rfif.wdat = dout2;

  // Data path output
  //assign dpif.datomic = ruif.datomic;
  assign dpif.halt = prif.MEM_halt;
  //assign dpif.imemREN = ruif.imemREN; // Update
  //assign dpif.imemaddr = pcif.pcaddr;
  //assign dpif.dmemREN = ruif.dmemREN;
  //assign dpif.dmemWEN = ruif.dmemWEN;
  //assign dpif.dmemaddr = aluif.portout;

  assign dpif.datomic = (prif.EX_instr[31:26] == LL) || (prif.EX_instr[31:26] == SC);
endmodule
