onerror {resume}
quietly WaveActivateNextPane {} 0

# FSM
add wave -divider "FSM"
add wave -noupdate sim:/Clock
add wave -noupdate sim:/clear
add wave -noupdate -radix hexadecimal sim:/Present_state

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
add wave -noupdate sim:/HIout
add wave -noupdate sim:/LOout
add wave -noupdate sim:/Rin
add wave -noupdate sim:/Gra

add wave -divider "Internal Data"
add wave -noupdate -label "BusMuxOut" -radix hexadecimal sim:/SRC/DUT/BusMuxOut
add wave -noupdate -label "PC" -radix hexadecimal sim:/SRC/DUT/PC/storage
add wave -noupdate -label "R5" -radix hexadecimal sim:/SRC/DUT/R5/storage
add wave -noupdate -label "R1" -radix hexadecimal sim:/SRC/DUT/R1/storage
add wave -noupdate -label "HI" -radix hexadecimal sim:/SRC/DUT/HI/storage
add wave -noupdate -label "LO" -radix hexadecimal sim:/SRC/DUT/LO/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/S_E_logic/reg_select

TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 250
configure wave -valuecolwidth 100
update