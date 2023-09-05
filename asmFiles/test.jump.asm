  #------------------------------------------------------------------
  # JUMP Test Program
  #------------------------------------------------------------------

  org 0x0000
  ori   $1,$zero,0xD269
  ori   $2,$zero,0x37F1
  j     UNIT


  UNIT:
  ori   $3,$zero,0x8787
  jal   UNIT2
  ori   $5,$zero,0x5555
  halt

  UNIT2:
  ori   $4,$zero,0x7878
  jr    $31
