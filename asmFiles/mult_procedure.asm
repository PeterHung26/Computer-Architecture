org 0x0000

MAIN:
    ori $29, $0, 0xFFFC
    ori $3, $0, 2
    ori $4, $0, 4
    ori $5, $0, 6
    ori $6, $0, 1
    addi $28, $29, -4
    push $3
    push $4
    push $5
    push $6
    jal MULT_PROC



MULT_PROC:
    beq $29, $28, END2
    j MULT

END2:
    halt


# mult
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
    j MULT_PROC
