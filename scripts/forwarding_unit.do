onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /forwarding_unit_tb/PROG/CLK
add wave -noupdate -expand -group Case /forwarding_unit_tb/PROG/tb_test_num
add wave -noupdate -expand -group Case /forwarding_unit_tb/PROG/tb_test_case
add wave -noupdate -expand -group {Input signal} /forwarding_unit_tb/fuif/ID_rs
add wave -noupdate -expand -group {Input signal} /forwarding_unit_tb/fuif/ID_rt
add wave -noupdate -expand -group {Input signal} /forwarding_unit_tb/fuif/EX_wsel
add wave -noupdate -expand -group {Input signal} /forwarding_unit_tb/fuif/MEM_wsel
add wave -noupdate -expand -group {Input signal} /forwarding_unit_tb/fuif/EX_RegWrite
add wave -noupdate -expand -group {Input signal} /forwarding_unit_tb/fuif/MEM_RegWrite
add wave -noupdate -expand -group {Output signal} /forwarding_unit_tb/fuif/forwarda
add wave -noupdate -expand -group {Output signal} /forwarding_unit_tb/fuif/forwardb
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
WaveRestoreZoom {0 ns} {5943 ns}
