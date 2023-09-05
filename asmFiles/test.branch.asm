  #------------------------------------------------------------------
  # Branch Test Program
  #------------------------------------------------------------------

  org 0x0000
  ori   $1,$zero,0xD269
  ori   $2,$zero,0x37F1
  ori   $3,$zero,0xD269
  beq   $1, $2, UNIT
  bne   $1, $3, UNIT
  beq   $1, $3, UNIT
  
  UNIT:
  ori   $4,$zero,0x5454
  bne   $1, $2, UNIT2


  UNIT2:
  ori   $5,$zero,0x8787
  halt
