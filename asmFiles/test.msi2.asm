#------------------------------------------------------------------
# Test MSI protocol
# First: I -> M -> I
# Second: I -> M
#------------------------------------------------------------------

# First processor
  org   0x0000
  ori   $1, $zero, 0x500
  ori   $6, $zero, 0x400
  ori   $7, $zero, 0x600
  sw    $2, 0($1) # First: I -> M, Second: I -> I, first word
  sw    $3, 4($1) # First: I -> M, Second: I -> I, second word
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  halt      # that's all

# Second processor
  org   0x0200
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  ori   $6, $zero, 0x8787
  ori   $7, $zero, 0x9999
  sw    $6, 0($1) # Second: I -> M, First: M -> I, first word
  sw    $7, 4($1) 
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  halt      # that's all


  org   0x0500
  cfw   0x7337
  cfw   0x2701
  cfw   0x1337
  cfw   0XBEEF


