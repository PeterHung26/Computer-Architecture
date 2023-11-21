onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/syif/halt
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramREN
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramWEN
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramaddr
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramstore
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramload
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramstate
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/CLK
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/nRST
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/have1
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/have2
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/nxt_state
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/state
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/snooper
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/snoopied
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/nxt_snooper
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/nxt_snoopied
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/snooptag
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/snoopindex
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/grant
add wave -noupdate -expand -group {Memory Controller} /system_tb/DUT/CPU/CC/nxt_grant
add wave -noupdate -expand -group ICache1 /system_tb/DUT/CPU/CM0/ICACHE/CLK
add wave -noupdate -expand -group ICache1 /system_tb/DUT/CPU/CM0/ICACHE/nRST
add wave -noupdate -expand -group ICache1 /system_tb/DUT/CPU/CM0/ICACHE/tag
add wave -noupdate -expand -group ICache1 /system_tb/DUT/CPU/CM0/ICACHE/idx
add wave -noupdate -expand -group ICache1 /system_tb/DUT/CPU/CM0/ICACHE/imiss
add wave -noupdate -expand -group ICache1 /system_tb/DUT/CPU/CM0/ICACHE/state
add wave -noupdate -expand -group ICache1 /system_tb/DUT/CPU/CM0/ICACHE/state_nxt
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/CLK
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/nRST
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/have
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/cache
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/nxt_cache
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/respond_nxt_cache
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/tag
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/index
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/offset
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/snoop_tag
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/snoop_index
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/snoop_offset
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/nxt_state
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/state
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/nxt_cstate
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/cstate
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/reply_done
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/s_i
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/m_s
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/m_i
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/nxt_s_i
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/nxt_m_s
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/nxt_m_i
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/miss
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/way
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/cmiss
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/cway
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/halt_cnt
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/nxt_halt_cnt
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/halt_cnt_wb
add wave -noupdate -group DCache1 /system_tb/DUT/CPU/CM0/DCACHE/j
add wave -noupdate -group ICahce2 /system_tb/DUT/CPU/CM1/ICACHE/CLK
add wave -noupdate -group ICahce2 /system_tb/DUT/CPU/CM1/ICACHE/nRST
add wave -noupdate -group ICahce2 /system_tb/DUT/CPU/CM1/ICACHE/iframes
add wave -noupdate -group ICahce2 /system_tb/DUT/CPU/CM1/ICACHE/tag
add wave -noupdate -group ICahce2 /system_tb/DUT/CPU/CM1/ICACHE/idx
add wave -noupdate -group ICahce2 /system_tb/DUT/CPU/CM1/ICACHE/imiss
add wave -noupdate -group ICahce2 /system_tb/DUT/CPU/CM1/ICACHE/state
add wave -noupdate -group ICahce2 /system_tb/DUT/CPU/CM1/ICACHE/state_nxt
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/CLK
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/nRST
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/have
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/cache
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/nxt_cache
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/respond_nxt_cache
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/tag
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/index
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/offset
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/snoop_tag
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/snoop_index
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/snoop_offset
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/nxt_state
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/state
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/nxt_cstate
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/cstate
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/reply_done
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/s_i
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/m_s
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/m_i
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/nxt_s_i
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/nxt_m_s
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/nxt_m_i
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/miss
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/way
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/cmiss
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/cway
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/halt_cnt
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/nxt_halt_cnt
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/halt_cnt_wb
add wave -noupdate -group DCache2 /system_tb/DUT/CPU/CM1/DCACHE/j
add wave -noupdate -group ccif -expand /system_tb/DUT/CPU/CC/ccif/iwait
add wave -noupdate -group ccif -expand /system_tb/DUT/CPU/CC/ccif/dwait
add wave -noupdate -group ccif -expand /system_tb/DUT/CPU/CC/ccif/iREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/iload
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dload
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/dstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/iaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/daddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ccwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ccinv
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ccwrite
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/cctrans
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ccsnoopaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramstate
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/CC/ccif/ramload
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM0/dcif/halt
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM0/dcif/ihit
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM0/dcif/imemREN
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM0/dcif/imemload
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM0/dcif/imemaddr
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM0/dcif/dhit
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM0/dcif/datomic
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM0/dcif/dmemREN
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM0/dcif/dmemWEN
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM0/dcif/flushed
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM0/dcif/dmemload
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM0/dcif/dmemstore
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM0/dcif/dmemaddr
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/iwait
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/dwait
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/iREN
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/dREN
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/dWEN
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/iload
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/dload
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/dstore
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/iaddr
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/daddr
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/ccwait
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/ccinv
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/ccwrite
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/cctrans
add wave -noupdate -group dif1 /system_tb/DUT/CPU/CM0/cif/ccsnoopaddr
add wave -noupdate -group dcif2 /system_tb/DUT/CPU/CM1/dcif/halt
add wave -noupdate -group dcif2 /system_tb/DUT/CPU/CM1/dcif/ihit
add wave -noupdate -group dcif2 /system_tb/DUT/CPU/CM1/dcif/imemREN
add wave -noupdate -group dcif2 /system_tb/DUT/CPU/CM1/dcif/imemload
add wave -noupdate -group dcif2 /system_tb/DUT/CPU/CM1/dcif/imemaddr
add wave -noupdate -group dcif2 /system_tb/DUT/CPU/CM1/dcif/dhit
add wave -noupdate -group dcif2 /system_tb/DUT/CPU/CM1/dcif/datomic
add wave -noupdate -group dcif2 /system_tb/DUT/CPU/CM1/dcif/dmemREN
add wave -noupdate -group dcif2 /system_tb/DUT/CPU/CM1/dcif/dmemWEN
add wave -noupdate -group dcif2 /system_tb/DUT/CPU/CM1/dcif/flushed
add wave -noupdate -group dcif2 /system_tb/DUT/CPU/CM1/dcif/dmemload
add wave -noupdate -group dcif2 /system_tb/DUT/CPU/CM1/dcif/dmemstore
add wave -noupdate -group dcif2 /system_tb/DUT/CPU/CM1/dcif/dmemaddr
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/iwait
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/dwait
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/iREN
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/dREN
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/dWEN
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/iload
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/dload
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/dstore
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/iaddr
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/daddr
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/ccwait
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/ccinv
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/ccwrite
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/cctrans
add wave -noupdate -group dif2 /system_tb/DUT/CPU/CM1/cif/ccsnoopaddr
add wave -noupdate -expand -group {Program Counter 1} /system_tb/DUT/CPU/DP0/PC/pcif/PCSrc
add wave -noupdate -expand -group {Program Counter 1} /system_tb/DUT/CPU/DP0/PC/pcif/Jump
add wave -noupdate -expand -group {Program Counter 1} /system_tb/DUT/CPU/DP0/PC/pcif/JR
add wave -noupdate -expand -group {Program Counter 1} /system_tb/DUT/CPU/DP0/PC/pcif/PC_EN
add wave -noupdate -expand -group {Program Counter 1} /system_tb/DUT/CPU/DP0/PC/pcif/bimm
add wave -noupdate -expand -group {Program Counter 1} /system_tb/DUT/CPU/DP0/PC/pcif/jimm
add wave -noupdate -expand -group {Program Counter 1} /system_tb/DUT/CPU/DP0/PC/pcif/jraddr
add wave -noupdate -expand -group {Program Counter 1} /system_tb/DUT/CPU/DP0/PC/pcif/branch_pc
add wave -noupdate -expand -group {Program Counter 1} /system_tb/DUT/CPU/DP0/PC/pcif/nxt_pc
add wave -noupdate -expand -group {Program Counter 1} /system_tb/DUT/CPU/DP0/PC/pcif/pcaddr
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/ExtOp
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/ALUSrc
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/MemtoReg
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/BEQ
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/BNE
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/Jump
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/JR
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/RegDst
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/RegWr
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/ALUCtr
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/JumpReg
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/LUI
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/opcode
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/funct
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/shamt
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/dread
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/dwrite
add wave -noupdate -group {Control Unit 1} /system_tb/DUT/CPU/DP0/CU/cuif/halt
add wave -noupdate -group {ALU 1} /system_tb/DUT/CPU/DP0/ALU/aluif/negative
add wave -noupdate -group {ALU 1} /system_tb/DUT/CPU/DP0/ALU/aluif/overflow
add wave -noupdate -group {ALU 1} /system_tb/DUT/CPU/DP0/ALU/aluif/zero
add wave -noupdate -group {ALU 1} /system_tb/DUT/CPU/DP0/ALU/aluif/porta
add wave -noupdate -group {ALU 1} /system_tb/DUT/CPU/DP0/ALU/aluif/portb
add wave -noupdate -group {ALU 1} /system_tb/DUT/CPU/DP0/ALU/aluif/portout
add wave -noupdate -group {ALU 1} /system_tb/DUT/CPU/DP0/ALU/aluif/aluop
add wave -noupdate -group {Register File 1} /system_tb/DUT/CPU/DP0/rfif/WEN
add wave -noupdate -group {Register File 1} /system_tb/DUT/CPU/DP0/rfif/wsel
add wave -noupdate -group {Register File 1} /system_tb/DUT/CPU/DP0/rfif/rsel1
add wave -noupdate -group {Register File 1} /system_tb/DUT/CPU/DP0/rfif/rsel2
add wave -noupdate -group {Register File 1} /system_tb/DUT/CPU/DP0/rfif/wdat
add wave -noupdate -group {Register File 1} /system_tb/DUT/CPU/DP0/rfif/rdat1
add wave -noupdate -group {Register File 1} /system_tb/DUT/CPU/DP0/rfif/rdat2
add wave -noupdate -expand -group {Extender 1} /system_tb/DUT/CPU/DP0/exif/imm
add wave -noupdate -expand -group {Extender 1} /system_tb/DUT/CPU/DP0/exif/ExtOp
add wave -noupdate -expand -group {Extender 1} /system_tb/DUT/CPU/DP0/exif/ext_imm
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/dhit
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/ihit
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/cu_halt
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/cu_Jump
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/ID_JR
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/ID_dread
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/PCSrc
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/ID_rt
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/IF_rs
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/IF_rt
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/EX_dread
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/EX_dwrite
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/IF_EN
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/ID_EN
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/EX_EN
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/MEM_EN
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/IF_FLUSH
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/ID_FLUSH
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/EX_FLUSH
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/MEM_FLUSH
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/PC_EN
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/iREN
add wave -noupdate -group {Hazard Unit 1} /system_tb/DUT/CPU/DP0/huif/pr_halt
add wave -noupdate -group {Forwarding Unit 1} /system_tb/DUT/CPU/DP0/fuif/ID_rs
add wave -noupdate -group {Forwarding Unit 1} /system_tb/DUT/CPU/DP0/fuif/ID_rt
add wave -noupdate -group {Forwarding Unit 1} /system_tb/DUT/CPU/DP0/fuif/EX_wsel
add wave -noupdate -group {Forwarding Unit 1} /system_tb/DUT/CPU/DP0/fuif/MEM_wsel
add wave -noupdate -group {Forwarding Unit 1} /system_tb/DUT/CPU/DP0/fuif/EX_RegWrite
add wave -noupdate -group {Forwarding Unit 1} /system_tb/DUT/CPU/DP0/fuif/MEM_RegWrite
add wave -noupdate -group {Forwarding Unit 1} /system_tb/DUT/CPU/DP0/fuif/forwarda
add wave -noupdate -group {Forwarding Unit 1} /system_tb/DUT/CPU/DP0/fuif/forwardb
add wave -noupdate -group {ALU 2} /system_tb/DUT/CPU/DP1/aluif/negative
add wave -noupdate -group {ALU 2} /system_tb/DUT/CPU/DP1/aluif/overflow
add wave -noupdate -group {ALU 2} /system_tb/DUT/CPU/DP1/aluif/zero
add wave -noupdate -group {ALU 2} /system_tb/DUT/CPU/DP1/aluif/porta
add wave -noupdate -group {ALU 2} /system_tb/DUT/CPU/DP1/aluif/portb
add wave -noupdate -group {ALU 2} /system_tb/DUT/CPU/DP1/aluif/portout
add wave -noupdate -group {ALU 2} /system_tb/DUT/CPU/DP1/aluif/aluop
add wave -noupdate -group {Register File 2} /system_tb/DUT/CPU/DP1/rfif/WEN
add wave -noupdate -group {Register File 2} /system_tb/DUT/CPU/DP1/rfif/wsel
add wave -noupdate -group {Register File 2} /system_tb/DUT/CPU/DP1/rfif/rsel1
add wave -noupdate -group {Register File 2} /system_tb/DUT/CPU/DP1/rfif/rsel2
add wave -noupdate -group {Register File 2} /system_tb/DUT/CPU/DP1/rfif/wdat
add wave -noupdate -group {Register File 2} /system_tb/DUT/CPU/DP1/rfif/rdat1
add wave -noupdate -group {Register File 2} /system_tb/DUT/CPU/DP1/rfif/rdat2
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/ExtOp
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/ALUSrc
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/MemtoReg
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/BEQ
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/BNE
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/Jump
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/JR
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/RegDst
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/RegWr
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/ALUCtr
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/JumpReg
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/LUI
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/opcode
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/funct
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/shamt
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/dread
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/dwrite
add wave -noupdate -group {Control Unit 2} /system_tb/DUT/CPU/DP1/cuif/halt
add wave -noupdate -group {Program Counter 2} /system_tb/DUT/CPU/DP1/pcif/PCSrc
add wave -noupdate -group {Program Counter 2} /system_tb/DUT/CPU/DP1/pcif/Jump
add wave -noupdate -group {Program Counter 2} /system_tb/DUT/CPU/DP1/pcif/JR
add wave -noupdate -group {Program Counter 2} /system_tb/DUT/CPU/DP1/pcif/PC_EN
add wave -noupdate -group {Program Counter 2} /system_tb/DUT/CPU/DP1/pcif/bimm
add wave -noupdate -group {Program Counter 2} /system_tb/DUT/CPU/DP1/pcif/jimm
add wave -noupdate -group {Program Counter 2} /system_tb/DUT/CPU/DP1/pcif/jraddr
add wave -noupdate -group {Program Counter 2} /system_tb/DUT/CPU/DP1/pcif/branch_pc
add wave -noupdate -group {Program Counter 2} /system_tb/DUT/CPU/DP1/pcif/nxt_pc
add wave -noupdate -group {Program Counter 2} /system_tb/DUT/CPU/DP1/pcif/pcaddr
add wave -noupdate -group {Extender 2} /system_tb/DUT/CPU/DP1/exif/imm
add wave -noupdate -group {Extender 2} /system_tb/DUT/CPU/DP1/exif/ExtOp
add wave -noupdate -group {Extender 2} /system_tb/DUT/CPU/DP1/exif/ext_imm
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/dhit
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/ihit
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/cu_halt
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/cu_Jump
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/ID_JR
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/ID_dread
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/PCSrc
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/ID_rt
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/IF_rs
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/IF_rt
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/EX_dread
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/EX_dwrite
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/IF_EN
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/ID_EN
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/EX_EN
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/MEM_EN
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/IF_FLUSH
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/ID_FLUSH
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/EX_FLUSH
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/MEM_FLUSH
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/PC_EN
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/iREN
add wave -noupdate -group {Hazard Unit 2} /system_tb/DUT/CPU/DP1/huif/pr_halt
add wave -noupdate -group {Forwarding Unit 2} /system_tb/DUT/CPU/DP1/fuif/ID_rs
add wave -noupdate -group {Forwarding Unit 2} /system_tb/DUT/CPU/DP1/fuif/ID_rt
add wave -noupdate -group {Forwarding Unit 2} /system_tb/DUT/CPU/DP1/fuif/EX_wsel
add wave -noupdate -group {Forwarding Unit 2} /system_tb/DUT/CPU/DP1/fuif/MEM_wsel
add wave -noupdate -group {Forwarding Unit 2} /system_tb/DUT/CPU/DP1/fuif/EX_RegWrite
add wave -noupdate -group {Forwarding Unit 2} /system_tb/DUT/CPU/DP1/fuif/MEM_RegWrite
add wave -noupdate -group {Forwarding Unit 2} /system_tb/DUT/CPU/DP1/fuif/forwarda
add wave -noupdate -group {Forwarding Unit 2} /system_tb/DUT/CPU/DP1/fuif/forwardb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {158331 ps} 0}
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
WaveRestoreZoom {0 ps} {1527503 ps}
