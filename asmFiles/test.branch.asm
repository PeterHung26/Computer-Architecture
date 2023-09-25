org 0x0000
ori $1, $0, 0x0080
ori $2, $0, 0xBEEF
ori $3, $0, 0x0BAD
beq $1, $1, BRANCH_beqT
sw $3, 0($1)
sw $3, 4($1)
sw $3, 8($1)
sw $3, 12($1)
sw $3, 16($1)
halt




BRANCH_beqT:
bne $1, $2, BRANCH_bneT
sw $3, 20($1)
sw $3, 24($1)
sw $3, 28($1)
sw $3, 32($1)
sw $3, 36($1)
halt


BRANCH_bneT:
beq $1, $2, ERR // bne, nt
bne $1, $1, ERR // beq, nt
sw $2, 80($1)
halt


ERR:
sw $3, 40($1)
sw $3, 44($1)
sw $3, 48($1)
sw $3, 52($1)
sw $3, 56($1)
halt


















