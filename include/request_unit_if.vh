`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// types
`include "cpu_types_pkg.vh"

interface request_unit_if;
    // import types
    import cpu_types_pkg::*;

    // Signal with Caches
    logic datomic;
    logic dmemWEN;
    logic dmemREN;
    logic imemREN;
    logic dhit;
    logic ihit;

    // Signal with Control unit
    logic dread;
    logic dwrite;
    logic iread;

    modport ru(
        input dhit, ihit, dread, dwrite, iread,
        output datomic, dmemWEN, dmemREN, imemREN
    );
endinterface
`endif
