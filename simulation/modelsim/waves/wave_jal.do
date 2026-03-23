onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -divider "FSM"
add wave -noupdate sim:/tb_jal/Clock
add wave -noupdate sim:/tb_jal/clear
add wave -noupdate -radix hexadecimal sim:/tb_jal/Present_state

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
add wave -noupdate sim:/Glr
add wave -noupdate sim:/Rin
add wave -noupdate sim:/Rout


add wave -divider "Internal Data"
add wave -noupdate -radix hexadecimal sim:/tb_jal/SRC/DUT/BusMuxOut
add wave -noupdate -radix hexadecimal sim:/tb_jal/SRC/DUT/PC/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/MDR_out
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/IR/storage
add wave -noupdate -radix hexadecimal sim:/tb_jal/SRC/DUT/IR_output
add wave -noupdate -radix hexadecimal sim:/tb_jal/SRC/DUT/R12/storage
add wave -noupdate -radix hexadecimal sim:/tb_jal/SRC/DUT/R4/storage

TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 250
configure wave -valuecolwidth 100
update