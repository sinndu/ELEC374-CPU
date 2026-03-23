onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -divider "Top-Level Signals"
add wave -noupdate sim:/tb_addi/Clock
add wave -noupdate sim:/tb_addi/clear
add wave -noupdate -radix hexadecimal sim:/tb_addi/Present_state

add wave -divider "Control Signals"
add wave -noupdate sim:/tb_addi/PCout
add wave -noupdate sim:/tb_addi/PCin
add wave -noupdate sim:/tb_addi/Read
add wave -noupdate sim:/tb_addi/IRin
add wave -noupdate sim:/tb_addi/MARin
add wave -noupdate sim:/tb_addi/MDRin
add wave -noupdate sim:/tb_addi/MDRout
add wave -noupdate sim:/tb_addi/Yin
add wave -noupdate sim:/tb_addi/Zin
add wave -noupdate sim:/tb_addi/ZLowout
add wave -noupdate sim:/tb_addi/Cout
add wave -noupdate sim:/tb_addi/Gra
add wave -noupdate sim:/tb_addi/Grb
add wave -noupdate sim:/tb_addi/Rin
add wave -noupdate sim:/tb_addi/Rout

add wave -divider "Internal Data"
add wave -noupdate -radix hexadecimal sim:/ALU_operation
add wave -noupdate -radix hexadecimal sim:/tb_addi/SRC/DUT/BusMuxOut
add wave -noupdate -radix hexadecimal sim:/tb_addi/SRC/DUT/IR/storage
add wave -noupdate -radix hexadecimal sim:/tb_addi/SRC/DUT/PC/storage

add wave -divider "Registers"
add wave -noupdate -radix decimal sim:/tb_addi/SRC/DUT/R4/storage
add wave -noupdate -radix decimal sim:/tb_addi/SRC/DUT/R7/storage
add wave -noupdate -radix decimal sim:/tb_addi/SRC/DUT/RY/storage
add wave -noupdate -radix decimal sim:/tb_addi/SRC/DUT/RZlow/storage
add wave -noupdate -radix decimal sim:/tb_addi/SRC/DUT/S_E_logic/reg_select

TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 250
configure wave -valuecolwidth 100
update