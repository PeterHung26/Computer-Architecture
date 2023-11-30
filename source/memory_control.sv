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
  typedef enum logic [3:0] {IDLE, SNOOP, BUSRD1, BUSRD2, WB1, WAIT_WB1, WB2, BUSRDX1, BUSRDX2, RAMRD1, WAIT_RAMRD1, RAMRD2, RAMWR1, WAIT_RAMWR1, RAMWR2, IFETCH} state_t;
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

  // Latched signal
  logic[1:0] l_dREN;
  logic[1:0] l_dWEN;
  word_t [1:0] l_dstore;
  word_t [1:0] l_daddr;
  ramstate_t l_ramstate;
  word_t l_ramload;
  logic[1:0] l_iREN;
  word_t [1:0] l_iaddr;
  // logic[1:0] l_ccwrite;
  // logic[1:0] l_cctrans;
  //Signal in RAMRD2 and WB2 and RAMWR2 to tell memory controller stop latching
  logic mem_recv;
  // Signal in WAIT_WB1 and WAIT_RAMRD1 and WAIT_RAMWR1 to tell memory controller stop latching ramstate and ramload
  logic wait_clean;

  always_ff @( posedge CLK, negedge nRST ) begin
    if(!nRST) begin
      state <= IDLE;
      snooper <= 1'b0;
      snoopied <= 1'b0;
      grant <= 0;
      //Latched Signal
      l_dREN <= '0;
      l_dWEN <= '0;
      l_dstore <= '0;
      l_daddr <= '0;
      l_ramload <= '0;
      l_ramstate <= FREE;
      l_iREN <= '0;
      l_iaddr <= '0;
    end
    else begin
      state <= nxt_state;
      snooper <= nxt_snooper;
      snoopied <= nxt_snoopied;
      grant <= nxt_grant;
      //Latched Signal
      if(mem_recv) begin
        l_dREN <= '0;
        l_dWEN <= '0;
        l_dstore <= '0;
        l_daddr <= '0;
        l_iREN <= '0;
        l_iaddr <= '0;
      end
      else begin
        l_dREN <= ccif.dREN;
        l_dWEN <= ccif.dWEN;
        l_dstore <= ccif.dstore;
        l_daddr <= ccif.daddr;
        l_iREN <= ccif.iREN;
        l_iaddr <= ccif.iaddr;
      end
      if(wait_clean) begin
        l_ramload <= '0;
        l_ramstate <= FREE;
      end
      else begin
        l_ramload <= ccif.ramload;
        l_ramstate <= ccif.ramstate;
      end
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
        if(l_dWEN[0] || l_dWEN[1])
          nxt_state = RAMWR1;
        else if(l_dREN[0] || l_dREN[1])
          nxt_state = SNOOP;
        else if(l_iREN[0] || l_iREN[1])
          nxt_state = IFETCH;
      end
      SNOOP: begin
        if((l_dREN[0] && ccif.cctrans[0] && !ccif.ccwrite[0]) || (l_dREN[1] && ccif.cctrans[1] && !ccif.ccwrite[1]))
          nxt_state = BUSRD1;
        else if((l_dREN[0] && ccif.cctrans[0] && ccif.ccwrite[0]) || (l_dREN[1] && ccif.cctrans[1] && ccif.ccwrite[1]))
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
        if(l_ramstate == ACCESS)
          nxt_state = WAIT_WB1;
        else
          nxt_state = WB1;
      end
      WAIT_WB1: begin // A state to wait for dstore latching
        nxt_state = WB2;
      end
      WB2: begin
        if(l_ramstate == ACCESS)
          nxt_state = IDLE;
        else
          nxt_state = WB2;
      end
      RAMRD1: begin
        if(l_ramstate == ACCESS)
          nxt_state = WAIT_RAMRD1;
        else
          nxt_state = RAMRD1;
      end
      WAIT_RAMRD1: begin
        nxt_state = RAMRD2;
      end
      RAMRD2: begin
        if(l_ramstate == ACCESS)
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
        if(l_ramstate == ACCESS)
          nxt_state = WAIT_RAMWR1;
        else
          nxt_state = RAMWR1;
      end
      WAIT_RAMWR1: begin
        nxt_state = RAMWR2;
      end
      RAMWR2: begin
        if(l_ramstate == ACCESS)
          nxt_state = IDLE;
        else
          nxt_state = RAMWR2;
      end
      IFETCH: begin
        if(l_ramstate == ACCESS)
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
    mem_recv = 1'b0;
    wait_clean = 1'b0;
    casez (state)
      IDLE: begin
        if(l_dWEN[0] || l_dWEN[1]) begin
          if(l_dWEN[grant])
            nxt_snooper = grant;
          else
            nxt_snooper = !grant;
        end
        else if((l_dREN[0] && ccif.cctrans[0] && !ccif.ccwrite[0]) || (l_dREN[1] && ccif.cctrans[1] && !ccif.ccwrite[1])) begin
          if(l_dREN[grant] && ccif.cctrans[grant] && !ccif.ccwrite[grant]) begin
            nxt_snooper = grant;
            nxt_snoopied = !grant;
          end
          else begin
            nxt_snooper = !grant;
            nxt_snoopied = grant;
          end
        end
        else if((l_dREN[0] && ccif.cctrans[0] && ccif.ccwrite[0]) || (l_dREN[1] && ccif.cctrans[1] && ccif.ccwrite[1])) begin
          if(l_dREN[grant] && ccif.cctrans[grant] && ccif.ccwrite[grant]) begin
            nxt_snooper = grant;
            nxt_snoopied = !grant;
          end
          else begin
            nxt_snooper = !grant;
            nxt_snoopied = grant;
          end
        end
        else if(l_iREN[0] || l_iREN[1]) begin
          if(l_iREN[grant])
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
        ccif.ccsnoopaddr[snoopied] = l_daddr[snooper];
      end
      BUSRD2: begin
        ccif.ccwait[snoopied] = 1'b1;
        ccif.ccsnoopaddr[snoopied] = l_daddr[snooper];
      end
      WB1: begin
        ccif.ccwait[snoopied] = 1'b1;
        ccif.ccsnoopaddr[snoopied] = {l_daddr[snooper][31:3], 3'b000}; // First word
        ccif.dload[snooper] = l_dstore[snoopied];
        ccif.ramstore = l_dstore[snoopied];
        ccif.ramaddr = {l_daddr[snooper][31:3], 3'b000};
        ccif.ramWEN = 1'b1;
        if(l_ramstate == ACCESS) begin
          ccif.dwait[snooper] = 1'b0; // Tell the snooper data are ready
          ccif.dwait[snoopied] = 1'b0; // Tell the snoopied data are ready
        end
      end
      WAIT_WB1: begin
        ccif.ccwait[snoopied] = 1'b1;
        ccif.ccsnoopaddr[snoopied] = {l_daddr[snooper][31:3], 3'b100};
        wait_clean = 1'b1;
      end
      WB2: begin
        ccif.ccwait[snoopied] = 1'b1;
        ccif.ccsnoopaddr[snoopied] = {l_daddr[snooper][31:3], 3'b100}; // Second word
        ccif.dload[snooper] = l_dstore[snoopied];
        ccif.ramstore = l_dstore[snoopied];
        ccif.ramaddr = {l_daddr[snooper][31:3], 3'b100};
        ccif.ramWEN = 1'b1;
        if(l_ramstate == ACCESS) begin
          ccif.dwait[snooper] = 1'b0; // Tell the snooper data are ready
          ccif.dwait[snoopied] = 1'b0; // Tell the snoopied data are ready
          if(snooper == grant)
            nxt_grant = !grant;
          else
            nxt_grant = grant;
          mem_recv = 1'b1;
          wait_clean = 1'b1;
        end
      end
      RAMRD1: begin
        ccif.ramREN = 1'b1;
        ccif.ramaddr = {l_daddr[snooper][31:3], 3'b000};
        ccif.ccsnoopaddr[snoopied] = l_daddr[snooper]; // Send address for other cahce to S -> I
        ccif.dload[snooper] = l_ramload;
        if(l_ramstate == ACCESS)
          ccif.dwait[snooper] = 1'b0; // Tell the snooper data are ready
      end
      WAIT_RAMRD1:begin
        wait_clean = 1'b1;
        ccif.ccsnoopaddr[snoopied] = l_daddr[snooper]; // Send address for other cahce to S -> I
      end
      RAMRD2: begin
        ccif.ramREN = 1'b1;
        ccif.ramaddr = {l_daddr[snooper][31:3], 3'b100};
        ccif.ccsnoopaddr[snoopied] = l_daddr[snooper]; // Send address for other cahce to S -> I
        ccif.dload[snooper] = l_ramload;
        if(l_ramstate == ACCESS) begin
          ccif.dwait[snooper] = 1'b0; // Tell the snooper data are ready
          if(snooper == grant)
            nxt_grant = !grant;
          else
            nxt_grant = grant;
          mem_recv = 1'b1;
          wait_clean = 1'b1;
        end 
      end
      BUSRDX1: begin
        ccif.ccwait[snoopied] = 1'b1;
        ccif.ccsnoopaddr[snoopied] = l_daddr[snooper];
        ccif.ccinv[snoopied] = 1'b1;
      end
      BUSRDX2: begin
        ccif.ccwait[snoopied] = 1'b1;
        ccif.ccsnoopaddr[snoopied] = l_daddr[snooper];
        ccif.ccinv[snoopied] = 1'b1;
      end
      RAMWR1: begin
        ccif.ramWEN = 1'b1;
        ccif.ramaddr = {l_daddr[snooper][31:3], 3'b000};
        ccif.ramstore = l_dstore[snooper];
        if(l_ramstate == ACCESS)
          ccif.dwait[snooper] = 1'b0;
      end
      WAIT_WB1: begin
        wait_clean = 1'b1;
      end
      RAMWR2: begin
        ccif.ramWEN = 1'b1;
        ccif.ramaddr = {ccif.daddr[snooper][31:3], 3'b100};
        ccif.ramstore = ccif.dstore[snooper];
        if(l_ramstate == ACCESS) begin
          ccif.dwait[snooper] = 1'b0;
          if(snooper == grant)
            nxt_grant = !grant;
          else
            nxt_grant = grant;
          mem_recv = 1'b1;
          wait_clean = 1'b1;
        end
      end
      IFETCH: begin
        ccif.ramREN = 1'b1;
        ccif.ramaddr = {l_iaddr[snooper]};
        ccif.iload[snooper] = l_ramload;
        if(l_ramstate == ACCESS) begin
          ccif.iwait[snooper] = 1'b0;
          if(snooper == grant)
            nxt_grant = !grant;
          else
            nxt_grant = grant;
          wait_clean = 1'b1;
          mem_recv = 1'b1;
        end
      end 
    endcase
  end
  
  
endmodule
