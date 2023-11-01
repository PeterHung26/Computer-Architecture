#------------------------------------------------------------------
# Test MSI protocol
#------------------------------------------------------------------

# First processor
  org   0x0000
  ori   $1, $zero, 0x500
  lw    $2, 0($1) # First: I -> S, Second: I -> I, first word
  lw    $3, 4($1) # First: I -> S, Second: I -> I, second word
  nop
  nop
  nop
  nop
  nop
  lw    $4, 8($1) # First: I -> S, Second: S -> S, first word
  lw    $5, 16($1) # First: I -> S, Second: S -> S, second word
  nop
  nop
  nop
  nop
  nop
  ori   $6, $zero, 0x400
  ori   $7, $zero, 0x600
  sw    $6, 0($1) # First: S -> M, Second: S -> I, first word
  sw    $7, 4($1) # First: S -> M, Second: S -> I, first word
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
  lw    $6, 0($1) # First: I -> S, Second: M -> S, first word
  lw    $7, 4($1) # First: I -> S, Second: M -> S, second word
  nop
  nop
  nop
  nop
  halt      # that's all

# Second processor
  org   0x0200
  ori   $1, $zero, 0x500
  lw    $2, 8($1) # Second: I -> S, First: I -> I, first word
  lw    $3, 16($1) # Second: I -> S, First: I -> I, second word
  nop
  nop
  nop
  nop
  nop
  lw    $4, 0($1) # Second: I -> S, First: S -> S, first word
  lw    $5, 4($1) # Second: I -> S, First: S -> S, second word
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
  ori   $6, $zero, 0x8787
  ori   $7, $zero, 0x9999
  sw    $6, 0($1) # Second: I -> M, First: M -> I, first word
  sw    $7, 4($1) # Second: I -> M, First: M -> I, first word
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


