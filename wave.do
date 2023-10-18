onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/syif/tbCTRL
add wave -noupdate /system_tb/DUT/syif/halt
add wave -noupdate /system_tb/DUT/syif/load
add wave -noupdate -group CIF /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -group CIF /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -group CIF /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -group CIF /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -group CIF /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -group CIF /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -group CIF /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -group CIF /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -group CIF /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -group CIF /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -group CIF /system_tb/DUT/CPU/cif0/ccsnoopaddr
add wave -noupdate -group DCIF /system_tb/DUT/CPU/dcif/halt
add wave -noupdate -group DCIF /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -group DCIF /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -group DCIF /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -group DCIF /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate -group DCIF /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -group DCIF /system_tb/DUT/CPU/dcif/datomic
add wave -noupdate -group DCIF /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -group DCIF /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -group DCIF /system_tb/DUT/CPU/dcif/flushed
add wave -noupdate -group DCIF /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate -group DCIF /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate -group DCIF /system_tb/DUT/CPU/dcif/dmemaddr
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/iframes
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/CLK
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/nRST
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/tag
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/idx
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/imiss
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/state
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/state_nxt
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramREN
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramWEN
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramaddr
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramstore
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramload
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramstate
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/MemtoReg
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/Jump
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/JR
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/RegWr
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ALUCtr
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/JumpReg
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/LUI
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/funct
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dread
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dwrite
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/negative
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/overflow
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/zero
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/porta
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/portb
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/portout
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/aluop
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/WEN
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wsel
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel1
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel2
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wdat
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat1
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat2
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/PC_EN
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/Jump
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/JR
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/bimm
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/jimm
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/jraddr
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/nxt_pc
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/pcaddr
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/dhit
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/ihit
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/cu_halt
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/cu_Jump
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/ID_JR
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/ID_dread
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/PCSrc
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/ID_rt
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/IF_rs
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/IF_rt
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/IF_EN
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/ID_EN
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/EX_EN
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/MEM_EN
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/IF_FLUSH
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/ID_FLUSH
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/EX_FLUSH
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/MEM_FLUSH
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/PC_EN
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/iREN
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/pr_halt
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_instr_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_instr
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_pc4
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_pc4_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_pc4
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_RegDst
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_RegWrite
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_MemtoReg
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_dread
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_dwrite
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_BEQ
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_BNE
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_JumpReg
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ExtOP
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ALUSrc
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_LUI
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ALUCtr
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rdat1
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rdat2
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rs
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rt
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rd
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_imm16
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_halt
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_JR
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_pc4_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_RegDst_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_RegWrite_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_MemtoReg_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_dread_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_dwrite_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_BEQ_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_BNE_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_JumpReg_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ExtOP_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ALUSrc_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_LUI_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ALUCtr_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rdat1_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rdat2_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rs_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rt_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rd_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_imm16_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_halt_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_JR_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_pc4
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_JumpReg
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_BEQ
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_BNE
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_MemtoReg
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_RegWrite
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dread
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dwrite
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_zero
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_portout
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_ext_imm_16
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_wsel
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_halt
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dmemstore
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_pc4_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_JumpReg_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_BEQ_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_BNE_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_MemtoReg_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_RegWrite_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dread_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dwrite_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_zero_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_portout_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_ext_imm_16_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_wsel_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_halt_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dmemstore_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_pc4
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_JumpReg
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_MemtoReg
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_RegWrite
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_dmemload
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_portout
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_wsel
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_halt
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_pc4_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_JumpReg_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_MemtoReg_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_RegWrite_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_dmemload_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_portout_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_wsel_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_halt_in
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_FLUSH
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_FLUSH
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_FLUSH
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_FLUSH
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_EN
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_EN
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_EN
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_EN
add wave -noupdate -expand -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/halt
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/ID_rs
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/ID_rt
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/EX_wsel
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/MEM_wsel
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/EX_RegWrite
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/MEM_RegWrite
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/forwarda
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/forwardb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {64121 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 200
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
WaveRestoreZoom {0 ps} {1126426 ps}
