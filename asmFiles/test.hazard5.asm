
  #------------------------------------------------------------------
  # Test addr update then sw 
  #------------------------------------------------------------------

  org   0x0000
  ori   $3, $zero, 0xdead
  ori   $4, $zero, 0xbeef
  
  ori   $1, $zero, 0x80
  sw    $1, 0($1)
  ori   $2, $zero, 0xF0
  sw    $2, 0($2)
  halt      # that's all

  org   0x00F0
  cfw   0x7337
  cfw   0x2701
  cfw   0x1337
