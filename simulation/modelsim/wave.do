onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate sim:/Clock
add wave -noupdate sim:/clear
add wave -noupdate sim:/PCout
add wave -noupdate sim:/Zlowout
add wave -noupdate sim:/MDRout
add wave -noupdate sim:/Rout
add wave -noupdate sim:/MARin
add wave -noupdate sim:/Zin
add wave -noupdate sim:/PCin
add wave -noupdate sim:/MDRin
add wave -noupdate sim:/IRin
add wave -noupdate sim:/Yin
add wave -noupdate sim:/CONin
add wave -noupdate sim:/Read
add wave -noupdate sim:/Write
add wave -noupdate sim:/Rin
add wave -noupdate sim:/Gra
add wave -noupdate sim:/Grb
add wave -noupdate sim:/Grc
add wave -noupdate sim:/Cout
add wave -noupdate sim:/BAout
add wave -noupdate -radix hexadecimal sim:/Present_state
add wave -noupdate -radix hexadecimal sim:/ALU_operation
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/S_E_logic/reg_select
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/BusMuxOut
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/PC/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R7/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R4/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/R3/storage
add wave -noupdate -radix hexadecimal sim:/SRC/memory/addr
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/S_E_logic/Ra
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/S_E_logic/Rb
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/S_E_logic/Rc
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/S_E_logic/C_sign_extended
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/IR/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/MDR/MDR_Reg/storage
add wave -noupdate -radix hexadecimal sim:/SRC/DUT/MDR/Mux_out
add wave -noupdate -radix hexadecimal sim:/SRC/memory/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {176332 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 331
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {315 ns}
