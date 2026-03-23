onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -divider "FSM"
add wave -noupdate sim:/tb_jr/Clock
add wave -noupdate sim:/tb_jr/clear
add wave -noupdate -radix hexadecimal sim:/tb_jr/Present_state

add wave -divider "Control Signals"
add wave -noupdate sim:/tb_jr/PCin
add wave -noupdate sim:/tb_jr/Gra
add wave -noupdate sim:/tb_jr/Rout
add wave -noupdate sim:/tb_jr/ZLowout

add wave -divider "Internal Data"
add wave -noupdate -radix hexadecimal sim:/tb_jr/SRC/DUT/BusMuxOut
add wave -noupdate -radix hexadecimal sim:/tb_jr/SRC/DUT/PC/storage
add wave -noupdate -radix hexadecimal sim:/tb_jr/SRC/DUT/IR_output
add wave -noupdate -radix hexadecimal sim:/tb_jr/SRC/DUT/R12/storage

TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 250
configure wave -valuecolwidth 100
update