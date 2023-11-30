#----------------------------------------------------------
# First Processor
#----------------------------------------------------------
  org   0x0000              # first processor p0
  ori   $sp, $0, 0x3ffc     # stack
  ori   $s4, $0, 0x0500     # offset
  ori   $t9, $0, 0x1000     # lock   
  ori   $t6, $0, 256        # numbers count
  ori   $t8, $0, 7          # init seed
  
PRODUCE:
  ori   $a0, $t8, 0
  jal   crc32

  or    $a0, $0, $t9        # move lock to arguement register
  jal   lock                # try to aquire the lock
  lw    $s5, 0($s4)
  addi  $s5, $s5, 4
  sw    $v0, 0($s5)
  ori   $t8, $v0, 0 
  sw    $s5, 0($s4)
  or    $a0, $0, $t9        # move lock to arguement register
  jal   unlock              # release the lock

  addi $t6, $t6, -1
  bne $t6, $0, PRODUCE      # cnt--

EXIT0:
  halt


#----------------------------------------------------
#Second Processor
#----------------------------------------------------
  org   0x0200               # second processor p1
  ori   $sp, $0, 0x3ffc      # stack
  ori   $s4, $0, 0x0500      # offset
  ori   $t9, $0, 0x1000      # lock   
  ori   $t6, $0, 256         # numbers count
  
  ori   $k1, $0, 0           # SUM
  ori   $s0, $0, 0           # max
  ori   $s1, $0, 0xFFFF      # min
  ori   $s2, $0, 0           # sum -> average

   
  j CONSUME

EMPTY:
  or    $a0, $0, $t9      # move lock to arguement register
  jal   unlock

CONSUME:
  or    $a0, $0, $t9      # move lock to arguement register
  jal   lock
  lw    $s5, 0($s4)
  beq   $s5, $s4, EMPTY

  lw    $t7, 0($s5)
  addi  $s5, $s5, -4
  sw    $s5, 0($s4) 
  or    $a0, $0, $t9      # move lock to arguement register
  jal   unlock


  # Update Min
  andi  $a0, $t7, 0x0000FFFF # lower bits
  andi  $a1, $s0, 0x0000FFFF # lower bits
  jal   max
  or    $s0, $0, $v0    

  # Update Min
  andi  $a0, $t7, 0x0000FFFF # lower bits
  andi  $a1, $s1, 0x0000FFFF # lower bits
  jal   min
  or    $s1, $0, $v0    

  # Add Sum
  andi  $t7, $t7, 0x0000FFFF # lower bits
  add   $s2, $s2, $t7       

  addi  $t6, $t6, -1
  bne   $t6, $0, CONSUME     # cnt--

  # Divide
  ori   $a0, $s2, 0
  ori   $a1, $0, 256
  jal   divide
  or    $s2, $0, $v0


EXIT1:
  halt



#----------------------------------------------------------
# LOCK / UNLOCK
#----------------------------------------------------------
#Lock
lock:
aquire:
  ll    $t0, 0($a0)         # load lock location
  bne   $t0, $0, aquire     # wait on lock to be open
  addiu $t0, $t0, 1
  sc    $t0, 0($a0)
  beq   $t0, $0, lock       # if sc failed retry
  jr    $ra
#------------------------------------------------------

#------------------------------------------------------
unlock:
  sw    $0, 0($t9)
  jr    $ra
#------------------------------------------------------

#------------------------------------------------------
# $v0 = crc32($a0)
crc32:
  lui $t1, 0x04C1
  ori $t1, $t1, 0x1DB7
  or $t2, $0, $0
  ori $t3, $0, 32

l1:
  slt $t4, $t2, $t3
  beq $t4, $0, l2

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

org 0x0500
cfw 0x0500
