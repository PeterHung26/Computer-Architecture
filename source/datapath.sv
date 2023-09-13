/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"
`include "alu_if.vh"
`include "register_file_if.vh"
`include "control_unit_if.vh"
`include "request_unit_if.vh"
`include "program_counter_if.vh"
`include "extender_if.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  // Interface
  alu_if aluif();
  register_file_if rfif();
  control_unit_if cuif();
  request_unit_if ruif();
  program_counter_if pcif();
  extender_if exif();
  // DUT
  alu ALU (CLK, aluif);
  register_file RF (CLK, nRST, rfif);
  control_unit CU (CLK, nRST, cuif);
  request_unit RU (CLK, nRST, ruif);
  program_counter PC (CLK, nRST, pcif);
  extender EX (CLK, exif);
  // Signal connected
  word_t dout;
  word_t dout1;

  // PC Signal
  assign pcif.Branch = cuif.Branch;
  assign pcif.Jump = cuif.Jump;
  assign pcif.JR = cuif.JR;
  assign pcif.ihit = dpif.ihit;
  assign pcif.bimm = exif.ext_imm;
  assign pcif.jimm = dpif.imemload[25:0];
  assign pcif.jraddr = rfif.rdat1;

  // Register File
  //assign rfif.WEN = cuif.RegWr;
  assign rfif.rsel1 = dpif.imemload[25:21]; // rs
  assign rfif.rsel2 = dpif.imemload[20:16]; // rt
  always_comb begin : RF_MUX
    if(cuif.RegDst == 2'd0)
      rfif.wsel = dpif.imemload[20:16]; // rt
    else if(cuif.RegDst == 2'd1)
      rfif.wsel = dpif.imemload[15:11]; // rd
    else if(cuif.RegDst == 2'd2)
      rfif.wsel = 5'd31; // return address register
    else
      rfif.wsel = dpif.imemload[20:16];
    /*casez (cuif.RegDst)
      2'd0: begin
        rfif.wsel = dpif.imemload[20:16]; // rt
      end
      2'd1: begin
        rfif.wsel = dpif.imemload[15:11]; // rd
      end
      2'd2: begin
        rfif.wsel = 5'd31; // return address register
      end
      default: begin
        rfif.wsel = 2'b0;
      end 
    endcase*/
    if(cuif.MemtoReg)
      dout = dpif.dmemload;
    else
      dout = aluif.portout;

    if(cuif.LDsel == 2'd0)
      dout1 = dout;
    else if(cuif.LDsel == 2'd1)
      dout1 = {24'b0, dout[7:0]};
    else if(cuif.LDsel == 2'd2)
      dout1 = {16'b0, dout[15:0]};
    else
      dout1 = dout;

    if(cuif.JumpReg)
      rfif.wdat = pcif.nxt_pc;
    else
      rfif.wdat = dout1;
    if((dpif.ihit == 1) || (dpif.dhit == 1))
      rfif.WEN = cuif.RegWr;
    else
      rfif.WEN = 1'b0;

  end

  // Extender
  assign exif.ExtOp = cuif.ExtOp;
  assign exif.imm = dpif.imemload[15:0];

  // ALU
  assign aluif.aluop = cuif.ALUCtr;
  always_comb begin : ALU_MUX
    if(cuif.LUI)
      aluif.porta = 32'd16;
    else
      aluif.porta = rfif.rdat1; // rs
    if(cuif.ALUSrc)
      aluif.portb = exif.ext_imm;
    else
      aluif.portb = rfif.rdat2; // rt
  end

  // Control Unit
  assign cuif.Equal = aluif.portout;
  assign cuif.zero = aluif.zero;
  assign cuif.negative = aluif.negative;
  assign cuif.overflow = cuif.overflow;
  assign cuif.opcode = opcode_t'(dpif.imemload[31:26]);
  assign cuif.funct = funct_t'(dpif.imemload[5:0]);
  assign cuif.shamt = dpif.imemload[10:6];
  //assign cuif.flushed = dpif.flushed;

  // Request Unit
  assign ruif.dhit = dpif.dhit;
  assign ruif.ihit = dpif.ihit;
  assign ruif.dread = cuif.dread;
  assign ruif.dwrite = cuif.dwrite;
  assign ruif.iread = cuif.iread;

  // Data path output
  assign dpif.datomic = ruif.datomic;
  assign dpif.halt = cuif.halt;
  assign dpif.imemREN = ruif.imemREN; // Update
  assign dpif.imemaddr = pcif.pcaddr;
  assign dpif.dmemREN = ruif.dmemREN;
  assign dpif.dmemWEN = ruif.dmemWEN;
  assign dpif.dmemaddr = aluif.portout;
  always_comb begin : DP_MUX
    dpif.dmemstore = rfif.rdat2;
    if(cuif.SVsel == 2'd0)
      dpif.dmemstore = rfif.rdat2;
    else if(cuif.SVsel == 2'd1)
      dpif.dmemstore = {24'b0, rfif.rdat2[7:0]};
    else if(cuif.SVsel == 2'd2)
      dpif.dmemstore = {16'b0, rfif.rdat2[15:0]};
  end
endmodule
