`include "cpu_types_pkg.vh"
`include "register_file_if.vh"
module register_file
(
  input logic CLK, nRST, 
  register_file_if.rf rfif
);

import cpu_types_pkg::*;
/*
word_t  [31:0] regs ;
word_t  [31:0] regsn ;

always_ff @(posedge CLK, negedge nRST) begin
  if(!nRST) 
    regs <= '0;
  else 
    regs <= regsn;
end 

always_comb begin
  regsn = regs;
  if(rfif.WEN && rfif.wsel != 0)
    regsn[rfif.wsel] = rfif.wdat;
end 

assign  rfif.rdat1 = regs[rfif.rsel1];
assign  rfif.rdat2 = regs[rfif.rsel2];

  */


  word_t [31:0] regs ;
  
  always_ff @(posedge CLK, negedge nRST)
  begin
    if(!nRST)
    begin
      regs <= '0; // {32{32'b0}} or '{'0} if use unpacked
    end
    else if(rfif.WEN)
      regs[rfif.wsel] <= (rfif.wsel == 0) ? 32'h00000000 : rfif.wdat;
  end

assign  rfif.rdat1 = (rfif.WEN && rfif.wsel == rfif.rsel1) ? rfif.wdat : regs[rfif.rsel1];
assign  rfif.rdat2 = (rfif.WEN && rfif.wsel == rfif.rsel2) ? rfif.wdat : regs[rfif.rsel2];



endmodule



