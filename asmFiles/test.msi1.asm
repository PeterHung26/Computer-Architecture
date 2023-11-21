#------------------------------------------------------------------
# Test MSI protocol
# First: I -> M -> S
# Second: I -> S
#------------------------------------------------------------------

# First processor
  org   0x0000
  ori   $1, $zero, 0x500
  ori   $2, $zero, 0x400
  ori   $3, $zero, 0x600
  sw    $2, 0($1) # First: I -> M, Second: I -> I, first word
  sw    $3, 4($1) # First: M -> M, Second: I -> I, second word
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
  ori   $1, $zero, 0x500
  lw    $4, 0($1) # Second: I -> S, First: M -> S, first word
  lw    $5, 4($1) # Second: I -> S, First: M -> S, second word
  halt      # that's all


  org   0x0500
  cfw   0x7337
  cfw   0x2701
  cfw   0x1337
  cfw   0xBEEF


