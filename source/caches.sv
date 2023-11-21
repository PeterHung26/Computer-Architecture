/*
  Eric Villasenor
  evillase@gmail.com

  this block holds the i and d cache
*/


module caches (
  input logic CLK, nRST,
  datapath_cache_if dcif,
  caches_if cif,
  output have
);

  // icache
  icache  ICACHE(CLK, nRST, dcif, cif);
  //dcache
  dcache  DCACHE(CLK, nRST, dcif, cif, have);

  // dcache invalidate before halt handled by dcache when exists
  

  //singlecycle
  //assign dcif.ihit = (dcif.imemREN) ? ~cif.iwait : 0;
  //assign dcif.imemload = cif.iload;
  

  //assign cif.iREN = dcif.imemREN;
  //assign cif.iaddr = dcif.imemaddr;

/*
  assign dcif.flushed = dcif.halt;
  assign dcif.dhit = (dcif.dmemREN|dcif.dmemWEN) ? ~cif.dwait : 0;
  assign dcif.dmemload = cif.dload;

  assign cif.dREN = dcif.dmemREN;
  assign cif.dWEN = dcif.dmemWEN;
  assign cif.dstore = dcif.dmemstore;
  assign cif.daddr = dcif.dmemaddr;
*/
endmodule

