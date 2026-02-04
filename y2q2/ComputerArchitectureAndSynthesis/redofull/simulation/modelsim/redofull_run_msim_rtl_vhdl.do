transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/redofull/ALU.vhd}
vcom -93 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/redofull/ControlUnit.vhd}
vcom -93 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/redofull/Register_File.vhd}
vcom -93 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/redofull/Imm_Ext.vhd}
vcom -93 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/redofull/Instruction_Memory.vhd}
vcom -93 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/redofull/riscv_top.vhd}

vcom -93 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/redofull/riscv_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  riscv_tb

add wave *
view structure
view signals
run -all
