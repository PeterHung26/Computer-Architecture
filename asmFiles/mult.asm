  org 0x0000
  ori $29, $0, 0xfffc //Initialize the stack pointer
  ori $1, $0, 0x0008 // Set first data
  ori $2, $0, 0x0002 // Set second data

  addi $29, $29, -4 // Push first data
  sw $1, 4($29)

  addi $29, $29, -4 // Push second data
  sw $2, 4($29)

  LOAD_DATA:
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
  halt 

