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
    logic [1:0] RegDst;
    logic RegWr;
    aluop_t ALUCtr;
    logic JumpReg;
    logic LUI;
    logic [1:0] LDsel;
    logic [1:0] SVsel;

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
    //Flag from ALU
    logic zero;
    logic negative;
    logic overflow;

    modport cu(
        input Equal, opcode, funct, shamt, flushed, zero, negative, overflow, 
        output ExtOp, ALUSrc, MemtoReg, Branch, Jump, JR, RegDst, RegWr, ALUCtr, JumpReg, LUI, LDsel, SVsel, 
        // Control signal
        iread, dread, dwrite,
        // Signal to request unit
        halt
    );

    modport tb(
        input ExtOp, ALUSrc, MemtoReg, Branch, Jump, JR, RegDst, RegWr, ALUCtr, JumpReg, LUI, LDsel, SVsel, 
        // Control signal
        iread, dread, dwrite,
        // Signal to request unit
        halt,
        output Equal, opcode, funct, shamt, flushed, zero, negative, overflow
    );
endinterface
`endif
