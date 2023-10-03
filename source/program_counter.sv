`include "program_counter_if.vh"
`include "cpu_types_pkg.vh"

module program_counter(
    input CLK, nRST,
    program_counter_if.pc pcif
);

import cpu_types_pkg::*;

word_t nxt_pcaddr;
//word_t temp1;
//word_t temp2;

always_ff @(posedge CLK, negedge nRST) begin : PROGRAM_COUNTER
    if(!nRST) begin
        pcif.pcaddr <= '0;
    end
    else begin
        if(pcif.PC_EN)
            pcif.pcaddr <= nxt_pcaddr;
        else
            pcif.pcaddr <= pcif.pcaddr;
    end
end

always_comb begin : NXT_PCADDR
    pcif.nxt_pc = pcif.pcaddr + 4;
    nxt_pcaddr = pcif.nxt_pc;
    if(pcif.PCSrc) //Branch has the first priority
        nxt_pcaddr = pcif.branch_pc + {pcif.bimm[29:0], 2'b0};
    else if(pcif.JR) begin // JR has second priority
        nxt_pcaddr = pcif.jraddr;
    end
    else if(pcif.Jump) begin // Jump and JAL has third priority
        nxt_pcaddr = {pcif.pcaddr[31:28], pcif.jimm, 2'b0};
    end
end
endmodule