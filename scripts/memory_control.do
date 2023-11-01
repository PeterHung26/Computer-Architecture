onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /memory_control_tb/PROG/tb_test_num
add wave -noupdate /memory_control_tb/PROG/tb_test_case
add wave -noupdate /memory_control_tb/CLK
add wave -noupdate /memory_control_tb/nRST
add wave -noupdate -expand -group RAMIF -group Next /memory_control_tb/DUT/nxt_state
add wave -noupdate -expand -group RAMIF -group Next /memory_control_tb/DUT/nxt_snooper
add wave -noupdate -expand -group RAMIF -group Next /memory_control_tb/DUT/nxt_snoopied
add wave -noupdate -expand -group RAMIF /memory_control_tb/PROG/ramif/ramREN
add wave -noupdate -expand -group RAMIF /memory_control_tb/PROG/ramif/ramWEN
add wave -noupdate -expand -group RAMIF /memory_control_tb/PROG/ramif/ramaddr
add wave -noupdate -expand -group RAMIF -color {Lime Green} /memory_control_tb/PROG/ramif/ramstore
add wave -noupdate -expand -group RAMIF /memory_control_tb/PROG/ramif/ramload
add wave -noupdate -expand -group RAMIF /memory_control_tb/PROG/ramif/ramstate
add wave -noupdate -color Gray80 /memory_control_tb/DUT/state
add wave -noupdate -color Gray80 /memory_control_tb/DUT/snooper
add wave -noupdate -color Gray80 /memory_control_tb/DUT/snoopied
add wave -noupdate -expand /memory_control_tb/ccif/dREN
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/iwait
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/dwait
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/iREN
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/dREN
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/dWEN
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/cctrans
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/ccwrite
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/iload
add wave -noupdate -expand -group CIF0 -color {Medium Slate Blue} /memory_control_tb/PROG/cif0/dload
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/dstore
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/iaddr
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/daddr
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/ccwait
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/ccinv
add wave -noupdate -expand -group CIF0 -color Cyan /memory_control_tb/PROG/cif0/ccsnoopaddr
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/iwait
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/dwait
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/iREN
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/dREN
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/dWEN
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/cctrans
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/ccwrite
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/iload
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/dload
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/dstore
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/iaddr
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/daddr
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/ccwait
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/ccinv
add wave -noupdate -expand -group CIF1 -color Yellow /memory_control_tb/PROG/cif1/ccsnoopaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {225291 ps} 0}
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
WaveRestoreZoom {190413 ps} {363663 ps}
