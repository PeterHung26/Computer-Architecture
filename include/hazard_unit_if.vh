`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic [1:0] ForwardA, ForwardB;
  logic [1:0] ForwardSW;
  logic [1:0] StallLW;
  logic [5:0] IDEX_rd, IDEX_rs, IDEX_rt, 
              EXMEM_rd, 
              MEMWB_rd,
              MEMWB_rd_Prev, //
              EXMEM_rt;      //
  logic       IDEX_RegWrite,
              IDEX_dREN, EXMEM_dREN, MEMWB_dREN,
              EXMEM_RegWrite,
              MEMWB_RegWrite, 
              MEMWB_RegWrite_Prev; //
  logic       IFID_dWEN, IDEX_dWEN, EXMEM_dWEN, MEMWB_dWEN;
  logic [REG_W-1:0] IFID_rt, IFID_rs;
  logic [OP_W-1:0] IFID_opc;

/*
  modport hu (
    input   IDEX_rd, IDEX_rs, IDEX_rt, EXMEM_rd, MEMWB_rd, IDEX_RegWrite, IDEX_dREN, 
            EXMEM_dREN, MEMWB_dREN, EXMEM_RegWrite, MEMWB_RegWrite, IDEX_dWEN, EXMEM_dWEN, MEMWB_dWEN,
            IFID_rt, IFID_rs, IFID_opc,
    output  ForwardA, ForwardB, ForwardSW, StallLW
  );
  // register file tb
  modport tb (
    input   ForwardA, ForwardB, ForwardSW, StallLW,
    output  IDEX_rd, IDEX_rs, IDEX_rt, EXMEM_rd, MEMWB_rd, IDEX_RegWrite, IDEX_dREN, 
            EXMEM_dREN, MEMWB_dREN, EXMEM_RegWrite, MEMWB_RegWrite, IDEX_dWEN, EXMEM_dWEN, MEMWB_dWEN,
            IFID_rt, IFID_rs, IFID_opc
  );

*/  





endinterface
`endif //REGISTER_FILE_IF_VH
