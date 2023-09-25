`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

`include "cpu_types_pkg.vh"

// The request_unit will detect when memory requests are completed in
// the datapath and take actions to deassert the memory request.

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic     dWEN, dREN, dhit, ihit, dMemWEN, dMemREN;

  // register file ports
  modport ru (
    input   dWEN, dREN, dhit,ihit,  
    output  dMemWEN, dMemREN
  );
  // register file tb
  modport tb (
    input   dMemWEN, dMemREN,
    output  dWEN, dREN, dhit,ihit
  );
endinterface
`endif
