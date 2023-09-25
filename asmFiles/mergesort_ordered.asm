#Mergesort for benchmarking
#Optimized for 512 bit I$ 1024 bit D$
#Author Adam Hendrickson ahendri@purdue.edu

org 0x0000
  ori   $fp, $zero, 0xFFFC
  ori   $sp, $zero, 0xFFFC
  ori   $a0, $zero, data
  lw    $s0, size($zero)
  ori   $t1, $0, 1
  srlv  $a1, $t1, $s0
  or    $s1, $zero, $a0
  or    $s2, $zero, $a1
  jal   insertion_sort
  halt //
  ori   $t1, $0, 1
  srlv  $t0, $t1, $s0
  subu  $a1, $s0, $t0
  ori   $t1, $0, 2
  sllv  $t0, $t1, $t0
  ori   $a0, $zero, data
  addu  $a0, $a0, $t0
  or    $s3, $zero, $a0
  or    $s4, $zero, $a1
  jal   insertion_sort
  or    $a0, $zero, $s1
  or    $a1, $zero, $s2
  or    $a2, $zero, $s3
  or    $a3, $zero, $s4
  ori   $t0, $zero, sorted
  push  $t0
  jal   merge
  addiu $sp, $sp, 4
  halt



#void insertion_sort(int* $a0, int $a1)
# $a0 : pointer to data start
# $a1 : size of array
#--------------------------------------
insertion_sort:
  ori   $t0, $zero, 4
  ori   $t2, $0, 2
  sllv  $t1, $t2, $a1
is_outer:
  sltu  $at, $t0, $t1
  beq   $at, $zero, is_end
  addu  $t9, $a0, $t0
  lw    $t8, 0($t9)
is_inner:
  beq   $t9, $a0, is_inner_end
  lw    $t7, -4($t9)
  slt   $at, $t8, $t7
  beq   $at, $zero, is_inner_end 
  sw    $t7, 0($t9)
  addiu $t9, $t9, -4
  j     is_inner
is_inner_end:
  sw    $t8, 0($t9)
  addiu $t0, $t0, 4
  j     is_outer
is_end:
  // halt //
  jr    $ra
#--------------------------------------

#void merge(int* $a0, int $a1, int* $a2, int $a3, int* dst)
# $a0 : pointer to list 1
# $a1 : size of list 1
# $a2 : pointer to list 2
# $a3 : size of list 2
# dst [$sp+4] : pointer to merged list location
#--------------------------------------
merge:
  lw    $t0, 0($sp)
m_1:
  bne   $a1, $zero, m_3
m_2:
  bne   $a3, $zero, m_3
  j     m_end
m_3:
  beq   $a3, $zero, m_4
  beq   $a1, $zero, m_5
  lw    $t1, 0($a0)
  lw    $t2, 0($a2)
  slt   $at, $t1, $t2
  beq   $at, $zero, m_3a
  sw    $t1, 0($t0)
  addiu $t0, $t0, 4
  addiu $a0, $a0, 4
  addiu $a1, $a1, -1
  j     m_1
m_3a:
  sw    $t2, 0($t0)
  addiu $t0, $t0, 4
  addiu $a2, $a2, 4
  addiu $a3, $a3, -1
  j     m_1
m_4:  #left copy
  lw    $t1, 0($a0)
  sw    $t1, 0($t0)
  addiu $t0, $t0, 4
  addiu $a1, $a1, -1
  addiu $a0, $a0, 4
  beq   $a1, $zero, m_end
  j     m_4
m_5:  # right copy
  lw    $t2, 0($a2)
  sw    $t2, 0($t0)
  addiu $t0, $t0, 4
  addiu $a3, $a3, -1
  addiu $a2, $a2, 4
  beq   $a3, $zero, m_end
  j     m_5
m_end:
  jr    $ra
#--------------------------------------


org 0x300
size:
cfw 64
data:
cfw 1
cfw 2
cfw 3
cfw 4
cfw 5
cfw 6
cfw 7
cfw 8
cfw 9
cfw 10
cfw 11
cfw 12
cfw 13
cfw 14
cfw 15
cfw 16
cfw 17
cfw 18
cfw 19
cfw 20
cfw 21
cfw 22
cfw 23
cfw 24
cfw 25
cfw 26
cfw 27
cfw 28
cfw 29
cfw 30
cfw 31
cfw 32
cfw 33
cfw 34
cfw 35
cfw 36
cfw 37
cfw 38
cfw 39
cfw 40
cfw 41
cfw 42
cfw 43
cfw 44
cfw 45
cfw 46
cfw 47
cfw 48
cfw 49
cfw 50
cfw 51
cfw 52
cfw 53
cfw 54
cfw 55
cfw 56
cfw 57
cfw 58
cfw 59
cfw 60
cfw 61
cfw 62
cfw 63
cfw 64

org 0x500
sorted: