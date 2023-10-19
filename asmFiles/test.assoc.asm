#--------------------------------------
# Test Associative
#--------------------------------------

    org   0x0000
    ori   $1, $zero, 0xDEAD
    ori   $2, $zero, 0xBADB
    ori   $3, $zero, 0x1000
    ori   $4, $zero, 0x2000
    sw    $1, 0($3)           #store first word
    sw    $2, 0($4)
    ori   $1, $zero, 0x8787
    ori   $2, $zero, 0x6666
    sw    $1, 1($3)          #store second word
    sw    $2, 1($4)
    lw    $1, 0($3)           #load first word
    lw    $2, 0($4)
    lw    $1, 1($3)           #load second word
    lw    $2, 1($4)
    halt
