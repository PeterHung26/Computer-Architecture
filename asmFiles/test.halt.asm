  #------------------------------------------------------------------
  # JUMP Test Program
  #------------------------------------------------------------------

  org 0x0000
  ori   $1,$zero,0x0064 # 100
  ori   $2,$zero,0x0068 # 104
  ori   $3,$zero,0x5656
  ori   $4,$zero,0x2222
  ori   $5,$zero,0x7955
  sw    $3, 0($1)
  sw    $5, 0($2)
  halt
  sw    $4, 4($1)
