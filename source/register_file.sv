`include "register_file_if.vh"

module register_file(
    input logic clk,
    input logic n_rst,
    register_file_if rfif
);

logic [31:0][31:0] regfile;
logic [31:0][31:0] nxt_regfile;

genvar i;
generate
    for(i = 0; i < 32; i++) begin
        always_ff @( posedge clk, negedge n_rst ) begin : REGISTER_FILE
            if(!n_rst) begin
                regfile[i] <= '0;
            end
            else begin
                regfile[i] <= nxt_regfile[i];
            end
        end
    end
endgenerate

int j;
always_comb begin : READ1
    rfif.rdat1 = '0;
    for(j = 0; j < 32; j++) begin
        if(rfif.rsel1 == j) begin
            rfif.rdat1 = regfile[j];
        end
    end
end

int k;
always_comb begin : READ2
    rfif.rdat2 = '0;
    for(k = 0; k < 32; k++) begin
        if(rfif.rsel2 == k) begin
            rfif.rdat2 = regfile[k];
        end
    end
end

int l;
always_comb begin : NXT_REGFILE
    nxt_regfile = regfile;
    if(rfif.WEN) begin
        for(l = 0; l < 32; l++) begin
            if((rfif.wsel == l) && (l == 0)) begin
                nxt_regfile[l] = '0;
            end
            else if(rfif.wsel == l) begin
                nxt_regfile[l] = rfif.wdat;
            end
        end
    end
end

endmodule