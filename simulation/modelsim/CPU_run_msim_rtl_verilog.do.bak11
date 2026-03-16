transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/Computer.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/memory {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/memory/RAM.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/registers {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/registers/MDR.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/select_encode {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/select_encode/CON_FF.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/select_encode {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/select_encode/Select_encode.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu/add {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu/add/PFA.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu/add {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu/add/CLA_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu/add {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu/add/CLA_16.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu/add {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu/add/CLA_4.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/registers {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/registers/Register_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/bus {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/bus/Bus.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu/mul {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu/mul/Booth_Multiplier.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu/div {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu/div/NR_Division.v}
vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/alu/ALU.v}

vlog -vlog01compat -work work +incdir+C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/testbenches/Phase_2 {C:/Users/22nkj/Documents/elec374/ELEC374-CPU/src/testbenches/Phase_2/DataPath_tb_addi.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  DataPath_tb_addi

add wave *
view structure
view signals
run 500 ns
