`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  import cpu_types_pkg::*;

  logic dhit, ihit;
  logic cu_halt, cu_Jump, ID_JR, ID_dread, PCSrc;
  regbits_t ID_rt, IF_rs, IF_rt;
  logic EX_dread, EX_dwrite;

  logic IF_EN, ID_EN, EX_EN, MEM_EN;
  logic IF_FLUSH, ID_FLUSH, EX_FLUSH, MEM_FLUSH;
  logic PC_EN;
  logic iREN;
  logic pr_halt;

  //alu port
  modport hu(
    input dhit, ihit, cu_halt, cu_Jump, ID_JR, ID_dread, PCSrc, ID_rt, IF_rs, IF_rt, EX_dread, EX_dwrite, 
    output IF_EN, ID_EN, EX_EN, MEM_EN, IF_FLUSH, ID_FLUSH, EX_FLUSH, MEM_FLUSH, PC_EN, iREN, pr_halt
  );

  //testbench port
  modport tb(
    input IF_EN, ID_EN, EX_EN, MEM_EN, IF_FLUSH, ID_FLUSH, EX_FLUSH, MEM_FLUSH, PC_EN, iREN, pr_halt, 
    output dhit, ihit, cu_halt, cu_Jump, ID_JR, ID_dread, PCSrc, ID_rt, IF_rs, IF_rt, EX_dread, EX_dwrite
  );
endinterface

`endif