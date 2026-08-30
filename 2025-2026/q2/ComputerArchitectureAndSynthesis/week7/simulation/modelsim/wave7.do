onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /jal_jalr_tb/clk
add wave -noupdate -radix unsigned /jal_jalr_tb/reset
add wave -noupdate -radix unsigned /jal_jalr_tb/PC_debug
add wave -noupdate -radix unsigned /jal_jalr_tb/instr_debug
add wave -noupdate -radix unsigned /jal_jalr_tb/ALU_debug
add wave -noupdate -radix unsigned /jal_jalr_tb/UUT/Jump
add wave -noupdate -radix unsigned /jal_jalr_tb/UUT/ResultSrc
add wave -noupdate -radix unsigned /jal_jalr_tb/UUT/PC_next
add wave -noupdate -radix unsigned /jal_jalr_tb/UUT/BranchTarget
add wave -noupdate -radix unsigned /jal_jalr_tb/UUT/JumpTarget
add wave -noupdate -radix unsigned /jal_jalr_tb/UUT/Result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12918 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 199
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {126 ns}
