`include "program_counter_if.vh"
`include "cpu_types_pkg.vh"

module program_counter(
    input CLK, nRST,
    program_counter_if.pc pcif
);

import cpu_types_pkg::*;

word_t nxt_pcaddr;
word_t temp1;
word_t temp2;

always_ff @(posedge CLK, negedge nRST) begin : PROGRAM_COUNTER
    if(!nRST) begin
        pcif.pcaddr <= '0;
    end
    else begin
        if(pcif.ihit)
            pcif.pcaddr <= nxt_pcaddr;
        else
            pcif.pcaddr <= pcif.pcaddr;
    end
end

always_comb begin : NXT_PCADDR
    if(pcif.Branch)
        temp1 = pcif.pcaddr + (pcif.bimm << 2);
    else
        temp1 = pcif.pcaddr + 4;
    if(pcif.Jump)
        temp2 = {4'b0, pcif.jimm, 2'b0};
    else
        temp2 = temp1;
    if(pcif.JR)
        nxt_pcaddr = pcif.jraddr;
    else
        nxt_pcaddr = temp2;
end
endmodule