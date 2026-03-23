onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -divider "Top-Level Signals"
add wave -noupdate sim:/tb_andi/Clock
add wave -noupdate sim:/tb_andi/clear
add wave -noupdate -radix hexadecimal sim:/tb_andi/Present_state

add wave -divider "Control Signals"
add wave -noupdate sim:/PCout
add wave -noupdate sim:/PCin
add wave -noupdate sim:/Read
add wave -noupdate sim:/IRin
add wave -noupdate sim:/MARin
add wave -noupdate sim:/MDRin
add wave -noupdate sim:/MDRout
add wave -noupdate sim:/Yin
add wave -noupdate sim:/Zin
add wave -noupdate sim:/ZLowout
add wave -noupdate sim:/Cout
add wave -noupdate sim:/Gra
add wave -noupdate sim:/Grb
add wave -noupdate sim:/Rin
add wave -noupdate sim:/Rout

add wave -divider "Internal Data"
add wave -noupdate -radix hexadecimal sim:/ALU_operation
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/BusMuxOut
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/MDR_out
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/IR/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/PC/storage

add wave -divider "Registers"
add wave -noupdate -radix hexadecimal sim:/tb_andi/SRC/DUT/R4/storage
add wave -noupdate -radix hexadecimal sim:/tb_andi/SRC/DUT/R7/storage
add wave -noupdate -radix hexadecimal sim:/tb_andi/SRC/DUT/RZlow/storage
add wave -noupdate -radix hexadecimal sim:/tb_andi/SRC/DUT/RY/storage
add wave -noupdate -radix hexadecimal sim:/tb_andi/SRC/DUT/S_E_logic/reg_select

TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 250
configure wave -valuecolwidth 100
update