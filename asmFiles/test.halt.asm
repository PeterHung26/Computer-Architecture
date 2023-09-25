org 0x0000
ori $1, $0, 0xCEEC
ori $2, $0, 20
ori $3, $0, 30
ori $4, $0, 40
ori $4, $0, 40
ori $4, $0, 40
ori $15, $0, 0x00F0
lui $9, 0xBEEF
sw $1, 0($15)
add $16, $2, $3
addi $17, $3, 44

halt

sw $1, 0($9)
