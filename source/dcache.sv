//cache interface
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// types
`include "cpu_types_pkg.vh"

module dcache(input logic CLK, nRST, datapath_cache_if.dcache dcif, caches_if.dcache dif);
    // type import
    import cpu_types_pkg::*;
    typedef enum logic [4:0] {GOOD, SNOOP_CHECK, WB1, WB2, CHECK, IRDX1, IRDX2, IRD1, IRD2, SRDX1, SRDX2, S_TO_I, Reply_RDX1, Reply_RDX2, Reply_RD1, Reply_RD2, HCHECK, HWB1, HWB2, DONE} state_t;
    typedef struct packed {
        dcache_frame left;
        dcache_frame right;
        logic [25:0] left_snooptag;
        logic [25:0] right_snooptag;
        logic mru;
    } dcache_t;

    typedef struct packed {
        word_t link_reg;
        logic valid;
    } link_t;

    dcache_t [7:0] cache; // set up the dcache
    dcache_t nxt_cache;
    dcache_t respond_nxt_cache;

    logic [25:0] tag; // Store tag from dmemaddr
    logic [2:0] index; // Store index from dmemaddr
    logic offset; // Store block offset from dmemaddr

    logic [25:0] snoop_tag; // Store tag from ccsnoopaddr
    logic [2:0] snoop_index; // Store index from ccsnoopaddr
    logic snoop_offset;

    state_t nxt_state, state;
    logic replying;
    
    //Link Register
    link_t link, nxt_link;

    logic miss;
    logic way; // indicate left is hit or right is hit
    logic cmiss;
    logic cway;
    logic [4:0] halt_cnt;
    logic [4:0] nxt_halt_cnt;
    logic [4:0] halt_cnt_wb;

    //integer i;
    integer j;
    // From datapath
    assign tag = dcif.dmemaddr[31:6];
    assign index = dcif.dmemaddr[5:3];
    assign offset = dcif.dmemaddr[2];
    // From bus controller
    assign snoop_tag = dif.ccsnoopaddr[31:6];
    assign snoop_index = dif.ccsnoopaddr[5:3];
    assign snoop_offset = dif.ccsnoopaddr[2];

    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            state <= GOOD;
            halt_cnt <= '0;
            cache <= '0;
            link <= '0;
        end
        else begin
            halt_cnt <= nxt_halt_cnt;
            state <= nxt_state;
            if(replying)
                cache[snoop_index] <= respond_nxt_cache;
            else
                cache[index] <= nxt_cache;
            link <= nxt_link;
        end
    end

    always_comb begin: NXT_STATE
        nxt_state = state;
        nxt_halt_cnt = halt_cnt;
        case (state)
            GOOD: begin
                if(dif.ccwait) begin
                    nxt_state = SNOOP_CHECK;
                end
                else if(dcif.dmemWEN && dcif.datomic) begin
                    if(!link.valid || (dcif.dmemaddr != link.link_reg)) begin // Test and Set is invalidated, dmemload return 0 (fail)
                        nxt_state = GOOD;
                    end
                    else begin
                        if(miss) begin
                            nxt_state = CHECK;
                        end
                        else begin
                            if(way == 0) begin
                                if(!cache[index].left.dirty) begin // Shared, S -> M
                                    nxt_state = SRDX1;
                                end
                                else begin
                                    nxt_state = GOOD;
                                end
                            end
                            else begin
                                if(!cache[index].right.dirty) begin // Shared, S -> M
                                    nxt_state = SRDX1;
                                end
                                else begin
                                    nxt_state = GOOD;
                                end
                            end
                        end
                    end
                end
                else if(dcif.halt == 1'b1) begin
                    nxt_state = HCHECK;
                end
                else if((dcif.dmemREN || dcif.dmemWEN) && (miss == 1)) begin
                    nxt_state = CHECK;
                end
                else if(dcif.dmemWEN && (miss == 0)) begin
                    if(way == 0) begin
                        if(!cache[index].left.dirty) begin // Shared, S -> M
                            nxt_state = SRDX1;
                        end
                        else begin
                            nxt_state = GOOD;
                        end
                    end
                    else begin
                        if(!cache[index].right.dirty) begin // Shared, S -> M
                            nxt_state = SRDX1;
                        end
                        else begin
                            nxt_state = GOOD;
                        end
                    end
                end
                else begin
                    nxt_state = GOOD;
                end
            end
            CHECK: begin // Check whether the replaced data are dirty or not
                if(dif.ccwait)
                    nxt_state = SNOOP_CHECK;
                else if(cache[index].mru == 0) begin // Check right
                    if(cache[index].right.dirty && cache[index].right.valid) begin
                        nxt_state = WB1;
                    end
                    else begin
                        if(dcif.dmemWEN) begin
                            nxt_state = IRDX1;
                        end
                        else begin
                            nxt_state = IRD1;
                        end
                    end
                end
                else begin // Check left
                    if(cache[index].left.dirty && cache[index].right.valid) begin
                        nxt_state = WB1;
                    end
                    else begin
                        if(dcif.dmemWEN) begin
                            nxt_state = IRDX1;
                        end
                        else begin
                            nxt_state = IRD1;
                        end
                    end
                end
            end
            WB1: begin
                if(dif.ccwait)
                    nxt_state = SNOOP_CHECK;
                else begin
                    if(dif.dwait)
                        nxt_state = WB1;
                    else
                        nxt_state = WB2;
                end
            end
            WB2: begin
                if(dif.dwait)
                    nxt_state = WB2;
                else begin
                    if(dcif.dmemWEN)
                        nxt_state = IRDX1;
                    else
                        nxt_state = IRD1;
                end
            end
            IRDX1: begin
                if(dif.ccwait)
                    nxt_state = SNOOP_CHECK;
                else begin
                    if(dif.dwait)
                        nxt_state = IRDX1;
                    else
                        nxt_state = IRDX2;
                end
            end
            IRDX2: begin
                if(dif.dwait)
                    nxt_state = IRDX2;
                else
                    nxt_state = GOOD;
            end
            IRD1: begin
                if(dif.ccwait)
                    nxt_state = SNOOP_CHECK;
                else begin
                    if(dif.dwait)
                        nxt_state = IRD1;
                    else
                        nxt_state = IRD2;
                end
            end
            IRD2: begin
                if(dif.dwait)
                    nxt_state = IRD2;
                else
                    nxt_state = GOOD;
            end
            SRDX1: begin
                if(dif.ccwait)
                    nxt_state = SNOOP_CHECK;
                else begin
                    if(dif.dwait)
                        nxt_state = SRDX1;
                    else
                        nxt_state = SRDX2;
                end
            end
            SRDX2: begin
                if(dif.dwait)
                    nxt_state = SRDX2;
                else
                    nxt_state = GOOD;
            end
            S_TO_I: begin
                nxt_state = GOOD;
            end
            Reply_RD1: begin
                if(dif.dwait)
                    nxt_state = Reply_RD1;
                else
                    nxt_state = Reply_RD2;
            end
            Reply_RD2: begin
                if(dif.dwait)
                    nxt_state = Reply_RD2;
                else
                    nxt_state = GOOD;
            end
            Reply_RDX1: begin
                if(dif.dwait)
                    nxt_state = Reply_RDX1;
                else
                    nxt_state = Reply_RDX2;
            end
            Reply_RDX2: begin
                if(dif.dwait)
                    nxt_state = Reply_RDX2;
                else
                    nxt_state = GOOD;
            end
            SNOOP_CHECK: begin
                if(dif.ccwait) begin
                    if(dif.ccinv) begin // BusRdX
                        if(cmiss == 0 && cway == 0) begin
                            if(cache[snoop_index].left.dirty) begin // Modified, M -> I
                                nxt_state = Reply_RDX1;
                            end
                            else begin // Shared, S -> I
                                nxt_state = S_TO_I;
                            end
                        end
                        else if(cmiss == 0 && cway == 1) begin
                            if(cache[snoop_index].right.dirty) begin // Modified, M -> I
                                nxt_state = Reply_RDX1;
                            end
                            else begin // Shared, S -> I
                                nxt_state = S_TO_I;
                            end
                        end
                        else begin // Invalid
                            nxt_state = GOOD;
                        end
                    end
                    else begin // BusRd
                        if(cmiss == 0 && cway == 0) begin
                            if(cache[snoop_index].left.dirty) begin // Modified, M -> S
                                nxt_state = Reply_RD1;
                            end
                            else begin // Shared, S -> S
                                nxt_state = GOOD;
                            end
                        end
                        else if(cmiss == 0 && cway == 1) begin
                            if(cache[snoop_index].right.dirty) begin // Modified, M -> S
                                nxt_state = Reply_RD1;
                            end
                            else begin // Shared, S -> S
                                nxt_state = GOOD;
                            end
                        end
                        else begin // Invalid
                            nxt_state = GOOD;
                        end
                    end
                end
                else
                    nxt_state = GOOD;
            end
            HCHECK: begin
                if(dif.ccwait)
                    nxt_state = SNOOP_CHECK;
                else begin
                    nxt_halt_cnt = halt_cnt + 1;
                    if(halt_cnt[4])
                        nxt_state = DONE;
                    else begin
                        if(halt_cnt[3]) begin   // Check Right 
                            if(cache[halt_cnt[2:0]].right.dirty && cache[halt_cnt[2:0]].right.valid)
                                nxt_state = HWB1;
                            else
                                nxt_state = HCHECK;
                        end
                        else begin // Check Left
                            if(cache[halt_cnt[2:0]].left.dirty && cache[halt_cnt[2:0]].left.valid)
                                nxt_state = HWB1;
                            else
                                nxt_state = HCHECK;
                        end
                    end
                end
            end
            HWB1: begin
                if(dif.ccwait) begin
                    nxt_state = SNOOP_CHECK;
                    nxt_halt_cnt = halt_cnt - 1;
                end
                else if(dif.dwait)
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
        endcase
    end

    always_comb begin : CMISS_AND_CWAY
        cmiss = 1'b0;
        cway = 1'b0; 
        if(((snoop_tag == cache[snoop_index].left_snooptag) && cache[snoop_index].left.valid)) begin
            cmiss = 1'b0;
            cway = 1'b0;
        end
        else if(((snoop_tag == cache[snoop_index].right_snooptag) && cache[snoop_index].right.valid)) begin
            cmiss = 1'b0;
            cway = 1'b1;
        end
        else begin
            cmiss = 1'b1;
        end
    end

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
        dif.cctrans = '0;
        dif.ccwrite = '0;
        dcif.dmemload = '0;
        dcif.dhit = '0;
        dcif.flushed = '0;
        dif.dREN = '0;
        dif.dWEN = '0;
        dif.daddr = '0;
        dif.dstore = '0;
        respond_nxt_cache.left = cache[snoop_index].left;
        respond_nxt_cache.right = cache[snoop_index].right;
        respond_nxt_cache.mru = cache[snoop_index].mru;
        respond_nxt_cache.left_snooptag = cache[snoop_index].left_snooptag;
        respond_nxt_cache.right_snooptag = cache[snoop_index].right_snooptag;
        nxt_cache.left = cache[index].left;
        nxt_cache.right = cache[index].right;
        nxt_cache.mru = cache[index].mru;
        nxt_cache.left_snooptag = cache[index].left_snooptag;
        nxt_cache.right_snooptag = cache[index].right_snooptag;
        halt_cnt_wb = halt_cnt - 1;
        replying = 0;
        nxt_link.link_reg = link.link_reg;
        nxt_link.valid = link.valid;
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
                        //nxt_hit_cnt = hit_cnt + 1;
                        if(dcif.datomic) begin
                            nxt_link.link_reg = dcif.dmemaddr;
                            nxt_link.valid = 1'b1;
                        end
                    end
                    else if(dcif.dmemWEN) begin
                        if(dcif.datomic) begin
                            if(link.valid && (link.link_reg == dcif.dmemaddr)) begin
                                if(way == 0) begin
                                    if(cache[index].left.dirty) begin // M -> M
                                        if(offset == 1'b0) begin
                                            nxt_cache.left.data[0] = dcif.dmemstore;
                                        end
                                        else begin
                                            nxt_cache.left.data[1] = dcif.dmemstore;
                                        end
                                        nxt_cache.left.dirty = 1'b1;
                                        nxt_cache.mru = 0;
                                        dcif.dhit = 1'b1;
                                        dcif.dmemload = 32'b1;
                                        nxt_link.valid = 1'b0;
                                        nxt_link.link_reg = '0;
                                    end
                                end
                                else begin
                                    if(cache[index].right.dirty) begin // M -> M
                                        if(offset == 1'b0) begin
                                            nxt_cache.right.data[0] = dcif.dmemstore;
                                        end
                                        else begin
                                            nxt_cache.right.data[1] = dcif.dmemstore;
                                        end
                                        nxt_cache.right.dirty = 1'b1;
                                        nxt_cache.mru = 1;
                                        dcif.dhit = 1'b1;
                                        dcif.dmemload = 32'b1;
                                        nxt_link.valid = 1'b0;
                                        nxt_link.link_reg = '0;
                                    end
                                end
                            end
                            else begin // Address not match but found the data in dcache
                                dcif.dhit = 1'b1;
                                dcif.dmemload = 32'b0;
                            end
                        end
                        else begin
                            if(way == 0) begin
                                if(cache[index].left.dirty) begin // M -> M
                                    if(offset == 1'b0) begin
                                        nxt_cache.left.data[0] = dcif.dmemstore;
                                    end
                                    else begin
                                        nxt_cache.left.data[1] = dcif.dmemstore;
                                    end
                                    nxt_cache.left.dirty = 1'b1;
                                    nxt_cache.mru = 0;
                                    dcif.dhit = 1'b1;
                                    if(dcif.dmemaddr == link.link_reg) begin // Unlock
                                        nxt_link.valid = 1'b0;
                                        nxt_link.link_reg = '0;
                                    end
                                end
                            end
                            else begin
                                if(cache[index].right.dirty) begin // M -> M
                                    if(offset == 1'b0) begin
                                        nxt_cache.right.data[0] = dcif.dmemstore;
                                    end
                                    else begin
                                        nxt_cache.right.data[1] = dcif.dmemstore;
                                    end
                                    nxt_cache.right.dirty = 1'b1;
                                    nxt_cache.mru = 1;
                                    dcif.dhit = 1'b1;
                                    if(dcif.dmemaddr == link.link_reg) begin // Unlock
                                        nxt_link.valid = 1'b0;
                                        nxt_link.link_reg = '0;
                                    end
                                end
                            end
                        end
                    end
                end
                else begin
                    if(dcif.datomic && dcif.dmemWEN) begin
                        if(!link.valid || (link.link_reg != dcif.dmemaddr)) begin // Test and Set is failed
                            dcif.dhit = 1'b1;
                            dcif.dmemload = 32'b0;
                        end
                    end
                end
                /*else begin
                    nxt_hit_cnt = hit_cnt - 1;
                end*/
            end
            IRD1: begin
                dif.dREN = 1'b1;
                dif.cctrans = 1'b1;
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
            IRD2: begin
                dif.dREN = 1'b1;
                dif.cctrans = 1'b1;
                dif.daddr = {dcif.dmemaddr[31:3], 3'b100}; //Read second word
                if(!dif.dwait) begin // Data comes back from memory
                    if(cache[index].mru == 0) begin // replace right
                        nxt_cache.right.data[1] = dif.dload;
                        nxt_cache.right.valid = 1'b1;
                        nxt_cache.right.dirty = 1'b0;
                        nxt_cache.right.tag = tag;
                        nxt_cache.right_snooptag = tag;
                    end
                    else begin // replace left
                        nxt_cache.left.data[1] = dif.dload;
                        nxt_cache.left.valid = 1'b1;
                        nxt_cache.left.dirty = 1'b0;
                        nxt_cache.left.tag = tag;
                        nxt_cache.left_snooptag = tag;
                    end
                end
            end
            IRDX1: begin
                dif.dREN = 1'b1;
                dif.cctrans = 1'b1;
                dif.ccwrite = 1'b1;
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
            IRDX2: begin
                dif.dREN = 1'b1;
                dif.cctrans = 1'b1;
                dif.ccwrite = 1'b1;
                dif.daddr = {dcif.dmemaddr[31:3], 3'b100}; //Read second word
                if(!dif.dwait) begin // Data comes back from memory
                    if(cache[index].mru == 0) begin // replace right
                        nxt_cache.right.data[1] = dif.dload;
                        nxt_cache.right.valid = 1'b1;
                        nxt_cache.right.dirty = 1'b1;
                        nxt_cache.right.tag = tag;
                        nxt_cache.right_snooptag = tag;
                    end
                    else begin // replace left
                        nxt_cache.left.data[1] = dif.dload;
                        nxt_cache.left.valid = 1'b1;
                        nxt_cache.left.dirty = 1'b1;
                        nxt_cache.left.tag = tag;
                        nxt_cache.left_snooptag = tag;
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
                    dif.daddr = {cache[index].left.tag, index, 3'b100};
                    dif.dstore = cache[index].left.data[1];
                end
                if(!dif.dwait) begin
                    if(cache[index].mru == 0) begin
                        nxt_cache.right.valid = 1'b0;
                    end
                    else begin
                        nxt_cache.left.valid = 1'b0;
                    end
                end
            end
            SRDX1: begin
                dif.dREN = 1'b1;
                dif.ccwrite = 1'b1;
                dif.cctrans = 1'b1;
                dif.daddr = {dcif.dmemaddr[31:3], 3'b000}; //Read first word
            end
            SRDX2: begin
                dif.dREN = 1'b1;
                dif.ccwrite = 1'b1;
                dif.cctrans = 1'b1;
                dif.daddr = {dcif.dmemaddr[31:3], 3'b100}; //Read first word
                if(!dif.dwait) begin
                    if(way == 0)
                        nxt_cache.left.dirty = 1'b1;
                    else
                        nxt_cache.right.dirty = 1'b1;
                end
            end
            S_TO_I: begin
                replying = 1'b1;
                //dif.cctrans = 1'b1;
                if(cway == 0) begin
                    respond_nxt_cache.left.valid = 1'b0;
                end
                else begin
                    respond_nxt_cache.right.valid = 1'b0;
                end
                if(dif.ccsnoopaddr == link.link_reg) begin
                    nxt_link.valid = 1'b0;
                    nxt_link.link_reg = 32'b0;
                end
                //reply_done = 1'b1;
            end
            Reply_RDX1: begin
                dif.cctrans = 1'b1;
                dif.dWEN = 1'b1;
                replying = 1'b1;
                if(cway == 0) begin
                    dif.daddr = {cache[snoop_index].left.tag, snoop_index, 3'b000};
                    dif.dstore = cache[snoop_index].left.data[0];
                end
                else begin
                    dif.daddr = {cache[snoop_index].right.tag, snoop_index, 3'b000};
                    dif.dstore = cache[snoop_index].right.data[0];
                end
            end
            Reply_RDX2: begin // M -> I
                dif.cctrans = 1'b1;
                dif.dWEN = 1'b1;
                replying = 1'b1;
                if(cway == 0) begin
                    dif.daddr = {cache[snoop_index].left.tag, snoop_index, 3'b100};
                    dif.dstore = cache[snoop_index].left.data[1];
                end
                else begin
                    dif.daddr = {cache[snoop_index].right.tag, snoop_index, 3'b100};
                    dif.dstore = cache[snoop_index].right.data[1];
                end
                if(!dif.dwait) begin
                    if(cway == 0)
                        respond_nxt_cache.left.valid = 1'b0;
                    else
                        respond_nxt_cache.right.valid = 1'b0;
                    //reply_done = 1'b1;
                    if(dif.ccsnoopaddr == link.link_reg) begin
                        nxt_link.valid = 1'b0;
                        nxt_link.link_reg = 32'b0;
                    end
                end
            end
            Reply_RD1: begin
                dif.cctrans = 1'b1;
                dif.dWEN = 1'b1;
                replying = 1'b1;
                if(cway == 0) begin
                    dif.daddr = {cache[snoop_index].left.tag, snoop_index, 3'b000};
                    dif.dstore = cache[snoop_index].left.data[0];
                end
                else begin
                    dif.daddr = {cache[snoop_index].right.tag, snoop_index, 3'b000};
                    dif.dstore = cache[snoop_index].right.data[0];
                end
            end
            Reply_RD2: begin // M -> S
                dif.cctrans = 1'b1;
                dif.dWEN = 1'b1;
                replying = 1'b1;
                if(cway == 0) begin
                    dif.daddr = {cache[snoop_index].left.tag, snoop_index, 3'b100};
                    dif.dstore = cache[snoop_index].left.data[1];
                end
                else begin
                    dif.daddr = {cache[snoop_index].right.tag, snoop_index, 3'b100};
                    dif.dstore = cache[snoop_index].right.data[1];
                end
                if(!dif.dwait) begin
                    if(cway == 0)
                        respond_nxt_cache.left.dirty = 1'b0;
                    else
                        respond_nxt_cache.right.dirty = 1'b0;
                    //reply_done = 1'b1;
                end
            end
            /*HCHECK: begin
                // if(!(nxt_m_i || nxt_m_s || nxt_s_i))
                    nxt_halt_cnt = halt_cnt + 1;
                // else
                //     nxt_halt_cnt = halt_cnt;
            end*/
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
            DONE: begin
                dcif.flushed = 1'b1;
                //done = 1'b1;
            end
        endcase
    end
endmodule