/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
  The final piece is the memory_control, 
  this component talks to ram and relays that information to the datapath. 
  This component needs to arbitrate the ram between instruction fetch and the load/store of data 
  as there is only one port on the ram only one of those actions can take place. 
  It will give priority to the data operations. 
  It is the job of the memory_control to ensure smooth utilization of ram. 
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 1;
  

  // inputs cc <- cache
  // iREN, dREN, dWEN, dstore, iaddr, daddr,
  // inputs cc <- ram
  // ramload(word_t), ramstate,
  // ramstate
  // FREE,    BUSY,    ACCESS,    ERROR
  
  always_comb begin
    ccif.dwait = 1'b1;
    ccif.iwait = 1'b1;
    if(ccif.ramstate == ACCESS) begin
      if(ccif.dWEN || ccif.dREN) ccif.dwait = '0;
      else if(ccif.iREN) ccif.iwait = '0;
    end
  end


  // outputs cc -> cache 
  // iwait, dwait, iload, dload,
  //assign ccif.iwait  = ()
  //assign ccif.dwait  = ()
  assign ccif.iload  = ccif.ramload; //(ccif.iREN) ? ccif.ramload; : '0;
  assign ccif.dload  = ccif.ramload; //(ccif.dREN) ? ccif.ramload; : '0;

  // outputs cc -> ram
  // ramstore(word_t), ramaddr, ramWEN, ramREN,
  // Data first
  assign ccif.ramstore  = ccif.dstore; // ?
  assign ccif.ramaddr   = (ccif.dWEN || ccif.dREN) ? ccif.daddr : ccif.iaddr; //ccif.iREN ? ccif.iaddr : '0;
  assign ccif.ramWEN    = ccif.dWEN;
  assign ccif.ramREN    = (ccif.dREN || ccif.iREN) && ~ccif.dWEN;

endmodule

