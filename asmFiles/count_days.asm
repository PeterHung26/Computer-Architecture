  org 0x0000
  ori $29, $0, 0xfffc //Initialize the stack pointer
  MAIN:
  ori $6, $0, 22 // Set Day
  ori $7, $0, 8 // Set Month
  ori $8, $0, 2023 // Set Year

  addi $1, $7, -1
  ori $2, $0, 30
  addi $29, $29, -4 // Push Month-1
  sw $1, 4($29)
  addi $29, $29, -4 // Push 30
  sw $2, 4($29)
  jal START
  lw $7, 4($29) // Pop result out
  addi $29, $29, 4
  
  addi $1, $8, -2000
  ori $2, $0, 365
  addi $29, $29, -4 // Push Year-2000
  sw $1, 4($29)
  addi $29, $29, -4 // Push 365
  sw $2, 4($29)
  jal START
  lw $8, 4($29) // Pop result out
  addi $29, $29, 4
  
  add $1, $6, $7
  add $1, $1, $8
  halt


  START:
  ori $5, $0, 0xfff8 // Set register 5 as fff8 to decide when to end
  beq $29, $5, DONE

  lw $1, 4($29) // Pop first data
  addi $29, $29, 4

  lw $2, 4($29) // Pop second data
  addi $29, $29, 4
  
  ori $3, $0, 0x0000 // Set register 3 to 0 for later use

  MUL:
  beq $2, $0, EXIT
  add $3, $1, $3
  addi $2, $2, -1
  j MUL

  EXIT:
  addi $29, $29, -4 // Push the result
  sw $3, 4($29)
  j START

  DONE:
  jr $31
