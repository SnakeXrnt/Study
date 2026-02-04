transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week7/Instruction_Memory_JAL_JALR.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week7/Program_Counter.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week7/PC_Adder.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week7/ALU.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week7/Register_File.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week7/Control_Unit.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week7/Imm_Ext.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week7/Data_Memory.vhd}
vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week7/week5_top_jal_jalr.vhd}

vcom -2008 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week7/week7_jal_jalr_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  week7_jal_jalr_tb

add wave *
view structure
view signals
run -all
