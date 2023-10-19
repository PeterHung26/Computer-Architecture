//cache interface
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// types
`include "cpu_types_pkg.vh"

module dcache(input logic CLK, nRST, datapath_cache_if.dcache dcif, caches_if.dcache dif);
    // type import
    import cpu_types_pkg::*;
    typedef enum logic [3:0] {GOOD, WB1, WB2, CHECK, WAIT1, WAIT2, HCHECK, HWB1, HWB2, HIT_CNT, DONE} state_t;
    //typedef enum logic [2:0] {EVEN, LEFT1, LEFT2, RIGHT1, RIGHT2} lru_t;
    typedef struct packed {
        dcache_frame left;
        dcache_frame right;
        logic mru;
    } dcache_t;
    dcache_t [7:0] cache; // set up the dcache
    dcache_t nxt_cache;

    logic [25:0] tag; // Store tag from dmemaddr
    logic [2:0] index; // Store index from dmemaddr
    logic offset; // Store block offset from dmemaddr

    state_t nxt_state, state;

    logic miss;
    logic way; // indicate left is hit or right is hit
    logic used_most;
    logic [4:0] halt_cnt;
    logic [4:0] nxt_halt_cnt;
    logic [4:0] halt_cnt_wb;
    word_t hit_cnt;
    word_t nxt_hit_cnt;

    integer i;
    integer j;

    assign tag = dcif.dmemaddr[31:6];
    assign index = dcif.dmemaddr[5:3];
    assign offset = dcif.dmemaddr[2];
    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            state <= GOOD;
            halt_cnt <= '0;
            hit_cnt <= '0;
            for(i = 0; i < 8; i++) begin
                cache[i].left.valid <= '0;
                cache[i].left.dirty <= '0;
                cache[i].left.tag <= '0;
                cache[i].left.data <= '0;
                cache[i].right.valid <= '0;
                cache[i].right.dirty <= '0;
                cache[i].right.tag <= '0;
                cache[i].right.data <= '0;
                cache[i].mru <= 0;
            end
        end
        else begin
            halt_cnt <= nxt_halt_cnt;
            hit_cnt <= nxt_hit_cnt;
            state <= nxt_state;
            cache[index] <= nxt_cache;
        end
    end

    /*always_comb begin: USED_MOST
        used_most = 1'b0;
        case (cache[index].lru_state)
            EVEN: begin
                used_most = 1'b0;
            end
            LEFT1: begin
                used_most = 1'b0;
            end
            LEFT2: begin
                used_most = 1'b0;
            end
            RIGHT1: begin
                used_most = 1'b1;
            end
            RIGHT2: begin
                used_most = 1'b1;
            end 
        endcase
    end*/

    always_comb begin: NXT_STATE
        nxt_state = state;
        case (state)
            GOOD: begin
                if(dcif.halt == 1'b1)
                    nxt_state = HCHECK;
                else if(dcif.dmemREN && (miss == 1))
                    nxt_state = CHECK;
                else if(dcif.dmemWEN && (miss == 1))
                    nxt_state = CHECK;
            end
            CHECK: begin // Check whether the replaced data are dirty or not
                if(cache[index].mru == 0) begin // Check right
                    if(cache[index].right.dirty)
                        nxt_state = WB1;
                    else
                        nxt_state = WAIT1;
                end
                else begin // Check left
                    if(cache[index].left.dirty)
                        nxt_state = WB1;
                    else
                        nxt_state = WAIT1;
                end
            end
            WAIT1: begin
                if(dif.dwait)
                    nxt_state = WAIT1;
                else
                    nxt_state = WAIT2;
            end
            WAIT2: begin
                if(dif.dwait)
                    nxt_state = WAIT2;
                else
                    nxt_state = GOOD;
            end
            WB1: begin
                if(dif.dwait)
                    nxt_state = WB1;
                else
                    nxt_state = WB2;
            end
            WB2: begin
                if(dif.dwait)
                    nxt_state = WB2;
                else
                    nxt_state = WAIT1;
            end
            HCHECK: begin
                if(halt_cnt[4])
                    nxt_state = HIT_CNT;
                else begin
                    if(halt_cnt[3]) begin   // Check Right 
                        if(cache[halt_cnt[2:0]].right.dirty)
                            nxt_state = HWB1;
                        else
                            nxt_state = HCHECK;
                    end
                    else begin // Check Left
                        if(cache[halt_cnt[2:0]].left.dirty)
                            nxt_state = HWB1;
                        else
                            nxt_state = HCHECK;
                    end
                end
            end
            HWB1: begin
                if(dif.dwait)
                    nxt_state = HWB1;
                else
                    nxt_state = HWB2;
            end
            HWB2: begin
                if(dif.dwait)
                    nxt_state = HWB2;
                else
                    nxt_state = HCHECK;
            end
            HIT_CNT: begin
                if(dif.dwait)
                    nxt_state = HIT_CNT;
                else
                    nxt_state = DONE;
            end
        endcase
    end

    /*always_comb begin : NXT_STATE_LRU
        nxt_cache.lru_state = cache[index].lru_state;
        if(dcif.dhit) begin
            case (cache[index].lru_state)
                EVEN: begin
                    if(way == 0) begin
                        nxt_cache.lru_state = LEFT1;
                    end
                    else begin
                        nxt_cache.lru_state = RIGHT1;
                    end
                end
                LEFT1: begin
                    if(way == 0) begin
                        nxt_cache.lru_state = LEFT2;
                    end
                    else begin
                        nxt_cache.lru_state = EVEN;
                    end
                end
                LEFT2: begin
                    if(way == 0) begin
                        nxt_cache.lru_state = LEFT2;
                    end
                    else begin
                        nxt_cache.lru_state = LEFT1;
                    end
                end
                RIGHT1: begin
                    if(way == 0) begin
                        nxt_cache.lru_state = EVEN;
                    end
                    else begin
                        nxt_cache.lru_state = RIGHT2;
                    end
                end
                RIGHT2: begin
                    if(way == 0) begin
                        nxt_cache.lru_state = RIGHT1;
                    end
                    else begin
                        nxt_cache.lru_state = RIGHT2;
                    end
                end
            endcase
        end
    end*/

    always_comb begin: MISS_AND_WAY
        miss = 1'b0;
        way = 1'b0; 
        if((dcif.dmemREN || dcif.dmemWEN) && ((tag == cache[index].left.tag) && cache[index].left.valid)) begin
            miss = 1'b0;
            way = 1'b0;
        end
        else if((dcif.dmemREN || dcif.dmemWEN) && ((tag == cache[index].right.tag) && cache[index].right.valid)) begin
            miss = 1'b0;
            way = 1'b1;
        end
        else if(!(dcif.dmemREN || dcif.dmemWEN)) begin // No read and no write from datapath
            miss = 1'b0;
        end
        else begin
            miss = 1'b1;
        end
    end

    always_comb begin : OUTPUT_LOGIC
        dcif.dmemload = '0;
        dcif.dhit = '0;
        dcif.flushed = '0;
        dif.dREN = '0;
        dif.dWEN = '0;
        dif.daddr = '0;
        dif.dstore = '0;
        nxt_cache.left = cache[index].left;
        nxt_cache.right = cache[index].right;
        nxt_cache.mru = cache[index].mru;
        nxt_halt_cnt = halt_cnt;
        nxt_hit_cnt = hit_cnt;
        halt_cnt_wb = halt_cnt - 1;
        case (state)
            GOOD: begin
                if(miss == 0) begin
                    if(dcif.dmemREN) begin
                        if(way == 0) begin
                            if(offset == 1'b0) begin
                                dcif.dmemload = cache[index].left.data[0];
                            end
                            else begin
                                dcif.dmemload = cache[index].left.data[1];
                            end
                            nxt_cache.mru = 0;
                        end
                        else begin
                            if(offset == 1'b0) begin
                                dcif.dmemload = cache[index].right.data[0];
                            end
                            else begin
                                dcif.dmemload = cache[index].right.data[1];
                            end
                            nxt_cache.mru = 1;
                        end
                        dcif.dhit = 1'b1;
                        nxt_hit_cnt = hit_cnt + 1;
                    end
                    else if(dcif.dmemWEN) begin
                        if(way == 0) begin
                            if(offset == 1'b0) begin
                                nxt_cache.left.data[0] = dcif.dmemstore;
                            end
                            else begin
                                nxt_cache.left.data[1] = dcif.dmemstore;
                            end
                            nxt_cache.left.dirty = 1'b1;
                            nxt_cache.mru = 0;
                        end
                        else begin
                            if(offset == 1'b0) begin
                                nxt_cache.right.data[0] = dcif.dmemstore;
                            end
                            else begin
                                nxt_cache.right.data[1] = dcif.dmemstore;
                            end
                            nxt_cache.right.dirty = 1'b1;
                            nxt_cache.mru = 1;
                        end
                        dcif.dhit = 1'b1;
                        nxt_hit_cnt = hit_cnt + 1;
                    end
                end
                else begin
                    nxt_hit_cnt = hit_cnt - 1;
                end
            end
            WAIT1: begin
                dif.dREN = 1'b1;
                dif.daddr = {dcif.dmemaddr[31:3], 3'b000}; //Read first word
                if(!dif.dwait) begin // Data comes back from memory
                    if(cache[index].mru == 0) begin // replace right
                        nxt_cache.right.data[0] = dif.dload;
                    end
                    else begin // replace left
                        nxt_cache.left.data[0] = dif.dload;
                    end
                end
            end
            WAIT2: begin
                dif.dREN = 1'b1;
                dif.daddr = {dcif.dmemaddr[31:3], 3'b100}; //Read second word
                if(!dif.dwait) begin // Data comes back from memory
                    if(cache[index].mru == 0) begin // replace right
                        nxt_cache.right.data[1] = dif.dload;
                        nxt_cache.right.valid = 1'b1;
                        nxt_cache.right.dirty = 1'b0;
                        nxt_cache.right.tag = tag;
                    end
                    else begin // replace left
                        nxt_cache.left.data[1] = dif.dload;
                        nxt_cache.left.valid = 1'b1;
                        nxt_cache.left.dirty = 1'b0;
                        nxt_cache.left.tag = tag;
                    end
                end
            end
            WB1: begin
                dif.dWEN = 1'b1;
                if(cache[index].mru == 0) begin // Replace right
                    dif.daddr = {cache[index].right.tag, index, 3'b000};
                    dif.dstore = cache[index].right.data[0];
                end
                else begin // replace left
                    dif.daddr = {cache[index].left.tag, index, 3'b000};
                    dif.dstore = cache[index].left.data[0];
                end
            end
            WB2: begin
                dif.dWEN = 1'b1;
                if(cache[index].mru == 0) begin // Replace right
                    dif.daddr = {cache[index].right.tag, index, 3'b100};
                    dif.dstore = cache[index].right.data[1];
                end
                else begin // replace left
                    dif.daddr = {cache[index].left.tag, index, 3'b000};
                    dif.dstore = cache[index].left.data[1];
                end
            end
            HCHECK: begin
                nxt_halt_cnt = halt_cnt + 1;
            end
            HWB1: begin
                dif.dWEN = 1'b1;
                if(!halt_cnt_wb[3]) begin // Store back left
                    dif.daddr = {cache[halt_cnt_wb[2:0]].left.tag, halt_cnt_wb[2:0], 3'b000};
                    dif.dstore = cache[halt_cnt_wb[2:0]].left.data[0];
                end
                else begin // Store back right
                    dif.daddr = {cache[halt_cnt_wb[2:0]].right.tag, halt_cnt_wb[2:0], 3'b000};
                    dif.dstore = cache[halt_cnt_wb[2:0]].right.data[0];
                end
            end
            HWB2: begin
                dif.dWEN = 1'b1;
                if(!halt_cnt_wb[3]) begin // Store back left
                    dif.daddr = {cache[halt_cnt_wb[2:0]].left.tag, halt_cnt_wb[2:0], 3'b100};
                    dif.dstore = cache[halt_cnt_wb[2:0]].left.data[1];
                end
                else begin // Store back right
                    dif.daddr = {cache[halt_cnt_wb[2:0]].right.tag, halt_cnt_wb[2:0], 3'b100};
                    dif.dstore = cache[halt_cnt_wb[2:0]].right.data[1];
                end
            end
            HIT_CNT: begin
                dif.dWEN = 1'b1;
                dif.daddr = 32'h00003100;
                dif.dstore = hit_cnt;
            end
            DONE: begin
                dcif.flushed = 1'b1;
            end
        endcase
    end
endmodule