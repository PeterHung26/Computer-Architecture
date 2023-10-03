`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  import cpu_types_pkg::*;

  logic negative, overflow, zero;
  word_t porta, portb, portout;
  aluop_t aluop;

  //alu port
  modport alu(
    input porta, portb, aluop,
    output portout, negative, overflow, zero
  );

  //testbench port
  modport tb(
    input portout, negative, overflow, zero,
    output porta, portb, aluop
  );
endinterface

`endif