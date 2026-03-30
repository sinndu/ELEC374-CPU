onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -divider "Control Signals"
add wave -noupdate sim:/SRC/clock
add wave -noupdate sim:/SRC/clear
add wave -noupdate sim:/SRC/IRin
add wave -noupdate sim:/SRC/PCin
add wave -noupdate sim:/SRC/PCout
add wave -noupdate sim:/SRC/MDRin
add wave -noupdate sim:/SRC/MDRout
add wave -noupdate sim:/SRC/MARin
add wave -noupdate sim:/SRC/Gra
add wave -noupdate sim:/SRC/Grb
add wave -noupdate sim:/SRC/Grc
add wave -noupdate sim:/SRC/Rin
add wave -noupdate sim:/SRC/Rout
add wave -noupdate sim:/SRC/HIin
add wave -noupdate sim:/SRC/HIout
add wave -noupdate sim:/SRC/LOin
add wave -noupdate sim:/SRC/LOout


add wave -noupdate sim:/SRC/Read
add wave -noupdate sim:/SRC/Write

add wave -divider "Internal Data (IR, PC)"
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/IR/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/PC/storage

add wave -divider "Memory (MDR, MAR)"
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/MDR/MDR_Reg/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/MAR/storage

add wave -divider "Registers (R0-R15)"
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

add wave -divider "Registers (HI, LO)"
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/HI/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/LO/storage

add wave -divider "Memory (0x89, 0xA3)"
add wave -noupdate -radix hexadecimal {sim:/SRC/memory/mem[137]}
add wave -noupdate -radix hexadecimal {sim:/SRC/memory/mem[163]}

TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 250
configure wave -valuecolwidth 100
update