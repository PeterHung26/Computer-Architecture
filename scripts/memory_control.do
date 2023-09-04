onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_control_tb/CLK
add wave -noupdate /memory_control_tb/nRST
add wave -noupdate /memory_control_tb/PROG/tb_test_num
add wave -noupdate /memory_control_tb/PROG/tb_test_case
add wave -noupdate /memory_control_tb/PROG/cif0/iREN
add wave -noupdate /memory_control_tb/PROG/cif0/dREN
add wave -noupdate /memory_control_tb/PROG/cif0/dWEN
add wave -noupdate /memory_control_tb/PROG/ramif/ramREN
add wave -noupdate /memory_control_tb/PROG/ramif/ramWEN
add wave -noupdate /memory_control_tb/PROG/cif0/iaddr
add wave -noupdate /memory_control_tb/PROG/cif0/daddr
add wave -noupdate /memory_control_tb/PROG/ramif/ramaddr
add wave -noupdate /memory_control_tb/PROG/cif0/dstore
add wave -noupdate /memory_control_tb/PROG/ramif/ramstore
add wave -noupdate /memory_control_tb/PROG/cif0/iload
add wave -noupdate /memory_control_tb/PROG/cif0/dload
add wave -noupdate /memory_control_tb/PROG/ramif/ramload
add wave -noupdate /memory_control_tb/PROG/cif0/iwait
add wave -noupdate /memory_control_tb/PROG/cif0/dwait
add wave -noupdate /memory_control_tb/PROG/ramif/ramstate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {371412 ps}
