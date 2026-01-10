transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week5/Program_Counter.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week5/PC_Adder.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week5/Instruction_Memory.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week5/ALU.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week5/Register_File.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week5/Control_Unit.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week5/Imm_Ext.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week5/week5_top.vhd}

vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week5/week5_top_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  week5_top_tb

add wave *
view structure
view signals
run -all
