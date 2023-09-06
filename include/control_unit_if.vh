`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// types
`include "cpu_types_pkg.vh"

interface control_unit_if;
    // import types
    import cpu_types_pkg::*;

    //control signal
    logic ExtOp;
    logic ALUSrc;
    logic MemtoReg;
    logic Branch;
    logic Jump;
    logic JR;
    logic RegDst;
    logic RegWr;
    aluop_t ALUCtr;

    //datas from portout to decide whether to branch
    word_t Equal;
    //opcode, funct, and shamt
    opcode_t opcode;
    funct_t funct;
    logic [SHAM_W-1:0]  shamt;
    //Signal to request unit
    logic iread;
    logic dread;
    logic dwrite;
    //halt and flushed
    logic halt;
    logic flushed;

    modport cu(
        input Equal, opcode, funct, shamt, flushed,
        output ExtOp, ALUSrc, MemtoReg, Branch, Jump, JR, RegDst, RegWr, ALUCtr,
        // Control signal
        iread, dread, dwrite
        // Signal to request unit
    );
endinterface
`endif
