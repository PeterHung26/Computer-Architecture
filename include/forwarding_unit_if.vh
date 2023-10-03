`ifndef FORWARDING_UNIT_IF_VH
`define FORWARDING_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface forwarding_unit_if;
  import cpu_types_pkg::*;
  regbits_t ID_rs, ID_rt;
  regbits_t EX_wsel, MEM_wsel;
  logic EX_RegWrite, MEM_RegWrite;
  logic [1:0] forwarda, forwardb;
  

  //alu port
  modport fu(
    input ID_rs, ID_rt, EX_RegWrite, EX_wsel, MEM_RegWrite, MEM_wsel, 
    output forwarda, forwardb
  );

  //testbench port
  modport tb(
    input forwarda, forwardb, 
    output ID_rs, ID_rt, EX_RegWrite, EX_wsel, MEM_RegWrite, MEM_wsel
  );
endinterface

`endif