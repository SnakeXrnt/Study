onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /counter_4bit/clk
add wave -noupdate /counter_4bit/reset
add wave -noupdate /counter_4bit/enable
add wave -noupdate /counter_4bit/count
add wave -noupdate /counter_4bit/temp_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {84000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {473458 ps}
