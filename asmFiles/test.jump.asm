org 0x0000
ori $1, $0, 1
ori $2, $0, 2
ori $3, $0, 3
ori $9, $0, 0x0080
jal JUMP1
sw $2, 4($9)
sw $2, 4($9)
sw $2, 4($9)
sw $2, 4($9)
sw $2, 4($9)
jal JUMP2
j END
sw $3, 16($9)
halt
sw $3, 20($9)



JUMP1:
sw $1, 0($9)
jr $31





END:
sw $3, 8($9)
halt

JUMP2:
jr $31
sw $3, 12($9)
