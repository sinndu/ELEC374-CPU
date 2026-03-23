onerror {resume}
quietly WaveActivateNextPane {} 0

# FSM
add wave -divider "FSM"
add wave -noupdate sim:/tb_in_out/Clock
add wave -noupdate sim:/tb_in_out/clear
add wave -noupdate -radix hexadecimal sim:/tb_in_out/Present_state

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
add wave -noupdate sim:/Rin
add wave -noupdate sim:/Rout
add wave -noupdate sim:/tb_in_out/InPortout
add wave -noupdate sim:/tb_in_out/OutPortin

add wave -divider "Internal Data"
add wave -noupdate -radix hexadecimal sim:/ALU_operation
add wave -noupdate -radix hexadecimal sim:/tb_in_out/SRC/DUT/BusMuxOut
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/MDR_out
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/IR/storage
add wave -noupdate -label "PC" -radix hexadecimal sim:/tb_in_out/SRC/DUT/PC/storage
add wave -noupdate -label "R5" -radix hexadecimal sim:/tb_in_out/SRC/DUT/R5/storage
add wave -noupdate -label "R7" -radix hexadecimal sim:/tb_in_out/SRC/DUT/R7/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/S_E_logic/reg_select

add wave -divider "I/O Ports"
add wave -noupdate -radix hexadecimal sim:/tb_in_out/in_port_data
add wave -noupdate -label "InPort" -radix hexadecimal sim:/tb_in_out/SRC/DUT/InPort/storage
add wave -noupdate -label "OutPort" -radix hexadecimal sim:/tb_in_out/SRC/DUT/OutPort/storage
add wave -noupdate -radix hexadecimal sim:/tb_in_out/out_port_data

TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 250
configure wave -valuecolwidth 100
update