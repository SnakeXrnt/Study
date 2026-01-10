transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week6/Program_Counter.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week6/PC_Adder.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week6/Instruction_Memory.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week6/ALU.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week6/Register_File.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week6/Control_Unit.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week6/Imm_Ext.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week6/Data_Memory.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week6/week5_top.vhd}

vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week6/week6_memory_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  week6_memory_tb

add wave *
view structure
view signals
run -all
