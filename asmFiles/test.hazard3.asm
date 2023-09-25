
  #------------------------------------------------------------------
  # Test branch
  #------------------------------------------------------------------

org 0x0000
ori $1, $0, 0xdead
ori $2, $0, 0x0080
ori $3, $0, 0xEEEE
beq $1, $1, BRANCH_beqT
sw $1, 0($2)



BRANCH_beqT:
bne $1, $2, BRANCH_bneT
sw $1, 4($13)

BRANCH_bneT:
beq $1, $2, ERR // bne, nt
bne $1, $1, ERR // beq, nt
halt

ERR:
sw $1, 8($2)
halt
