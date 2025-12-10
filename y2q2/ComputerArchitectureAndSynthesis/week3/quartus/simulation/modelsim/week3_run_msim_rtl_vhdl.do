transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week3/quartus/riscv_alu.vhd}

vcom -93 -work work {/home/nw1728/study/y2q2/ComputerArchitectureAndSynthesis/week3/quartus/tb_riscv_alu.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  tb_riscv_alu

add wave *
view structure
view signals
run -all
