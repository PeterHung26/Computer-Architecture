onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hazard_unit_tb/PROG/testcase
add wave -noupdate /hazard_unit_tb/PROG/tb_test_case
add wave -noupdate /hazard_unit_tb/CLK
add wave -noupdate /hazard_unit_tb/nRST
add wave -noupdate /hazard_unit_tb/huif/ForwardA
add wave -noupdate /hazard_unit_tb/huif/ForwardB
add wave -noupdate /hazard_unit_tb/huif/ForwardSW
add wave -noupdate /hazard_unit_tb/huif/StallLW
add wave -noupdate /hazard_unit_tb/huif/IDEX_rd
add wave -noupdate /hazard_unit_tb/huif/IDEX_rs
add wave -noupdate /hazard_unit_tb/huif/IDEX_rt
add wave -noupdate /hazard_unit_tb/huif/EXMEM_rd
add wave -noupdate /hazard_unit_tb/huif/MEMWB_rd
add wave -noupdate /hazard_unit_tb/huif/IDEX_RegWrite
add wave -noupdate /hazard_unit_tb/huif/IDEX_dREN
add wave -noupdate /hazard_unit_tb/huif/EXMEM_dREN
add wave -noupdate /hazard_unit_tb/huif/MEMWB_dREN
add wave -noupdate /hazard_unit_tb/huif/EXMEM_RegWrite
add wave -noupdate /hazard_unit_tb/huif/MEMWB_RegWrite
add wave -noupdate /hazard_unit_tb/huif/IDEX_dWEN
add wave -noupdate /hazard_unit_tb/huif/EXMEM_dWEN
add wave -noupdate /hazard_unit_tb/huif/MEMWB_dWEN
add wave -noupdate /hazard_unit_tb/huif/IFID_rt
add wave -noupdate /hazard_unit_tb/huif/IFID_rs
add wave -noupdate /hazard_unit_tb/huif/IFID_opc
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
WaveRestoreZoom {0 ns} {1 us}
