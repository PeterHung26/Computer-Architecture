onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /request_unit_tb/CLK
add wave -noupdate -expand -group Case /request_unit_tb/PROG/tb_test_num
add wave -noupdate -expand -group Case /request_unit_tb/PROG/tb_test_case
add wave -noupdate -expand -group {Hit Signal} /request_unit_tb/ruif/dhit
add wave -noupdate -expand -group {Hit Signal} /request_unit_tb/ruif/ihit
add wave -noupdate -expand -group {Signal from Control Unit} /request_unit_tb/ruif/dread
add wave -noupdate -expand -group {Signal from Control Unit} /request_unit_tb/ruif/dwrite
add wave -noupdate -expand -group {Signal from Control Unit} /request_unit_tb/ruif/iread
add wave -noupdate -expand -group {Signal to Caches} /request_unit_tb/ruif/dmemWEN
add wave -noupdate -expand -group {Signal to Caches} /request_unit_tb/ruif/dmemREN
add wave -noupdate -expand -group {Signal to Caches} /request_unit_tb/ruif/imemREN
add wave -noupdate /request_unit_tb/ruif/datomic
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
WaveRestoreZoom {0 ns} {184 ns}
