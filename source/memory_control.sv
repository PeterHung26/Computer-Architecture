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
  typedef enum logic [3:0] {IDLE, SNOOP, BUSRD1, BUSRD2, WB1, WB2, BUSRDX1, BUSRDX2, RAMRD1, RAMRD2, RAMWR1, RAMWR2, IFETCH} state_t;
  // number of cpus for cc
  parameter CPUS = 2;
  
  state_t nxt_state;
  state_t state;
  logic snooper;
  logic snoopied;
  logic nxt_snooper;
  logic nxt_snoopied;
  logic [25:0] snooptag;
  logic [2:0] snoopindex;
  logic grant; // Arbitration signal
  logic nxt_grant;
  //assign snooptag = ccif.snoopaddr[31:6];
  //assign snoopindex = ccif.snoopaddr[5:3];
  always_ff @( posedge CLK, negedge nRST ) begin
    if(!nRST) begin
      state <= IDLE;
      snooper <= 1'b0;
      snoopied <= 1'b0;
      grant <= 0;
    end
    else begin
      state <= nxt_state;
      snooper <= nxt_snooper;
      snoopied <= nxt_snoopied;
      grant <= nxt_grant;
    end
  end

  always_comb begin : NXT_STATE_LOGIC
    nxt_state = state;
    casez (state)
      IDLE: begin
        /*if(ccif.dWEN[0] || ccif.dWEN[1])
          nxt_state = RAMWR1;
        else if((ccif.dREN[0] && ccif.cctrans[0] && !ccif.ccwrite[0]) || (ccif.dREN[1] && ccif.cctrans[1] && !ccif.ccwrite[1]))
          nxt_state = BUSRD;
        else if((ccif.dREN[0] && ccif.cctrans[0] && ccif.ccwrite[0]) || (ccif.dREN[1] && ccif.cctrans[1] && ccif.ccwrite[1]))
          nxt_state = BUSRDX;
        else if(ccif.iREN[0] || ccif.iREN[1])
          nxt_state = IFETCH;*/
        if(ccif.dWEN[0] || ccif.dWEN[1])
          nxt_state = RAMWR1;
        else if(ccif.dREN[0] || ccif.dREN[1])
          nxt_state = SNOOP;
        else if(ccif.iREN[0] || ccif.iREN[1])
          nxt_state = IFETCH;
      end
      SNOOP: begin
        if((ccif.dREN[0] && ccif.cctrans[0] && !ccif.ccwrite[0]) || (ccif.dREN[1] && ccif.cctrans[1] && !ccif.ccwrite[1]))
          nxt_state = BUSRD1;
        else if((ccif.dREN[0] && ccif.cctrans[0] && ccif.ccwrite[0]) || (ccif.dREN[1] && ccif.cctrans[1] && ccif.ccwrite[1]))
          nxt_state = BUSRDX1;
      end
      BUSRD1: begin
        nxt_state = BUSRD2;
      end
      BUSRDX1: begin
        nxt_state = BUSRDX2;
      end
      BUSRD2: begin
        if(snoopied) begin
          if(ccif.cctrans[snoopied])
            nxt_state = WB1;
          else
            nxt_state = RAMRD1;
        end
        else begin
          if(ccif.cctrans[snoopied])
            nxt_state = WB1;
          else
            nxt_state = RAMRD1;
        end
      end
      WB1: begin
        if(ccif.ramstate == ACCESS)
          nxt_state = WB2;
        else
          nxt_state = WB1;
      end
      WB2: begin
        if(ccif.ramstate == ACCESS)
          nxt_state = IDLE;
        else
          nxt_state = WB2;
      end
      RAMRD1: begin
        if(ccif.ramstate == ACCESS)
          nxt_state = RAMRD2;
        else
          nxt_state = RAMRD1;
      end
      RAMRD2: begin
        if(ccif.ramstate == ACCESS)
          nxt_state = IDLE;
        else
          nxt_state = RAMRD2;
      end
      BUSRDX2: begin
        if(snoopied) begin
          if(ccif.cctrans[snoopied])
            nxt_state = WB1;
          else
            nxt_state = RAMRD1;
        end
        else begin
          if(ccif.cctrans[snoopied])
            nxt_state = WB1;
          else
            nxt_state = RAMRD1;
        end
      end
      RAMWR1: begin
        if(ccif.ramstate == ACCESS)
          nxt_state = RAMWR2;
        else
          nxt_state = RAMWR1;
      end
      RAMWR2: begin
        if(ccif.ramstate == ACCESS)
          nxt_state = IDLE;
        else
          nxt_state = RAMWR2;
      end
      IFETCH: begin
        if(ccif.ramstate == ACCESS)
          nxt_state = IDLE;
        else
          nxt_state = IFETCH;
      end 
      default: 
        nxt_state = state;
    endcase
  end

  always_comb begin : OUTPUT_LOGIC
    nxt_snooper = snooper;
    nxt_snoopied = snoopied;
    ccif.ccwait[0] = '0;
    ccif.ccwait[1] = '0;
    ccif.ccinv[0] = '0;
    ccif.ccinv[1] = '0;
    ccif.ccsnoopaddr[0] = '0;
    ccif.ccsnoopaddr[1] = '0;
    ccif.iwait[0] = 1'b1;
    ccif.iwait[1] = 1'b1;
    ccif.dwait[0] = 1'b1;
    ccif.dwait[1] = 1'b1;
    ccif.iload[0] = '0;
    ccif.iload[1] = '0;
    ccif.dload[0] = '0;
    ccif.dload[1] = '0;
    ccif.ramstore = '0;
    ccif.ramaddr = '0;
    ccif.ramWEN = '0;
    ccif.ramREN = '0;
    nxt_grant = grant;
    casez (state)
      IDLE: begin
        if(ccif.dWEN[0] || ccif.dWEN[1]) begin
          if(ccif.dWEN[grant])
            nxt_snooper = grant;
          else
            nxt_snooper = !grant;
        end
        else if((ccif.dREN[0] && ccif.cctrans[0] && !ccif.ccwrite[0]) || (ccif.dREN[1] && ccif.cctrans[1] && !ccif.ccwrite[1])) begin
          if(ccif.dREN[grant] && ccif.cctrans[grant] && !ccif.ccwrite[grant]) begin
            nxt_snooper = grant;
            nxt_snoopied = !grant;
          end
          else begin
            nxt_snooper = !grant;
            nxt_snoopied = grant;
          end
        end
        else if((ccif.dREN[0] && ccif.cctrans[0] && ccif.ccwrite[0]) || (ccif.dREN[1] && ccif.cctrans[1] && ccif.ccwrite[1])) begin
          if(ccif.dREN[grant] && ccif.cctrans[grant] && ccif.ccwrite[grant]) begin
            nxt_snooper = grant;
            nxt_snoopied = !grant;
          end
          else begin
            nxt_snooper = !grant;
            nxt_snoopied = grant;
          end
        end
        else if(ccif.iREN[0] || ccif.iREN[1]) begin
          if(ccif.iREN[grant])
            nxt_snooper = grant;
          else
            nxt_snooper = !grant;
        end
      end
      SNOOP: begin
        ccif.ccwait[snoopied] = 1'b1;
      end
      BUSRD1: begin
        ccif.ccwait[snoopied] = 1'b1;
        ccif.ccsnoopaddr[snoopied] = ccif.daddr[snooper];
      end
      BUSRD2: begin
        ccif.ccwait[snoopied] = 1'b1;
        ccif.ccsnoopaddr[snoopied] = ccif.daddr[snooper];
      end
      WB1: begin
        ccif.ccwait[snoopied] = 1'b1;
        ccif.ccsnoopaddr[snoopied] = {ccif.daddr[snooper][31:3], 3'b000}; // First word
        ccif.dload[snooper] = ccif.dstore[snoopied];
        ccif.ramstore = ccif.dstore[snoopied];
        ccif.ramaddr = {ccif.daddr[snooper][31:3], 3'b000};
        ccif.ramWEN = 1'b1;
        if(ccif.ramstate == ACCESS) begin
          ccif.dwait[snooper] = 1'b0; // Tell the snooper data are ready
          ccif.dwait[snoopied] = 1'b0; // Tell the snoopied data are ready
        end
      end
      WB2: begin
        ccif.ccwait[snoopied] = 1'b1;
        ccif.ccsnoopaddr[snoopied] = {ccif.daddr[snooper][31:3], 3'b100}; // Second word
        ccif.dload[snooper] = ccif.dstore[snoopied];
        ccif.ramstore = ccif.dstore[snoopied];
        ccif.ramaddr = {ccif.daddr[snooper][31:3], 3'b100};
        ccif.ramWEN = 1'b1;
        if(ccif.ramstate == ACCESS) begin
          ccif.dwait[snooper] = 1'b0; // Tell the snooper data are ready
          ccif.dwait[snoopied] = 1'b0; // Tell the snoopied data are ready
          if(snooper == grant)
            nxt_grant = !grant;
          else
            nxt_grant = grant;
        end
          
      end
      RAMRD1: begin
        ccif.ramREN = 1'b1;
        ccif.ramaddr = {ccif.daddr[snooper][31:3], 3'b000};
        ccif.ccsnoopaddr[snoopied] = ccif.daddr[snooper]; // Send address for other cahce to S -> I
        ccif.dload[snooper] = ccif.ramload;
        if(ccif.ramstate == ACCESS)
          ccif.dwait[snooper] = 1'b0; // Tell the snooper data are ready
      end
      RAMRD2: begin
        ccif.ramREN = 1'b1;
        ccif.ramaddr = {ccif.daddr[snooper][31:3], 3'b100};
        ccif.ccsnoopaddr[snoopied] = ccif.daddr[snooper]; // Send address for other cahce to S -> I
        ccif.dload[snooper] = ccif.ramload;
        if(ccif.ramstate == ACCESS) begin
          ccif.dwait[snooper] = 1'b0; // Tell the snooper data are ready
          if(snooper == grant)
            nxt_grant = !grant;
          else
            nxt_grant = grant;
        end 
      end
      BUSRDX1: begin
        ccif.ccwait[snoopied] = 1'b1;
        ccif.ccsnoopaddr[snoopied] = ccif.daddr[snooper];
        ccif.ccinv[snoopied] = 1'b1;
      end
      BUSRDX2: begin
        ccif.ccwait[snoopied] = 1'b1;
        ccif.ccsnoopaddr[snoopied] = ccif.daddr[snooper];
        ccif.ccinv[snoopied] = 1'b1;
      end
      RAMWR1: begin
        ccif.ramWEN = 1'b1;
        ccif.ramaddr = {ccif.daddr[snooper][31:3], 3'b000};
        ccif.ramstore = ccif.dstore[snooper];
        if(ccif.ramstate == ACCESS)
          ccif.dwait[snooper] = 1'b0;
      end
      RAMWR2: begin
        ccif.ramWEN = 1'b1;
        ccif.ramaddr = {ccif.daddr[snooper][31:3], 3'b100};
        ccif.ramstore = ccif.dstore[snooper];
        if(ccif.ramstate == ACCESS) begin
          ccif.dwait[snooper] = 1'b0;
          if(snooper == grant)
            nxt_grant = !grant;
          else
            nxt_grant = grant;
        end
      end
      IFETCH: begin
        ccif.ramREN = 1'b1;
        ccif.ramaddr = {ccif.iaddr[snooper]};
        ccif.iload[snooper] = ccif.ramload;
        if(ccif.ramstate == ACCESS) begin
          ccif.iwait[snooper] = 1'b0;
          if(snooper == grant)
            nxt_grant = !grant;
          else
            nxt_grant = grant;
        end
      end 
    endcase
  end
  // always_comb begin : ENABLE_ADDRESS_AND_LOAD
  //   ccif.ramWEN = 1'b0;
  //   ccif.ramREN = 1'b0;
  //   ccif.ramaddr = '0;
  //   ccif.ramstore = 1'b0;
  //   ccif.iload = '0;
  //   ccif.dload = '0;
  //   if(ccif.dWEN) begin //write data has first priority
  //     ccif.ramWEN = 1'b1;
  //     ccif.ramaddr = ccif.daddr;
  //     ccif.ramstore = ccif.dstore;
  //   end
  //   else if(ccif.dREN) begin // read data has second priority
  //     ccif.ramREN = 1'b1;
  //     ccif.ramaddr = ccif.daddr;
  //     ccif.dload = ccif.ramload;
  //   end
  //   else if(ccif.iREN) begin // read instruction has third priority
  //     ccif.ramREN = 1'b1;
  //     ccif.ramaddr = ccif.iaddr;
  //     ccif.iload = ccif.ramload;
  //   end
  // end

  // always_comb begin : IWAIT_AND_DWAIT
  //   ccif.dwait = 1'b1;
  //   ccif.iwait = 1'b1;
  //   if(ccif.ramstate == FREE) begin
  //     ccif.dwait = 1'b1;
  //     ccif.iwait = 1'b1;
  //   end
  //   else if(ccif.ramstate == BUSY) begin
  //     ccif.dwait = 1'b1;
  //     ccif.iwait = 1'b1;
  //   end
  //   else if(ccif.ramstate == ACCESS) begin
  //     if(ccif.dWEN || ccif.dREN) begin
  //       ccif.dwait = 1'b0;
  //       ccif.iwait = 1'b1;
  //     end
  //     else begin
  //       ccif.dwait = 1'b1;
  //       ccif.iwait = 1'b0;
  //     end
  //   end
  //   else if(ccif.ramstate == ERROR)begin
  //     ccif.dwait = 1'b1;
  //     ccif.iwait = 1'b1;
  //   end
  // end
  
endmodule
