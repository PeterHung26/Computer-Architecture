#----------------------------------------------------------
# First Processor
#----------------------------------------------------------
  org   0x0000              # first processor p0
  ori   $sp, $zero, 0x3ffc  # stack
  jal   mainp0              # go to program
  halt

mainp0:
  push $ra
  ori   $t7, $zero, 256     # 256 numbers
  ori   $t8, $zero, 0x3     # init seed 

PRODUCE_CRC32:
  or    $a0, $zero, $t8     # pass seed
  jal   crc32               # generate
  or    $t9, $zero, $v0     # crc32 return

  ori   $a0, $zero, la      # move lock to arguement register
  jal   lock                # try to aquire the lock
  or    $a0, $zero, $t9
  jal   PUSH_STACK
  ori   $a0, $zero, la      # move lock to arguement register
  jal   unlock              # release the lock

  or    $t8, $zero, $t9     # update seed
  addi  $t7, $t7, -1        # cnt --
  bne   $t7, $0, PRODUCE_CRC32

  pop   $ra
  jr    $ra                 #End of second processor

la:
  cfw 0x0


PUSH_STACK:
  ori   $t0, $zero, stackptr
  lw    $t1, 0($t0)                     
  ori   $t2, $zero, stackbase
  lw    $t3, 0($t2)                     
  sub   $t3, $t3, $t1                   
  sw    $a0, 0($t3)                    
  addi  $t1, $t1, 4                    
  sw    $t1, 0($t0)                    
  jr    $ra     

#----------------------------------------------------------
# Second Processor
#----------------------------------------------------------
  org   0x200              # second processor p1
  ori   $sp, $zero, 0x7ffc  # stack
  jal   mainp1              # go to program
  halt

mainp1:  
  push  $ra
  ori   $t7, $zero, 256      # 256 numbers
  ori   $s1, $zero, 0xFFFFFFFF  # init Min
  ori   $s2, $zero, 0x00000000  # init Max
  ori   $s3, $zero, 0           # init Sum

CONSUME: 
  jal   CHECK_STACK         # Check 

  ori   $a0, $zero, la      # move lock to arguement register
  jal   lock                # try to aquire the lock
  jal   POP_STACK
  or    $t8, $zero, $v0     # return value to t8
  ori   $a0, $zero, la      # move lock to arguement register
  jal   unlock              # release the lock

  # Update Min
  andi  $a0, $t8, 0x0000FFFF # lower bits
  andi  $a1, $s1, 0x0000FFFF # lower bits
  jal   min
  or    $s1, $zero, $v0     

  # Update Max
  andi  $a0, $t8, 0x0000FFFF # lower bits
  andi  $a1, $s2, 0x0000FFFF # lower bits
  jal   max
  or    $s2, $zero, $v0        

  # Add Sum
  andi  $t8, $t8, 0x0000FFFF # lower bits
  add   $s3, $s3, $t8       
  addi  $t7, $t7, -1        # cnt --
  bne   $t7, $zero, CONSUME

  # Calculate Mean
  or    $a0, $zero, $s3
  or    $a1, $zero, $t7
  jal   divide
  or    $s3, $zero, $v0     # quotient
  or    $s4, $zero, $v1     # remainder

OUTPUT:
  #store values to memory
  ori   $t0, $zero, result_avg
  sw    $s3, 0($t0)
  ori   $t0, $zero, result_max
  sw    $s2, 0($t0)
  ori   $t0, $zero, result_min
  sw    $s1, 0($t0)

  pop   $ra
  jr    $ra                 # End of second processor

res:
  cfw   0x0



CHECK_STACK:
  ori   $t0, $zero, stackptr
  lw    $t1, 0($t0)       
  beq   $t1, $zero, CHECK_STACK
  jr    $ra               

POP_STACK:
  ori   $t0, $zero, stackptr
  lw    $t1, 0($t0)  
  ori   $t2, $zero, stackbase
  lw    $t3, 0($t2) 
  addi  $t1, $t1, -4  
  sub   $t3, $t3, $t1 
  lw    $v0, 0($t3)  
  sw    $zero, 0($t3)
  sw    $t1, 0($t0)
  jr    $ra




