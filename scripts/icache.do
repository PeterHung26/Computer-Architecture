onerror {resume}
quietly virtual function -install /icache_tb/DUT/dcif -env /icache_tb { &{/icache_tb/DUT/dcif/imemaddr[31], /icache_tb/DUT/dcif/imemaddr[30], /icache_tb/DUT/dcif/imemaddr[29], /icache_tb/DUT/dcif/imemaddr[28], /icache_tb/DUT/dcif/imemaddr[27], /icache_tb/DUT/dcif/imemaddr[26], /icache_tb/DUT/dcif/imemaddr[25], /icache_tb/DUT/dcif/imemaddr[24], /icache_tb/DUT/dcif/imemaddr[23], /icache_tb/DUT/dcif/imemaddr[22], /icache_tb/DUT/dcif/imemaddr[21], /icache_tb/DUT/dcif/imemaddr[20], /icache_tb/DUT/dcif/imemaddr[19], /icache_tb/DUT/dcif/imemaddr[18], /icache_tb/DUT/dcif/imemaddr[17], /icache_tb/DUT/dcif/imemaddr[16], /icache_tb/DUT/dcif/imemaddr[15], /icache_tb/DUT/dcif/imemaddr[14], /icache_tb/DUT/dcif/imemaddr[13], /icache_tb/DUT/dcif/imemaddr[12], /icache_tb/DUT/dcif/imemaddr[11], /icache_tb/DUT/dcif/imemaddr[10], /icache_tb/DUT/dcif/imemaddr[9], /icache_tb/DUT/dcif/imemaddr[8], /icache_tb/DUT/dcif/imemaddr[7], /icache_tb/DUT/dcif/imemaddr[6] }} imemaddr_tag
quietly virtual function -install /icache_tb/DUT/dcif -env /icache_tb { &{/icache_tb/DUT/dcif/imemaddr[5], /icache_tb/DUT/dcif/imemaddr[4], /icache_tb/DUT/dcif/imemaddr[3], /icache_tb/DUT/dcif/imemaddr[2] }} imemaddr_idx
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /icache_tb/PROG/tb_test_num
add wave -noupdate /icache_tb/PROG/tb_test_case
add wave -noupdate /icache_tb/CLK
add wave -noupdate /icache_tb/nRST
add wave -noupdate -expand -group CIF -color Cyan /icache_tb/DUT/cif/iwait
add wave -noupdate -expand -group CIF -color Cyan /icache_tb/DUT/cif/iload
add wave -noupdate -expand -group CIF -color Magenta /icache_tb/DUT/cif/iREN
add wave -noupdate -expand -group CIF -color Magenta -radix hexadecimal /icache_tb/DUT/cif/iaddr
add wave -noupdate -expand -group CIF /icache_tb/DUT/iframes
add wave -noupdate -expand -group CIF /icache_tb/DUT/cif/dwait
add wave -noupdate -expand -group CIF /icache_tb/DUT/cif/dload
add wave -noupdate -expand -group CIF -group x /icache_tb/DUT/cif/dREN
add wave -noupdate -expand -group CIF -group x /icache_tb/DUT/cif/dWEN
add wave -noupdate -expand -group CIF -group x /icache_tb/DUT/cif/dstore
add wave -noupdate -expand -group CIF -group x /icache_tb/DUT/cif/daddr
add wave -noupdate -expand -group CIF -group x /icache_tb/DUT/cif/ccwait
add wave -noupdate -expand -group CIF -group x /icache_tb/DUT/cif/ccinv
add wave -noupdate -expand -group CIF -group x /icache_tb/DUT/cif/ccwrite
add wave -noupdate -expand -group CIF -group x /icache_tb/DUT/cif/cctrans
add wave -noupdate -expand -group CIF -group x /icache_tb/DUT/cif/ccsnoopaddr
add wave -noupdate -group DUT -expand -subitemconfig {{/icache_tb/DUT/iframes[2]} {-height 16 -childformat {{{/icache_tb/DUT/iframes[2].tag} -radix unsigned}} -expand} {/icache_tb/DUT/iframes[2].tag} {-height 16 -radix unsigned} {/icache_tb/DUT/iframes[1]} {-height 16 -childformat {{{/icache_tb/DUT/iframes[1].tag} -radix unsigned}} -expand} {/icache_tb/DUT/iframes[1].tag} {-height 16 -radix unsigned}} /icache_tb/DUT/iframes
add wave -noupdate -group DUT /icache_tb/DUT/tag
add wave -noupdate -group DUT /icache_tb/DUT/idx
add wave -noupdate -group DUT /icache_tb/DUT/imiss
add wave -noupdate -color Gold /icache_tb/DUT/state
add wave -noupdate -color Gold /icache_tb/DUT/state_nxt
add wave -noupdate -expand -group DCIF -color Magenta /icache_tb/DUT/dcif/ihit
add wave -noupdate -expand -group DCIF -color Magenta /icache_tb/DUT/dcif/imemload
add wave -noupdate -expand -group DCIF -color Cyan -radix hexadecimal -childformat {{{/icache_tb/DUT/dcif/imemaddr[31]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[30]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[29]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[28]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[27]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[26]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[25]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[24]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[23]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[22]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[21]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[20]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[19]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[18]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[17]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[16]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[15]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[14]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[13]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[12]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[11]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[10]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[9]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[8]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[7]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[6]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[5]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[4]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[3]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[2]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[1]} -radix unsigned} {{/icache_tb/DUT/dcif/imemaddr[0]} -radix unsigned}} -subitemconfig {{/icache_tb/DUT/dcif/imemaddr[31]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[30]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[29]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[28]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[27]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[26]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[25]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[24]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[23]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[22]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[21]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[20]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[19]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[18]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[17]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[16]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[15]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[14]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[13]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[12]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[11]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[10]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[9]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[8]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[7]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[6]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[5]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[4]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[3]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[2]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[1]} {-color Cyan -height 16 -radix unsigned} {/icache_tb/DUT/dcif/imemaddr[0]} {-color Cyan -height 16 -radix unsigned}} /icache_tb/DUT/dcif/imemaddr
add wave -noupdate -expand -group DCIF /icache_tb/DUT/dcif/halt
add wave -noupdate -expand -group DCIF /icache_tb/DUT/dcif/imemREN
add wave -noupdate -expand -group DCIF -radix unsigned /icache_tb/DUT/dcif/imemaddr_tag
add wave -noupdate -expand -group DCIF -radix unsigned /icache_tb/DUT/dcif/imemaddr_idx
add wave -noupdate -expand -group DCIF /icache_tb/DUT/dcif/dmemREN
add wave -noupdate -expand -group DCIF /icache_tb/DUT/dcif/dmemWEN
add wave -noupdate -expand -group DCIF /icache_tb/DUT/dcif/dmemstore
add wave -noupdate -expand -group DCIF /icache_tb/DUT/dcif/dmemaddr
add wave -noupdate -expand -group DCIF -group x /icache_tb/DUT/dcif/dhit
add wave -noupdate -expand -group DCIF -group x /icache_tb/DUT/dcif/datomic
add wave -noupdate -expand -group DCIF -group x /icache_tb/DUT/dcif/flushed
add wave -noupdate -expand -group DCIF -group x /icache_tb/DUT/dcif/dmemload
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {63 ns} 0}
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
WaveRestoreZoom {46 ns} {184 ns}
