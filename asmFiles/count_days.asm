org 0x0000

MAIN:
    ori $29, $0, 0xFFFC
    ori $2, $0, 22
    ori $3, $0, 8
    ori $4, $0, 2023



CALC:
    add $3


# month
    addi $5, $3, -1
    ori $6, $0, 30
    addi $28, $29, -4
    push $5
    push $6
    jal MULT_PROC
    pop $20

# year
    and $5, $5, $0
    and $6, $6, $0

    addi $5, $4, -2000
    ori $6, $0, 365
    addi $28, $29, -4
    push $5
    push $6
    jal MULT_PROC
    pop $21

# sum days
    add $22, $20, $21    
    add $22, $22, $2

EXIT:
    halt



# MULT_PROC
MULT_PROC:
    beq $29, $28, END2
    j MULT

END2:
    jr $31

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
