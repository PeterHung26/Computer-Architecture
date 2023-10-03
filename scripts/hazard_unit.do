onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hazard_unit_tb/CLK
add wave -noupdate /hazard_unit_tb/nRST
add wave -noupdate -expand -group Case /hazard_unit_tb/PROG/tb_test_num
add wave -noupdate -expand -group Case /hazard_unit_tb/PROG/tb_test_case
add wave -noupdate -expand -group {Input signal} /hazard_unit_tb/huif/dhit
add wave -noupdate -expand -group {Input signal} /hazard_unit_tb/huif/ihit
add wave -noupdate -expand -group {Input signal} /hazard_unit_tb/huif/cu_halt
add wave -noupdate -expand -group {Input signal} /hazard_unit_tb/huif/cu_Jump
add wave -noupdate -expand -group {Input signal} /hazard_unit_tb/huif/ID_JR
add wave -noupdate -expand -group {Input signal} /hazard_unit_tb/huif/ID_dread
add wave -noupdate -expand -group {Input signal} /hazard_unit_tb/huif/PCSrc
add wave -noupdate -expand -group {Input signal} /hazard_unit_tb/huif/ID_rt
add wave -noupdate -expand -group {Input signal} /hazard_unit_tb/huif/IF_rs
add wave -noupdate -expand -group {Input signal} /hazard_unit_tb/huif/IF_rt
add wave -noupdate -expand -group {Output signal} /hazard_unit_tb/huif/IF_EN
add wave -noupdate -expand -group {Output signal} /hazard_unit_tb/huif/ID_EN
add wave -noupdate -expand -group {Output signal} /hazard_unit_tb/huif/EX_EN
add wave -noupdate -expand -group {Output signal} /hazard_unit_tb/huif/MEM_EN
add wave -noupdate -expand -group {Output signal} /hazard_unit_tb/huif/IF_FLUSH
add wave -noupdate -expand -group {Output signal} /hazard_unit_tb/huif/ID_FLUSH
add wave -noupdate -expand -group {Output signal} /hazard_unit_tb/huif/EX_FLUSH
add wave -noupdate -expand -group {Output signal} /hazard_unit_tb/huif/MEM_FLUSH
add wave -noupdate -expand -group {Output signal} /hazard_unit_tb/huif/PC_EN
add wave -noupdate -expand -group {Output signal} /hazard_unit_tb/huif/iREN
add wave -noupdate -expand -group {Output signal} /hazard_unit_tb/huif/pr_halt
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
