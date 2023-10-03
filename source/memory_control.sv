/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input logic CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 1;
  always_comb begin : ENABLE_ADDRESS_AND_LOAD
    ccif.ramWEN = 1'b0;
    ccif.ramREN = 1'b0;
    ccif.ramaddr = '0;
    ccif.ramstore = 1'b0;
    ccif.iload = '0;
    ccif.dload = '0;
    if(ccif.dWEN) begin //write data has first priority
      ccif.ramWEN = 1'b1;
      ccif.ramaddr = ccif.daddr;
      ccif.ramstore = ccif.dstore;
    end
    else if(ccif.dREN) begin // read data has second priority
      ccif.ramREN = 1'b1;
      ccif.ramaddr = ccif.daddr;
      ccif.dload = ccif.ramload;
    end
    else if(ccif.iREN) begin // read instruction has third priority
      ccif.ramREN = 1'b1;
      ccif.ramaddr = ccif.iaddr;
      ccif.iload = ccif.ramload;
    end
  end

  always_comb begin : IWAIT_AND_DWAIT
    ccif.dwait = 1'b1;
    ccif.iwait = 1'b1;
    if(ccif.ramstate == FREE) begin
      ccif.dwait = 1'b1;
      ccif.iwait = 1'b1;
    end
    else if(ccif.ramstate == BUSY) begin
      ccif.dwait = 1'b1;
      ccif.iwait = 1'b1;
    end
    else if(ccif.ramstate == ACCESS) begin
      if(ccif.dWEN || ccif.dREN) begin
        ccif.dwait = 1'b0;
        ccif.iwait = 1'b1;
      end
      else begin
        ccif.dwait = 1'b1;
        ccif.iwait = 1'b0;
      end
    end
    else if(ccif.ramstate == ERROR)begin
      ccif.dwait = 1'b1;
      ccif.iwait = 1'b1;
    end
  end
  
endmodule
