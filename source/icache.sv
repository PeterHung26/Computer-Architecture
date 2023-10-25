`include "caches_if.vh"
`include "cpu_types_pkg.vh"

module icache (
	input logic CLK, nRST,
	datapath_cache_if dcif,
	caches_if cif   
);
import cpu_types_pkg::*;
/*
icache_frame iframes[15:0];
logic [25:0] tag;
logic [3:0]  idx;
logic imiss;

assign tag = dcif.imemaddr[31:6];
assign idx = dcif.imemaddr[5:2];


always_ff @(posedge CLK, negedge nRST) begin: ICACHE_UPDATE
    if(~nRST) begin
        for(int i=0;i<16;i++) begin
            iframes[i].tag      <= '0;
            iframes[i].valid    <= '0;
            iframes[i].data     <= '0;
        end
    end
    else begin
        if(~cif.iwait) begin
            iframes[idx].tag      <= tag;
            iframes[idx].valid    <= 1;
            iframes[idx].data     <= cif.iload;
        end
    end
end

always_comb begin: IHIT_LOGIC
    imiss           = '0; 
    dcif.ihit       = '0;
    dcif.imemload   = '0;
    cif.iREN        = '0;
    cif.iaddr       = '0;


    if(dcif.imemREN  && ~dcif.dmemREN && ~dcif.dmemWEN)  begin
        if(tag == iframes[idx].tag && iframes[idx].valid) 
        begin : IHIT
            dcif.ihit = 1;
            dcif.imemload = iframes[idx].data;
        end
        else 
        begin : IMISS       
            imiss            = 1;
            cif.iREN         =  dcif.imemREN;
            cif.iaddr        =  dcif.imemaddr;
            
            dcif.ihit        = ~cif.iwait;               
            dcif.imemload    = cif.iload;
        end
    end 
end
*/
typedef enum logic [1:0] {
    IDLE, REPLACE
} s_t; 


icache_frame iframes[15:0];
logic [25:0] tag;
logic [3:0]  idx;
logic imiss;
s_t state, state_nxt;

assign tag = dcif.imemaddr[31:6];
assign idx = dcif.imemaddr[5:2];

always_ff @(posedge CLK, negedge nRST) begin: ICACHE_UPDATE
    if(~nRST) begin
        state <= IDLE;
        for(int i=0;i<16;i++) begin
            iframes[i].tag      <= '0;
            iframes[i].valid    <= '0;
            iframes[i].data     <= '0;
        end
    end
    else begin
        state <= state_nxt;
        if(~cif.iwait) begin
            iframes[idx].tag      <= tag;
            iframes[idx].valid    <= 1;
            iframes[idx].data     <= cif.iload;
        end
    end
end

always_comb begin: IHIT_LOGIC
    dcif.ihit       = '0;
    dcif.imemload   = '0;
    cif.iREN        = '0;
    cif.iaddr       = '0;
    state_nxt       = state;

    case(state)
    IDLE: begin
        if(dcif.imemREN)  begin
            if(tag == iframes[idx].tag && iframes[idx].valid) 
            begin : IHIT
                state_nxt = IDLE;
                dcif.ihit = 1;
                dcif.imemload = iframes[idx].data;
            end
            else 
            begin : IMISS       
                state_nxt = REPLACE;          
            end
        end
    end

    REPLACE: begin
        cif.iREN         =  dcif.imemREN;
        cif.iaddr        =  dcif.imemaddr; 
        if(~cif.iwait) begin
            state_nxt = IDLE;
            dcif.ihit        = 1;               
            dcif.imemload    = cif.iload;
        end
        else begin
            state_nxt = REPLACE;
              
        end
    end
    endcase
end


endmodule