###################################
#### LOCK / UNLOCK
###################################
# pass in an address to lock function in argument register 0
# returns when lock is available
lock:
aquire:
  ll    $t0, 0($a0)         # load lock location
  bne   $t0, $0, aquire     # wait on lock to be open
  addiu $t0, $t0, 1
  sc    $t0, 0($a0)
  beq   $t0, $0, lock       # if sc failed retry
  jr    $ra


# pass in an address to unlock function in argument register 0
# returns when lock is free
unlock:
  sw    $0, 0($a0)
  jr    $ra



###################################
#### CRC
###################################
#REGISTERS
#at $1 at
#v $2-3 function returns
#a $4-7 function args
#t $8-15 temps
#s $16-23 saved temps (callee preserved)
#t $24-25 temps
#k $26-27 kernel
#gp $28 gp (callee preserved)
#sp $29 sp (callee preserved)
#fp $30 fp (callee preserved)
#ra $31 return address

# USAGE random0 = crc(seed), random1 = crc(random0)
#       randomN = crc(randomN-1)
#------------------------------------------------------
# $v0 = crc32($a0)
crc32:
  lui $t1, 0x04C1
  ori $t1, $t1, 0x1DB7
  or $t2, $0, $0
  ori $t3, $0, 32

l1:
  slt $t4, $t2, $t3
  beq $t4, $zero, l2

  ori $t5, $0, 31
  srlv $t4, $t5, $a0
  ori $t5, $0, 1
  sllv $a0, $t5, $a0
  beq $t4, $0, l3
  xor $a0, $a0, $t1
l3:
  addiu $t2, $t2, 1
  j l1
l2:
  or $v0, $a0, $0
  jr $ra
#------------------------------------------------------




###################################
#### DIV
###################################
# registers a0-1,v0-1,t0
# a0 = Numerator
# a1 = Denominator
# v0 = Quotient
# v1 = Remainder

#-divide(N=$a0,D=$a1) returns (Q=$v0,R=$v1)--------
divide:               # setup frame
  push  $ra           # saved return address
  push  $a0           # saved register
  push  $a1           # saved register
  or    $v0, $0, $0   # Quotient v0=0
  or    $v1, $0, $a0  # Remainder t2=N=a0
  beq   $0, $a1, divrtn # test zero D
  slt   $t0, $a1, $0  # test neg D
  bne   $t0, $0, divdneg
  slt   $t0, $a0, $0  # test neg N
  bne   $t0, $0, divnneg
divloop:
  slt   $t0, $v1, $a1 # while R >= D
  bne   $t0, $0, divrtn
  addiu $v0, $v0, 1   # Q = Q + 1
  subu  $v1, $v1, $a1 # R = R - D
  j     divloop
divnneg:
  subu  $a0, $0, $a0  # negate N
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
  beq   $v1, $0, divrtn
  addiu $v0, $v0, -1  # return -Q-1
  j     divrtn
divdneg:
  subu  $a0, $0, $a1  # negate D
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
divrtn:
  pop $a1
  pop $a0
  pop $ra
  jr  $ra
#-divide--------------------------------------------



###################################
#### Min / MAX
###################################
# registers a0-1,v0,t0
# a0 = a
# a1 = b
# v0 = result

#-max (a0=a,a1=b) returns v0=max(a,b)--------------
max:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a0, $a1
  beq   $t0, $0, maxrtn
  or    $v0, $0, $a1
maxrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------

#-min (a0=a,a1=b) returns v0=min(a,b)--------------
min:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a1, $a0
  beq   $t0, $0, minrtn
  or    $v0, $0, $a1
minrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------



stackptr:
  cfw 0x0000

stackbase:
  cfw 0x9000

org 0xC000


result_avg:
  cfw 0xF0000
result_max:
  cfw 0xF0004
result_min:
  cfw 0xF0008
