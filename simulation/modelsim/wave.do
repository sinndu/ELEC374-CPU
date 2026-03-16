onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DataPath_tb_addi/Clock
add wave -noupdate /DataPath_tb_addi/clear
add wave -noupdate /DataPath_tb_addi/PCout
add wave -noupdate /DataPath_tb_addi/Zlowout
add wave -noupdate /DataPath_tb_addi/MDRout
add wave -noupdate /DataPath_tb_addi/Rout
add wave -noupdate /DataPath_tb_addi/MARin
add wave -noupdate /DataPath_tb_addi/Zin
add wave -noupdate /DataPath_tb_addi/PCin
add wave -noupdate /DataPath_tb_addi/MDRin
add wave -noupdate /DataPath_tb_addi/IRin
add wave -noupdate /DataPath_tb_addi/Yin
add wave -noupdate /DataPath_tb_addi/CONin
add wave -noupdate /DataPath_tb_addi/ReadMDR
add wave -noupdate /DataPath_tb_addi/ReadMem
add wave -noupdate /DataPath_tb_addi/Write
add wave -noupdate /DataPath_tb_addi/Rin
add wave -noupdate /DataPath_tb_addi/Gra
add wave -noupdate /DataPath_tb_addi/Grb
add wave -noupdate /DataPath_tb_addi/Grc
add wave -noupdate /DataPath_tb_addi/Cout
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/Present_state
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/ALU_operation
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/SRC/DUT/S_E_logic/reg_select
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/SRC/DUT/BusMuxOut
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/SRC/DUT/R7/storage
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/SRC/DUT/R4/storage
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/SRC/memory/addr
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/SRC/DUT/S_E_logic/Ra
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/SRC/DUT/S_E_logic/Rb
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/SRC/DUT/S_E_logic/Rc
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/SRC/DUT/S_E_logic/C_sign_extended
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/SRC/DUT/IR/storage
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/SRC/DUT/MDR/MDR_Reg/storage
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/SRC/DUT/MDR/Mux_out
add wave -noupdate -radix hexadecimal /DataPath_tb_addi/SRC/memory/data_out
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
WaveRestoreZoom {0 ps} {525 ns}
