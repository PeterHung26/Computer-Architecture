onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /extender_tb/CLK
add wave -noupdate -expand -group Case /extender_tb/PROG/tb_test_case
add wave -noupdate -expand -group Case /extender_tb/PROG/tb_test_num
add wave -noupdate /extender_tb/exif/imm
add wave -noupdate /extender_tb/exif/ExtOp
add wave -noupdate /extender_tb/exif/ext_imm
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
WaveRestoreZoom {0 ns} {5871 ns}
