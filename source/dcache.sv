`include "caches_if.vh"
`include "cpu_types_pkg.vh"
`include "cache_control_if.vh"
module dcache (
	input logic CLK, nRST,
	datapath_cache_if dcif,
	caches_if cif   
);
import cpu_types_pkg::*;

/*
  assign dcif.flushed = dcif.halt;
  assign dcif.dhit = (dcif.dmemREN|dcif.dmemWEN) ? ~cif.dwait : 0;
  assign dcif.dmemload = cif.dload;
  assign cif.dREN = dcif.dmemREN;
  assign cif.dWEN = dcif.dmemWEN;
  assign cif.dstore = dcif.dmemstore;
  assign cif.daddr = dcif.dmemaddr;
*/

typedef enum logic [3:0] {
    IDLE, LOAD0, LOAD1, WB0, WB1, FLUSH0, FLUSH1, COUNT, HALT, CHECK_DIRTY, STORE_CNT, IDLE_HIT
} s_t; 
dcache_frame dframes[7:0][1:0];


logic valid_nxt     , dirty_nxt;      logic [DTAG_W - 1:0] tag_nxt;       word_t data0_nxt      , data1_nxt ; word_t [1:0] data_nxt;
//logic valid_nxt[1:0], dirty_nxt[1:0]; logic [DTAG_W - 1:0] tag_nxt[1:0] ; word_t data0_nxt[1:0] , data1_nxt[1:0] ;

logic valid, dirty;
logic [DTAG_W - 1:0] tag;
word_t [1:0] data;
word_t cnt, cnt_nxt;
logic [4:0] set, set_nxt;
logic dmiss;
logic offset;
logic [2:0] idx;
logic lru[7:0];
logic lru_nxt;
logic way;

int i,j;
s_t state, state_nxt;

assign tag          = dcif.dmemaddr[31:6];
assign idx          = dcif.dmemaddr[5:3];
assign offset       = dcif.dmemaddr[2];
assign dcif.flushed = (state == HALT);

always_ff @ (posedge CLK, negedge nRST) begin
    if(!nRST) begin
        state <= IDLE;
     	set   <= '0;
		cnt   <= '0;
        for(i = 0;i<8;i++) begin lru[i] <= 0; end;
        for(i = 0;i<8;i++) begin            
            for(j = 0; j<2;j++) begin
                dframes[i][j].valid     <= '0;
                dframes[i][j].dirty     <= '0;            
                dframes[i][j].tag       <= '0;
                dframes[i][j].data[0]   <= '0;
                dframes[i][j].data[1]   <= '0;                
            end
        end        
    end
    else begin
        state    <= state_nxt;
        lru[idx] <= lru_nxt;
		set      <= set_nxt;
		cnt      <= cnt_nxt;
        dframes[idx][way].valid <= valid_nxt;
        dframes[idx][way].dirty <= dirty_nxt;
        dframes[idx][way].tag   <= tag_nxt;
        dframes[idx][way].data  <= data_nxt;        
    end
end

always_comb begin
    state_nxt     = state;
    dmiss         = '0;
	dcif.dhit     = '0;
	dcif.dmemload = '0;
	cif.dREN      = '0;
	cif.dWEN      = '0;
	cif.daddr     = '0;
	cif.dstore    = '0;
    way           = lru[idx];
    
    lru_nxt       = lru[idx];
	cnt_nxt       = cnt;
    set_nxt       = set;


    valid_nxt     = dframes[idx][way].valid;
    dirty_nxt     = dframes[idx][way].dirty;
    tag_nxt       = dframes[idx][way].tag;
    data_nxt      = dframes[idx][way].data;
    


    case(state)
    IDLE, IDLE_HIT: begin
		if (dcif.halt) begin state_nxt = CHECK_DIRTY; end
	    else if(dcif.dmemREN  &&  dframes[idx][0].tag == tag  &&  dframes[idx][0].valid) begin
            state_nxt         = IDLE_HIT;
            dcif.dhit         = 1;
            lru_nxt           = 1;
            dcif.dmemload     = dframes[idx][0].data[offset];
            cnt_nxt           = cnt + 1;
            
        end
        else if(dcif.dmemREN  &&  dframes[idx][1].tag == tag  &&  dframes[idx][1].valid) begin
            state_nxt         = IDLE_HIT;
            dcif.dhit         = 1;
            lru_nxt           = 0;
            dcif.dmemload     = dframes[idx][1].data[offset];
            cnt_nxt           = cnt + 1;            
        end 
        else if(dcif.dmemREN) begin
            state_nxt         = dframes[idx][lru[idx]].dirty? WB0:LOAD0;
            cnt_nxt           = cnt - 1;
			
				
        end
        else if(dcif.dmemWEN  &&  dframes[idx][0].tag == tag) begin
            state_nxt         = IDLE_HIT;
            dcif.dhit         = 1;
            lru_nxt           = 1;              
            way               = 0;
            dirty_nxt         = 1;           
            tag_nxt           = dframes[idx][0].tag;
            valid_nxt         = dframes[idx][way].valid;
            data_nxt[offset]  = dcif.dmemstore;
            data_nxt[~offset] = dframes[idx][way].data[~offset];
            cnt_nxt           = cnt + 1;
        end 
        else if(dcif.dmemWEN  &&  dframes[idx][1].tag == tag) begin
            state_nxt         = IDLE_HIT;
            dcif.dhit         = 1;
            lru_nxt           = 0;              
            way               = 1;
            dirty_nxt         = 1;        
            valid_nxt         = dframes[idx][way].valid;
            tag_nxt           = dframes[idx][way].tag;
            data_nxt[offset]  = dcif.dmemstore;
            data_nxt[~offset] = dframes[idx][way].data[~offset];
            cnt_nxt = cnt + 1;
        end 
        else if(dcif.dmemWEN) begin
            state_nxt         = dframes[idx][lru[idx]].dirty? WB0:LOAD0;
            cnt_nxt           = cnt - 1;
            
        end
    end

    LOAD0: begin
        cif.dREN      = 1;
        cif.daddr     = {dcif.dmemaddr[31:3], 3'b000};
        way           = lru[idx];
        data_nxt[0]   = cif.dload;
        data_nxt[1]   = dframes[idx][way].data[1];
        if (~cif.dwait) begin
            state_nxt = LOAD1;            
        end
    end

    LOAD1: begin
        cif.dREN      = 1;
        cif.daddr     = {dcif.dmemaddr[31:3], 3'b100};
        way           = lru[idx];
        dirty_nxt     = 0;
        valid_nxt     = 1;
        tag_nxt       = tag;
        data_nxt[0]   = dframes[idx][way].data[0];
        data_nxt[1]   = cif.dload;       
        if (~cif.dwait) begin
            state_nxt = IDLE;
        end
    end
       
    WB0: begin
        cif.dWEN      = 1;
        cif.daddr     = {dframes[idx][lru[idx]].tag, idx,3'b000};
        cif.dstore    = dframes[idx][lru[idx]].data[0];
        if(~cif.dwait) begin
            state_nxt = WB1;
        end           
    end

    WB1: begin
        cif.dWEN      = 1;
        cif.daddr     = {dframes[idx][lru[idx]].tag, idx,3'b100};
        cif.dstore    = dframes[idx][lru[idx]].data[1];
        if(~cif.dwait) begin
            state_nxt = LOAD0;
        end           
    end

    FLUSH0: begin
		cif.dWEN      = 1;
		cif.daddr     = {dframes[set[2:0]][set[3]].tag, set[2:0], 3'b000};
		cif.dstore    = dframes[set[2:0]][set[3]].data[0];	
        if (~cif.dwait) begin
            state_nxt = FLUSH1;
        end
    end

	FLUSH1 : begin
		cif.dWEN      = 1;
		cif.daddr     = {dframes[set[2:0]][set[3]].tag, set[2:0], 3'b100};
		cif.dstore    = dframes[set[2:0]][set[3]].data[1];	
        if (~cif.dwait) begin 
            state_nxt = CHECK_DIRTY;
            set_nxt   = set + 1;     
        end
		end

    CHECK_DIRTY: begin
        if (set < 8 && dframes[set[2:0]][0].dirty) begin
			state_nxt = FLUSH0;
		end 
        else if(set < 16 && dframes[set[2:0]][1].dirty) begin
			state_nxt = FLUSH0;
        end 
        else if(set == 5'd16) begin
            state_nxt = HALT;
            //state_nxt = STORE_CNT;
        end 
        else begin
            state_nxt = CHECK_DIRTY;
            set_nxt   = set + 1; 
        end
        
    end
        
    STORE_CNT: begin
        cif.dWEN      = 1;
        cif.daddr     = 32'h3100;
		cif.dstore    = cnt; 

        if (~cif.dwait) begin
            state_nxt = HALT;
        end
    end
    endcase


end


endmodule