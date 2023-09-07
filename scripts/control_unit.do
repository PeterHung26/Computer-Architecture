onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_unit_tb/CLK
add wave -noupdate -expand -group {Test Case} /control_unit_tb/PROG/tb_test_num
add wave -noupdate -expand -group {Test Case} /control_unit_tb/PROG/tb_test_case
add wave -noupdate -expand -group {Instruction Input} /control_unit_tb/cuif/opcode
add wave -noupdate -expand -group {Instruction Input} /control_unit_tb/cuif/funct
add wave -noupdate -expand -group {Instruction Input} /control_unit_tb/cuif/shamt
add wave -noupdate -expand -group {ALU Flag} /control_unit_tb/cuif/zero
add wave -noupdate -expand -group {ALU Flag} /control_unit_tb/cuif/negative
add wave -noupdate -expand -group {ALU Flag} /control_unit_tb/cuif/overflow
add wave -noupdate -expand -group Branch /control_unit_tb/cuif/Equal
add wave -noupdate -expand -group Branch /control_unit_tb/cuif/Branch
add wave -noupdate -expand -group {Register File} /control_unit_tb/cuif/RegDst
add wave -noupdate -expand -group {Register File} /control_unit_tb/cuif/RegWr
add wave -noupdate /control_unit_tb/cuif/ExtOp
add wave -noupdate /control_unit_tb/cuif/ALUSrc
add wave -noupdate /control_unit_tb/cuif/ALUCtr
add wave -noupdate /control_unit_tb/cuif/MemtoReg
add wave -noupdate /control_unit_tb/cuif/Jump
add wave -noupdate /control_unit_tb/cuif/JR
add wave -noupdate /control_unit_tb/cuif/JumpReg
add wave -noupdate /control_unit_tb/cuif/LUI
add wave -noupdate /control_unit_tb/cuif/LDsel
add wave -noupdate /control_unit_tb/cuif/SVsel
add wave -noupdate -expand -group {Read and Write Enable} /control_unit_tb/cuif/iread
add wave -noupdate -expand -group {Read and Write Enable} /control_unit_tb/cuif/dread
add wave -noupdate -expand -group {Read and Write Enable} /control_unit_tb/cuif/dwrite
add wave -noupdate -expand -group Halt /control_unit_tb/cuif/halt
add wave -noupdate -expand -group Halt /control_unit_tb/cuif/flushed
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ns} {17282 ns}
