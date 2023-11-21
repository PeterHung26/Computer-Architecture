onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate /dcache_tb/DUT/state
add wave -noupdate /dcache_tb/DUT/miss
add wave -noupdate /dcache_tb/DUT/way
add wave -noupdate /dcache_tb/DUT/halt_cnt
add wave -noupdate -expand -subitemconfig {/dcache_tb/DUT/nxt_cache.left -expand /dcache_tb/DUT/nxt_cache.right -expand} /dcache_tb/DUT/nxt_cache
add wave -noupdate -expand -group Case /dcache_tb/PROG/tb_test_num
add wave -noupdate -expand -group Case /dcache_tb/PROG/tb_test_case
add wave -noupdate -group {Input from Datapath} /dcache_tb/dcif/datomic
add wave -noupdate -group {Input from Datapath} /dcache_tb/dcif/dmemREN
add wave -noupdate -group {Input from Datapath} /dcache_tb/dcif/dmemWEN
add wave -noupdate -group {Input from Datapath} /dcache_tb/dcif/dmemstore
add wave -noupdate -group {Input from Datapath} /dcache_tb/dcif/dmemaddr
add wave -noupdate -group {Input from Datapath} /dcache_tb/dcif/halt
add wave -noupdate -group {Output to Datapath} /dcache_tb/dcif/dmemload
add wave -noupdate -group {Output to Datapath} /dcache_tb/dcif/dhit
add wave -noupdate -group {Output to Datapath} /dcache_tb/dcif/flushed
add wave -noupdate -expand -group {Input from memory controller} /dcache_tb/dif/dwait
add wave -noupdate -expand -group {Input from memory controller} /dcache_tb/dif/dload
add wave -noupdate -expand -group {Output to memory controller} /dcache_tb/dif/dREN
add wave -noupdate -expand -group {Output to memory controller} /dcache_tb/dif/dWEN
add wave -noupdate -expand -group {Output to memory controller} /dcache_tb/dif/dstore
add wave -noupdate -expand -group {Output to memory controller} /dcache_tb/dif/daddr
add wave -noupdate -expand -group {Coherence Signal} /dcache_tb/PROG/dif/ccwait
add wave -noupdate -expand -group {Coherence Signal} /dcache_tb/PROG/dif/ccinv
add wave -noupdate -expand -group {Coherence Signal} /dcache_tb/PROG/dif/ccwrite
add wave -noupdate -expand -group {Coherence Signal} /dcache_tb/PROG/dif/cctrans
add wave -noupdate -expand -group {Coherence Signal} /dcache_tb/PROG/dif/ccsnoopaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {634 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 122
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
WaveRestoreZoom {345 ns} {877 ns}
