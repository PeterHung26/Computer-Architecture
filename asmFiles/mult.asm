org 0x0000

MIAN:
    ori $29, $0, 0xFFFC
    ori $3, $0, 0x5
    ori $4, $0, 0xa
    push $3
    push $4


MULT:
    pop $5
    pop $6
    ori $7, $0, 0

LOOP:
    beq $6, $0, END
    add $7, $7, $5
    addi $6, $6, -1
    j LOOP

END:
    push $7
    halt
