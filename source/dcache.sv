`include "caches_if.vh"
`include "cpu_types_pkg.vh"
`include "cache_control_if.vh"
module dcache (
	input logic CLK, nRST,
	datapath_cache_if dcif,
	caches_if cif   
);
import cpu_types_pkg::*;


  assign dcif.flushed = dcif.halt;
  assign dcif.dhit = (dcif.dmemREN|dcif.dmemWEN) ? ~cif.dwait : 0;
  assign dcif.dmemload = cif.dload;
  assign cif.dREN = dcif.dmemREN;
  assign cif.dWEN = dcif.dmemWEN;
  assign cif.dstore = dcif.dmemstore;
  assign cif.daddr = dcif.dmemaddr;


/*
typedef enum logic [3:0] {
    IDLE, WB1, WB2
} s_t; 
dcache_frame dframes[7:0][1:0];


	logic valid;
	logic dirty;
	logic [DTAG_W - 1:0] tag;
	word_t [1:0] data;

always_ff @ (posedge CLK, negedge nRST) begin
    if(!nRST) begin
        for(int i = 0;i<8;i++) begin
            for(int j = 0; j<2;j++) begin
                dframes[i][j].valid    = '0;
                dframes[i][j].dirty    = '0;            
                dframes[i][j].tag      = '0;
                dframes[i][j].data[0]  = '0;
                dframes[i][j].data[1]  = '0;
            end
        end
    end
    else begin         

    end

end


always_comb begin
    state_nxt = state;
    dcif.dhit = 0;

    case(state)
    IDLE: begin
		if(dcif.) begin end
	    else if(dcif.dmemREN  &&  dframes[idx][0].tag == tag  &&  dframes[idx][0].valid) begin
            beginstate_nxt = IDLE;
            dcif.dhit = 1;
            dcif.dmemload = dframes[idx][0].data[offset];
            cnt_nxt = cnt_nxt + 1;
        end
        else if(dcif.dmemREN  &&  dframes[idx][1].tag == tag  &&  dframes[idx][1].valid) begin
            state_nxt = IDLE;
            dcif.dhit = 1;
            dcif.dmemload = dframes[idx][1].data[offset];
            cnt_nxt = cnt_nxt + 1;            
        end 
        else if(dcif.dmemREN) begin
            dmiss = 1;
        end
        else if(dcif.dmemWEN  &&  dframes[idx][0].tag == tag) begin
            dcif.dhit = 1;
            dframes[idx][0].dirty = 1;
            dframes[idx][0].data[offset] = dcif.dmemstore;                        
        end 
        else if(dcif.dmemWEN  &&  dframes[idx][1].tag == tag) begin
            dcif.dhit = 1;
            dframes[idx][1].dirty = 1;
            dframes[idx][1].data[offset] = dcif.dmemstore;                        
        end 
        else if(dcif.dmemWEN) begin
            
        end
    end



       
    WB1: begin
        state_nxt = (cif.dwait) ? WB1 : WB2;
        cif.dWEN = 1;


    end
    WB2: begin
        state_nxt = (cif.dwait) ? WB2 : WB2;

    end



	    
    CNT:
        cif.dWEN = 1;
		cif.daddr = 32'h00003100;
		cif.dstore = hit_count; 



    endcase


end




 


*/




endmodule