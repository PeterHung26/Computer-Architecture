`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

`include "cpu_types_pkg.vh"

// The request_unit will detect when memory requests are completed in
// the datapath and take actions to deassert the memory request.

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  word_t inst;
  aluop_t aluop;
  logic halt;
  logic RegWrite, Mem2Reg, ALUSrc, PCSrc, RegDst;
  logic Jump2Reg, Jump, JAL, signExt, LUI2Reg, BNE;
  logic dWEN, dREN;

  //regbits_t rs, rt, rd;
  //logic [IMM_W-1:0] imm;
  //logic [ADDR_W-1:0] addr;
  //logic [SHAM_W-1:0] shamt;
  //logic     dmemWEN, dmemREN;
  //logic     dHit, iHit;

  // register file ports
  modport cu (
    input   inst, //dHIT,iHIT,  
    output  dWEN, dREN, signExt, Jump, Jump2Reg, JAL, aluop, ALUSrc, PCSrc, halt, RegWrite, Mem2Reg, RegDst, LUI2Reg, BNE
  );
  // register file tb
  modport tb (
    input   dWEN, dREN, signExt, Jump, Jump2Reg, JAL, aluop, ALUSrc, PCSrc, halt, RegWrite, Mem2Reg, RegDst, LUI2Reg, BNE,
    output  inst //dHIT,iHIT
  );
endinterface

`endif
