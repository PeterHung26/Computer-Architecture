onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_unit_tb/PROG/testcase
add wave -noupdate /control_unit_tb/PROG/tb_test_case
add wave -noupdate /control_unit_tb/CLK
add wave -noupdate /control_unit_tb/nRST
add wave -noupdate /control_unit_tb/cuif/inst
add wave -noupdate /control_unit_tb/cuif/RegDst
add wave -noupdate /control_unit_tb/cuif/RegWrite
add wave -noupdate /control_unit_tb/cuif/Mem2Reg
add wave -noupdate /control_unit_tb/cuif/ALUSrc
add wave -noupdate /control_unit_tb/cuif/aluop
add wave -noupdate /control_unit_tb/cuif/PCSrc
add wave -noupdate /control_unit_tb/cuif/Jump2Reg
add wave -noupdate /control_unit_tb/cuif/Jump
add wave -noupdate /control_unit_tb/cuif/Jalink
add wave -noupdate /control_unit_tb/cuif/signExt
add wave -noupdate /control_unit_tb/cuif/dWEN
add wave -noupdate /control_unit_tb/cuif/dREN
add wave -noupdate /control_unit_tb/cuif/halt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 ns} 0}
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
WaveRestoreZoom {0 ns} {35 ns}
