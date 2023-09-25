
  #------------------------------------------------------------------
  # Test lw sw
  #------------------------------------------------------------------

  org   0x0000
  ori   $1,$zero,0xF0
  ori   $2,$zero,0x80
  lui   $7,0xdead
  ori   $7,$7,0xbeef
  sw    $7,0($1)
  ori   $9,$0,0xbeef
  ori   $9,$0,0xbeef
  ori   $9,$0,0xbeef
  ori   $9,$0,0xbeef
  ori   $9,$0,0xbeef
  ori   $9,$0,0xbeef
  halt
  sw    $7,8($1)
  sw    $7,16($1)

  halt
