transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/QueensU/ELEC374/ELEC374-CPU/src/alu/add {C:/QueensU/ELEC374/ELEC374-CPU/src/alu/add/PFA.v}
vlog -vlog01compat -work work +incdir+C:/QueensU/ELEC374/ELEC374-CPU/src/alu/add {C:/QueensU/ELEC374/ELEC374-CPU/src/alu/add/CLA_32.v}
vlog -vlog01compat -work work +incdir+C:/QueensU/ELEC374/ELEC374-CPU/src/alu/add {C:/QueensU/ELEC374/ELEC374-CPU/src/alu/add/CLA_16.v}
vlog -vlog01compat -work work +incdir+C:/QueensU/ELEC374/ELEC374-CPU/src/alu/add {C:/QueensU/ELEC374/ELEC374-CPU/src/alu/add/CLA_4.v}
vlog -vlog01compat -work work +incdir+C:/QueensU/ELEC374/ELEC374-CPU/src {C:/QueensU/ELEC374/ELEC374-CPU/src/datapath.v}
vlog -vlog01compat -work work +incdir+C:/QueensU/ELEC374/ELEC374-CPU/src/registers {C:/QueensU/ELEC374/ELEC374-CPU/src/registers/Register_32.v}
vlog -vlog01compat -work work +incdir+C:/QueensU/ELEC374/ELEC374-CPU/src/bus {C:/QueensU/ELEC374/ELEC374-CPU/src/bus/MDR.v}
vlog -vlog01compat -work work +incdir+C:/QueensU/ELEC374/ELEC374-CPU/src/bus {C:/QueensU/ELEC374/ELEC374-CPU/src/bus/Bus.v}
vlog -vlog01compat -work work +incdir+C:/QueensU/ELEC374/ELEC374-CPU/src/alu/mul {C:/QueensU/ELEC374/ELEC374-CPU/src/alu/mul/Booth_Multiplier.v}
vlog -vlog01compat -work work +incdir+C:/QueensU/ELEC374/ELEC374-CPU/src/alu/div {C:/QueensU/ELEC374/ELEC374-CPU/src/alu/div/NR_Division.v}
vlog -vlog01compat -work work +incdir+C:/QueensU/ELEC374/ELEC374-CPU/src/alu {C:/QueensU/ELEC374/ELEC374-CPU/src/alu/ALU.v}

vlog -vlog01compat -work work +incdir+C:/QueensU/ELEC374/ELEC374-CPU/src/testbenches {C:/QueensU/ELEC374/ELEC374-CPU/src/testbenches/ALU_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ALU_tb

add wave *
view structure
view signals
run -all
