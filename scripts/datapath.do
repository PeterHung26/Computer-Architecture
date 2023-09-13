onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath_tb/CLK
add wave -noupdate /datapath_tb/nRST
add wave -noupdate -expand -group Case /datapath_tb/PROG/tb_test_num
add wave -noupdate -expand -group Case /datapath_tb/PROG/tb_test_case
add wave -noupdate -expand -group {Read and Write} /datapath_tb/dpif/imemREN
add wave -noupdate -expand -group {Read and Write} /datapath_tb/dpif/dmemREN
add wave -noupdate -expand -group {Read and Write} /datapath_tb/dpif/dmemWEN
add wave -noupdate -expand -group hit /datapath_tb/dpif/ihit
add wave -noupdate -expand -group hit /datapath_tb/dpif/dhit
add wave -noupdate /datapath_tb/dpif/imemload
add wave -noupdate /datapath_tb/dpif/imemaddr
add wave -noupdate -radix decimal /datapath_tb/dpif/dmemload
add wave -noupdate -radix decimal /datapath_tb/dpif/dmemaddr
add wave -noupdate -radix decimal /datapath_tb/dpif/dmemstore
add wave -noupdate /datapath_tb/dpif/halt
add wave -noupdate /datapath_tb/dpif/flushed
add wave -noupdate /datapath_tb/dpif/datomic
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {35 ns} 0}
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
WaveRestoreZoom {0 ns} {186 ns}
