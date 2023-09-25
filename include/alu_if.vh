`ifndef ALU_IF_VH
`define ALU_IF_VH
`include "cpu_types_pkg.vh"

interface alu_if;
    import cpu_types_pkg::*; // types

    word_t a, b, out;
    aluop_t ops;
    logic negative, overflow, zero;

    modport alu(
        input a,b,ops,
        output negative, overflow, zero, out
    );

    modport tb (
        input negative, overflow, zero, out,
        output a,b,ops
    );

endinterface
`endif