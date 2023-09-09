`ifndef EXTENDER_IF_VH
`define EXTENDER_IF_VH

// types
`include "cpu_types_pkg.vh"

interface extender_if;
    // import types
    import cpu_types_pkg::*;

    logic [IMM_W-1:0]   imm;
    logic ExtOp;
    word_t ext_imm;

    modport ex(
        input imm, ExtOp,
        output ext_imm
    );

    modport tb(
        input ext_imm,
        output imm, ExtOp
    );
endinterface

`endif