  #------------------------------------------------------------------
  # Branch Test Program
  #------------------------------------------------------------------

  org 0x0000
  ori   $1,$zero,0xD269
  ori   $2,$zero,0x37F1
  ori   $3,$zero,0xD269
  beq   $1, $2, UNIT
  ori   $4,$zero,0xdead
  sw    $4, 0($1)
  bne   $1, $3, UNIT
  ori   $4,$zero,0xfacc
  sw    $4, 4($1)
  beq   $1, $3, UNIT
  ori   $4,$zero,0xacbd
  sw    $4, 8($1)
  
  UNIT:
  ori   $4,$zero,0xbadd
  sw    $4, 12($1)
  bne   $1, $2, UNIT2


  UNIT2:
  ori   $4,$zero,0xfdaa
  sw    $4, 16($1)
  halt
