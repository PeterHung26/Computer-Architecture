onerror {resume}
quietly virtual function -install /system_tb/DUT/CPU/dcif -env /system_tb { &{/system_tb/DUT/CPU/dcif/imemaddr[31], /system_tb/DUT/CPU/dcif/imemaddr[30], /system_tb/DUT/CPU/dcif/imemaddr[29], /system_tb/DUT/CPU/dcif/imemaddr[28], /system_tb/DUT/CPU/dcif/imemaddr[27], /system_tb/DUT/CPU/dcif/imemaddr[26], /system_tb/DUT/CPU/dcif/imemaddr[25], /system_tb/DUT/CPU/dcif/imemaddr[24], /system_tb/DUT/CPU/dcif/imemaddr[23], /system_tb/DUT/CPU/dcif/imemaddr[22], /system_tb/DUT/CPU/dcif/imemaddr[21], /system_tb/DUT/CPU/dcif/imemaddr[20], /system_tb/DUT/CPU/dcif/imemaddr[19], /system_tb/DUT/CPU/dcif/imemaddr[18], /system_tb/DUT/CPU/dcif/imemaddr[17], /system_tb/DUT/CPU/dcif/imemaddr[16], /system_tb/DUT/CPU/dcif/imemaddr[15], /system_tb/DUT/CPU/dcif/imemaddr[14], /system_tb/DUT/CPU/dcif/imemaddr[13], /system_tb/DUT/CPU/dcif/imemaddr[12], /system_tb/DUT/CPU/dcif/imemaddr[11], /system_tb/DUT/CPU/dcif/imemaddr[10], /system_tb/DUT/CPU/dcif/imemaddr[9], /system_tb/DUT/CPU/dcif/imemaddr[8], /system_tb/DUT/CPU/dcif/imemaddr[7], /system_tb/DUT/CPU/dcif/imemaddr[6] }} imemaddr_tag
quietly virtual function -install /system_tb/DUT/CPU/dcif -env /system_tb { &{/system_tb/DUT/CPU/dcif/imemaddr[5], /system_tb/DUT/CPU/dcif/imemaddr[4], /system_tb/DUT/CPU/dcif/imemaddr[3], /system_tb/DUT/CPU/dcif/imemaddr[2] }} imemaddr_idx
quietly virtual function -install /system_tb/DUT/CPU/dcif -env /system_tb { &{/system_tb/DUT/CPU/dcif/dmemaddr[31], /system_tb/DUT/CPU/dcif/dmemaddr[30], /system_tb/DUT/CPU/dcif/dmemaddr[29], /system_tb/DUT/CPU/dcif/dmemaddr[28], /system_tb/DUT/CPU/dcif/dmemaddr[27], /system_tb/DUT/CPU/dcif/dmemaddr[26], /system_tb/DUT/CPU/dcif/dmemaddr[25], /system_tb/DUT/CPU/dcif/dmemaddr[24], /system_tb/DUT/CPU/dcif/dmemaddr[23], /system_tb/DUT/CPU/dcif/dmemaddr[22], /system_tb/DUT/CPU/dcif/dmemaddr[21], /system_tb/DUT/CPU/dcif/dmemaddr[20], /system_tb/DUT/CPU/dcif/dmemaddr[19], /system_tb/DUT/CPU/dcif/dmemaddr[18], /system_tb/DUT/CPU/dcif/dmemaddr[17], /system_tb/DUT/CPU/dcif/dmemaddr[16], /system_tb/DUT/CPU/dcif/dmemaddr[15], /system_tb/DUT/CPU/dcif/dmemaddr[14], /system_tb/DUT/CPU/dcif/dmemaddr[13], /system_tb/DUT/CPU/dcif/dmemaddr[12], /system_tb/DUT/CPU/dcif/dmemaddr[11], /system_tb/DUT/CPU/dcif/dmemaddr[10], /system_tb/DUT/CPU/dcif/dmemaddr[9], /system_tb/DUT/CPU/dcif/dmemaddr[8], /system_tb/DUT/CPU/dcif/dmemaddr[7], /system_tb/DUT/CPU/dcif/dmemaddr[6] }} dmemaddr_tag
quietly virtual signal -install /system_tb/DUT/CPU/dcif {/system_tb/DUT/CPU/dcif/dmemaddr[2]  } dmemaddr_offset
quietly virtual function -install /system_tb/DUT/CPU/dcif -env /system_tb { &{/system_tb/DUT/CPU/dcif/dmemaddr[5], /system_tb/DUT/CPU/dcif/dmemaddr[4], /system_tb/DUT/CPU/dcif/dmemaddr[3] }} dmemaddr_idx
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/syif/tbCTRL
add wave -noupdate /system_tb/DUT/syif/halt
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/valid
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/valid_nxt
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/dirty
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/dirty_nxt
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/tag
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/tag_nxt
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/data
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/data0_nxt
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/data1_nxt
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/hit_count
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_hit_count
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/cnt
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/cnt_nxt
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/row
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_row
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/dmiss
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/offset
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/idx
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/row_trunc
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/lru
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/lru_nxt
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/i
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/j
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/k
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/l
add wave -noupdate -expand -group DCACHE -expand -subitemconfig {{/system_tb/DUT/CPU/CM/DCACHE/dframes[6]} -expand {/system_tb/DUT/CPU/CM/DCACHE/dframes[6][1].data} -expand {/system_tb/DUT/CPU/CM/DCACHE/dframes[6][0]} -expand {/system_tb/DUT/CPU/CM/DCACHE/dframes[6][0].data} -expand {/system_tb/DUT/CPU/CM/DCACHE/dframes[0]} -expand {/system_tb/DUT/CPU/CM/DCACHE/dframes[0][1]} -expand {/system_tb/DUT/CPU/CM/DCACHE/dframes[0][1].data} -expand {/system_tb/DUT/CPU/CM/DCACHE/dframes[0][0]} -expand {/system_tb/DUT/CPU/CM/DCACHE/dframes[0][0].data} -expand} /system_tb/DUT/CPU/CM/DCACHE/dframes
add wave -noupdate -expand -group DCACHE -color Gold /system_tb/DUT/CPU/CM/DCACHE/state
add wave -noupdate -expand -group DCACHE -color Gold /system_tb/DUT/CPU/CM/DCACHE/state_nxt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/MemtoReg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/Jump
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/JR
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/RegWr
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ALUCtr
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/JumpReg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/LUI
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/funct
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dread
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dwrite
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/MemtoReg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/Jump
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/JR
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/RegWr
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ALUCtr
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/JumpReg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/LUI
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/funct
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dread
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dwrite
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/negative
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/overflow
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/zero
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/porta
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/portb
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/portout
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/aluop
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/negative
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/overflow
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/zero
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/porta
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/portb
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/portout
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/aluop
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/WEN
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wsel
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel2
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wdat
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat2
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/WEN
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wsel
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel2
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wdat
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat2
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/PC_EN
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/Jump
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/JR
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/bimm
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/jimm
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/jraddr
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/nxt_pc
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/pcaddr
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/PC_EN
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/Jump
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/JR
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/bimm
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/jimm
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/jraddr
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/nxt_pc
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/pcaddr
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
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_instr_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_instr
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_pc4
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_pc4_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_pc4
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_RegDst
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_RegWrite
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_MemtoReg
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_dread
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_dwrite
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_BEQ
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_BNE
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_JumpReg
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ExtOP
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ALUSrc
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_LUI
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ALUCtr
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rdat1
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rdat2
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rs
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rt
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rd
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_imm16
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_halt
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_JR
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_pc4_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_RegDst_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_RegWrite_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_MemtoReg_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_dread_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_dwrite_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_BEQ_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_BNE_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_JumpReg_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ExtOP_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ALUSrc_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_LUI_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ALUCtr_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rdat1_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rdat2_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rs_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rt_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rd_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_imm16_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_halt_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_JR_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_pc4
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_JumpReg
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_BEQ
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_BNE
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_MemtoReg
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_RegWrite
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dread
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dwrite
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_zero
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_portout
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_ext_imm_16
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_wsel
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_halt
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dmemstore
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_pc4_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_JumpReg_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_BEQ_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_BNE_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_MemtoReg_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_RegWrite_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dread_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dwrite_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_zero_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_portout_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_ext_imm_16_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_wsel_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_halt_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dmemstore_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_pc4
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_JumpReg
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_MemtoReg
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_RegWrite
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_dmemload
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_portout
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_wsel
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_halt
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_pc4_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_JumpReg_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_MemtoReg_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_RegWrite_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_dmemload_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_portout_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_wsel_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_halt_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_FLUSH
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_FLUSH
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_FLUSH
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_FLUSH
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_EN
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_EN
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_EN
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_EN
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/halt
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_instr_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_instr
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_pc4
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_pc4_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_pc4
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_RegDst
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_RegWrite
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_MemtoReg
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_dread
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_dwrite
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_BEQ
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_BNE
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_JumpReg
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ExtOP
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ALUSrc
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_LUI
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ALUCtr
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rdat1
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rdat2
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rs
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rt
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rd
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_imm16
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_halt
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_JR
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_pc4_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_RegDst_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_RegWrite_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_MemtoReg_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_dread_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_dwrite_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_BEQ_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_BNE_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_JumpReg_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ExtOP_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ALUSrc_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_LUI_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_ALUCtr_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rdat1_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rdat2_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rs_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rt_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_rd_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_imm16_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_halt_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_JR_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_pc4
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_JumpReg
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_BEQ
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_BNE
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_MemtoReg
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_RegWrite
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dread
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dwrite
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_zero
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_portout
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_ext_imm_16
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_wsel
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_halt
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dmemstore
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_pc4_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_JumpReg_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_BEQ_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_BNE_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_MemtoReg_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_RegWrite_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dread_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dwrite_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_zero_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_portout_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_ext_imm_16_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_wsel_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_halt_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_dmemstore_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_pc4
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_JumpReg
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_MemtoReg
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_RegWrite
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_dmemload
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_portout
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_wsel
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_halt
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_pc4_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_JumpReg_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_MemtoReg_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_RegWrite_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_dmemload_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_portout_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_wsel_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_halt_in
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_FLUSH
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_FLUSH
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_FLUSH
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_FLUSH
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/IF_EN
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/ID_EN
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/EX_EN
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/MEM_EN
add wave -noupdate -group {Pipeline Register} /system_tb/DUT/CPU/DP/prif/halt
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/ID_rs
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/ID_rt
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/EX_wsel
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/MEM_wsel
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/EX_RegWrite
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/MEM_RegWrite
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/forwarda
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/forwardb
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/ID_rs
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/ID_rt
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/EX_wsel
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/MEM_wsel
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/EX_RegWrite
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/MEM_RegWrite
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/forwarda
add wave -noupdate -group {Forward Unit} /system_tb/DUT/CPU/DP/fuif/forwardb
add wave -noupdate /system_tb/DUT/syif/load
add wave -noupdate -expand -group CIF -color Cyan /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -expand -group CIF -color Magenta /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -expand -group CIF -color Cyan /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -expand -group CIF -color Magenta /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -expand -group CIF /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -expand -group CIF /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -expand -group CIF /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -expand -group CIF /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -expand -group CIF /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -expand -group CIF /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -expand -group CIF /system_tb/DUT/CPU/cif0/ccsnoopaddr
add wave -noupdate -color Gold /system_tb/DUT/CPU/CM/ICACHE/state
add wave -noupdate -color Gold /system_tb/DUT/CPU/CM/ICACHE/state_nxt
add wave -noupdate -expand -group DCIF -color Magenta /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -expand -group DCIF -color Magenta /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -expand -group DCIF -color Cyan /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate -expand -group DCIF /system_tb/DUT/CPU/dcif/halt
add wave -noupdate -expand -group DCIF /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -expand -group DCIF -radix unsigned /system_tb/DUT/CPU/dcif/imemaddr_tag
add wave -noupdate -expand -group DCIF -radix unsigned /system_tb/DUT/CPU/dcif/imemaddr_idx
add wave -noupdate -expand -group DCIF /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -expand -group DCIF /system_tb/DUT/CPU/dcif/datomic
add wave -noupdate -expand -group DCIF /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -expand -group DCIF /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -expand -group DCIF /system_tb/DUT/CPU/dcif/flushed
add wave -noupdate -expand -group DCIF /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate -expand -group DCIF /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate -expand -group DCIF /system_tb/DUT/CPU/dcif/dmemaddr_tag
add wave -noupdate -expand -group DCIF /system_tb/DUT/CPU/dcif/dmemaddr_idx
add wave -noupdate -expand -group DCIF /system_tb/DUT/CPU/dcif/dmemaddr_offset
add wave -noupdate -expand -group DCIF /system_tb/DUT/CPU/dcif/dmemaddr
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/iframes
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/CLK
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/nRST
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/tag
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/idx
add wave -noupdate -expand -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/imiss
add wave -noupdate -group RAM /system_tb/DUT/prif/ramREN
add wave -noupdate -group RAM /system_tb/DUT/prif/ramWEN
add wave -noupdate -group RAM /system_tb/DUT/prif/ramaddr
add wave -noupdate -group RAM /system_tb/DUT/prif/ramstore
add wave -noupdate -group RAM /system_tb/DUT/prif/ramload
add wave -noupdate -group RAM /system_tb/DUT/prif/ramstate
add wave -noupdate -group RAM /system_tb/DUT/prif/ramREN
add wave -noupdate -group RAM /system_tb/DUT/prif/ramWEN
add wave -noupdate -group RAM /system_tb/DUT/prif/ramaddr
add wave -noupdate -group RAM /system_tb/DUT/prif/ramstore
add wave -noupdate -group RAM /system_tb/DUT/prif/ramload
add wave -noupdate -group RAM /system_tb/DUT/prif/ramstate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6678560 ps} 0}
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
WaveRestoreZoom {6371859 ps} {6979859 ps}
