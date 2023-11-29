`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"
module hazard_unit
(
  hazard_unit_if huif
);
  import cpu_types_pkg::*;
    



  always_comb begin: FORWARDING_LOGIC
    huif.ForwardA = '0;
    huif.ForwardB = '0;
    // EXMEM is first order.
    // If I type, rt doesn't matter
    if(huif.EXMEM_RegWrite  &&  huif.EXMEM_rd!=0  &&  huif.EXMEM_rd==huif.IDEX_rs)
      huif.ForwardA = 2'b10;
    else if(huif.MEMWB_RegWrite  &&  huif.MEMWB_rd!=0  &&  huif.MEMWB_rd==huif.IDEX_rs)
      huif.ForwardA = 2'b01;

    if(huif.EXMEM_RegWrite  &&  huif.EXMEM_rd!=0  &&  huif.EXMEM_rd==huif.IDEX_rt)
      huif.ForwardB = 2'b10;
    else if(huif.MEMWB_RegWrite  &&  huif.MEMWB_rd!=0  &&  huif.MEMWB_rd==huif.IDEX_rt)
      huif.ForwardB = 2'b01;
  end


  assign huif.ForwardSW = (huif.EXMEM_dWEN &&  huif.MEMWB_RegWrite       &&  huif.MEMWB_rd      == huif.EXMEM_rt) ? 2'b10 :
                          (huif.EXMEM_dWEN &&  huif.MEMWB_RegWrite_Prev  &&  huif.MEMWB_rd_Prev == huif.EXMEM_rt) ? 2'b01 : 2'b00;
  /*
  always_comb begin: RegWrite_SW_LOGIC
    huif.ForwardSW = '0;
    //if(huif.IDEX_dWEN  &&  huif.EXMEM_RegWrite  &&  huif.EXMEM_rd == huif.IFID_rt  &&  huif.EXMEM_dREN)
      //huif.ForwardSW = 2'b11;
    if     (huif.IFID_dWEN &&  huif.IDEX_RegWrite  &&  huif.IDEX_rd == huif.IFID_rt)
      huif.ForwardSW = 2'b01;
    else if(huif.IFID_dWEN &&  huif.EXMEM_RegWrite  &&  huif.EXMEM_rd == huif.IFID_rt)
      huif.ForwardSW = 2'b10;
    
  end
  */

  always_comb begin: STALL_LW
    huif.StallLW = '0;
    if(huif.IDEX_dREN  &&  (huif.IDEX_rt==huif.IFID_rs  ||  huif.IDEX_rt==huif.IFID_rt)  )
      huif.StallLW = 2'b01;      
     /* // postpone 2 additional nop
    else if(huif.EXMEM_dREN  &&  (huif.EXMEM_rd==huif.IFID_rs  ||  huif.EXMEM_rd==huif.IFID_rt)  )
      huif.StallLW = 2'b01;
    else if(huif.MEMWB_dREN  &&  (huif.MEMWB_rd==huif.IFID_rs  ||  huif.MEMWB_rd==huif.IFID_rt)  )
      huif.StallLW = 2'b01;
    */
  end
    
    
endmodule






















    /*
    else if(huif.IDEX_dWEN  &&  (huif.IDEX_rt==huif.IFID_rs  ||  huif.IDEX_rt==huif.IFID_rt))
      huif.StallLW = 2'b01;
    else if(huif.EXMEM_dWEN  &&  (huif.EXMEM_rd==huif.IFID_rs  ||  huif.EXMEM_rd==huif.IFID_rt)  )
      huif.StallLW = 2'b01;    
    else if(huif.MEMWB_dWEN  &&  (huif.MEMWB_rd==huif.IFID_rs  ||  huif.MEMWB_rd==huif.IFID_rt)  )
      huif.StallLW = 2'b01;

    huif.ForwardSW ='0;
    */