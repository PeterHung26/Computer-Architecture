`ifndef PROGRAM_COUNTER_IF_VH
`define PROGRAM_COUNTER_IF_VH

// types
`include "cpu_types_pkg.vh"

interface program_counter_if;
    // import types
    import cpu_types_pkg::*;

    //control signal
    logic Branch;
    logic Jump;
    logic JR;
    logic ihit;

    // branch offset and jump location
    logic [IMM_W-1:0]   imm; //Branch
    logic [ADDR_W-1:0]  jimm;
    word_t jraddr;

    // pc
    word_t pcaddr;

    modport pc(
        input Branch, Jump, JR, ihit, imm, jimm, jraddr,
        output pcaddr
    );
endinterface
`endif
