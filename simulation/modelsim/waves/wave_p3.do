onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -divider "Control Signals"
add wave -noupdate sim:/Clock
add wave -noupdate sim:/clear
add wave -noupdate sim:/PCin
add wave -noupdate sim:/PCout
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
add wave -noupdate sim:/Grc

add wave -noupdate sim:/Rin
add wave -noupdate sim:/Rout

add wave -noupdate sim:/Read
add wave -noupdate sim:/Write

add wave -divider "Internal Data"
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/BusMuxOut
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/PC/storage

add wave -divider "Registers [MDR, MAR, IR]"
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/MDR/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/MAR/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/IR/storage

add wave -divider "Registers [R0-R15]"
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R0/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R1/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R2/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R3/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R4/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R5/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R6/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R7/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R8/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R9/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R10/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R11/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R12/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R13/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R14/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R15/storage

add wave -divider "Registers [HI, LO]"
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/HI/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/LO/storage

add wave -divider "Memory [0x89, 0xA3]"
add wave -noupdate -radix hexadecimal sim:/SRC/memory/mem[137]
add wave -noupdate -radix hexadecimal sim:/SRC/memory/mem[163]

TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 250
configure wave -valuecolwidth 100
update