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
    logic PC_EN;
    logic ihit;

    // branch offset and jump location
    word_t   bimm; //Branch
    logic [ADDR_W-1:0]  jimm;
    word_t jraddr;

    // pc
    word_t nxt_pc;
    word_t pcaddr;

    modport pc(
        input Branch, Jump, JR, bimm, jimm, jraddr, ihit, 
        output nxt_pc, pcaddr
    );

    modport tb(
        input nxt_pc, pcaddr,
        output Branch, Jump, JR, bimm, jimm, jraddr, ihit
    );
endinterface
`endif
