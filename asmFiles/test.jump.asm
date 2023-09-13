  #------------------------------------------------------------------
  # JUMP Test Program
  #------------------------------------------------------------------

  org 0x0000
  ori   $1,$zero,0x0064
  ori   $2,$zero,0x37F1
  j     UNIT
  ori   $4,$zero,0xdead
  sw    $4, 0($1)


  UNIT:
  ori   $4,$zero,0xadcc
  sw    $4, 4($1)
  j     UNIT2
  ori   $4,$zero,0xacdc
  sw    $4, 8($1)

  UNIT2:
  ori   $4,$zero,0xbadd
  sw    $4, 12($1)
  halt
