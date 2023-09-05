  #------------------------------------------------------------------
  # JAL Test Program
  #------------------------------------------------------------------

  org 0x0000
  ori   $1,$zero,0xD269
  ori   $2,$zero,0x37F1
  jal     UNIT
  ori   $4,$zero,0xdead
  sw    $4, 0($1)
  halt


  UNIT:
  ori   $4,$zero,0xcool
  sw    $4, 4($1)
  jr    $31
  ori   $4,$zero,0xpete
  sw    $4, 8($1)

