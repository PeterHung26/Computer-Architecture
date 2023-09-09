onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /program_counter_tb/CLK
add wave -noupdate /program_counter_tb/nRST
add wave -noupdate -expand -group Case /program_counter_tb/PROG/tb_test_num
add wave -noupdate -expand -group Case /program_counter_tb/PROG/tb_test_case
add wave -noupdate /program_counter_tb/pcif/ihit
add wave -noupdate -radix decimal /program_counter_tb/pcif/pcaddr
add wave -noupdate /program_counter_tb/pcif/nxt_pc
add wave -noupdate -expand -group Branch /program_counter_tb/pcif/Branch
add wave -noupdate -expand -group Branch -radix decimal /program_counter_tb/pcif/bimm
add wave -noupdate -expand -group {Jump or JAL} /program_counter_tb/pcif/Jump
add wave -noupdate -expand -group {Jump or JAL} -radix decimal /program_counter_tb/pcif/jimm
add wave -noupdate -expand -group JR /program_counter_tb/pcif/JR
add wave -noupdate -expand -group JR -radix decimal /program_counter_tb/pcif/jraddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {43 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 152
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
WaveRestoreZoom {0 ns} {1317 ns}
