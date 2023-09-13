onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/syif/tbCTRL
add wave -noupdate /system_tb/DUT/syif/halt
add wave -noupdate /system_tb/DUT/syif/load
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramREN
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramWEN
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramaddr
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramstore
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramload
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramstate
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/MemtoReg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/Branch
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/Jump
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/JR
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/RegWr
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ALUCtr
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/JumpReg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/LUI
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/LDsel
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/SVsel
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/Equal
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/funct
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/iread
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dread
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dwrite
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/haltt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/zero
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/negative
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/overflow
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/datomic
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/dmemWEN
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/dmemREN
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/imemREN
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/dhit
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/ihit
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/dread
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/dwrite
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/iread
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/negative
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/overflow
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/zero
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/porta
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/portb
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/portout
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/aluop
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/WEN
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wsel
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel2
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wdat
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat2
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/Branch
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/Jump
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/JR
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/ihit
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/bimm
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/jimm
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/jraddr
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/nxt_pc
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/pcaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {131991 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1160096 ps}
