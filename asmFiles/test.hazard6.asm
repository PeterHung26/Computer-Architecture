
  #------------------------------------------------------------------
  # Test addr update then sw 
  #------------------------------------------------------------------

  org   0x0000
  ori   $1, $zero, 0x80
  ori   $2, $zero, 0xF0
  ori   $3, $zero, 0xdead
  ori   $4, $zero, 0xbeef
  ori   $25, $zero, 0x88
  
  SW    $3, 0($1)
  ADDIU $25, $25, -4
  LW    $4, -4($2)

  
  halt      # that's all

  org   0x00F0
  cfw   0x7337
  cfw   0x2701
  cfw   0x1337
