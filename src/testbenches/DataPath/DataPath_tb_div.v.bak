// and datapath_tb.v file: <This is the filename>
`timescale 1ns/10ps
module DataPath_tb_mul;
    reg [3:0] reg_select;
    reg PCout, Zlowout, Zhighout, MDRout, Rout;
    reg MARin, Zin, PCin, MDRin, IRin, Yin;
    reg Read, Rin;
	 reg HIin, LOin;
    reg Clock, clear;
    reg [31:0] Mdatain;
    parameter   Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, 
					 T0 = 4'b0101, T1 = 4'b0110, T2 = 4'b0111, T3 = 4'b1000, T4 = 4'b1001, T5 = 4'b1010, T6 = 4'b1011, done = 4'b1100;
    reg [3:0] Present_state = Default;

    parameter   ADD = 4'b0000, SUB = 4'b0001, AND = 4'b0010, OR = 4'b011, NEG = 4'b0100, NOT = 4'b0101, 
                SHR = 4'b0110, SHRA = 4'b0111, SHL = 4'b1000, ROR = 4'b1001, ROL = 4'b1010,
                MUL = 4'b1011, DIV = 4'b1100, IncPC = 4'b1101, NONE = 4'b1110;
    reg [3:0] ALU_operation = NONE;

datapath DUT(

    .clock(Clock), .clear(clear),
    .in_memory_data(Mdatain),
    .PCin(PCin), .PCout(PCout), 		
    .IRin(IRin),
    .ZLowout(Zlowout), .ZHighout(Zhighout),
    .MARin(MARin), .MDRin(MDRin), .MDRout(MDRout), .read(Read),
    .Rin(Rin), .Rout(Rout), 
	 .HIin(HIin), .LOin(LOin),
    .Yin(Yin), .Zin(Zin),
    .ALU_operation(ALU_operation), 
    .reg_select(reg_select)

);

// add test logic here
initial
    begin
		Clock = 0;
		forever #10 Clock = ~ Clock;
end

initial 
	begin
		clear = 1;
		#25;
		clear = 0;
end

always @(posedge Clock) // finite state machine; if clock rising-edge
    begin
        case (Present_state)
            Default : Present_state = Reg_load1a;
            Reg_load1a : Present_state = Reg_load1b;
            Reg_load1b : Present_state = Reg_load2a;
            Reg_load2a : Present_state = Reg_load2b;
            Reg_load2b : Present_state = T0;
            T0 : Present_state = T1;
            T1 : Present_state = T2;
            T2 : Present_state = T3;
            T3 : Present_state = T4;
            T4 : Present_state = T5;
				T5 : Present_state = T6;
				T6 : Present_state = done;
        endcase
    end

always @(negedge Clock) // do the required job in each state
    begin
    //clear all signals before switch case
    PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout <= 0; Rout <= 0;
    MARin <= 0; Zin <= 0; PCin <= 0; MDRin <= 0;
    IRin <= 0; Yin <= 0; Read <= 0;
	 HIin <= 0; LOin <= 0;
    Rin <= 0; ALU_operation <= NONE;

        case (Present_state) // assert the required signals in each clock cycle
            Default: begin
                        PCout = 0; Zlowout = 0; MDRout = 0; // initialize the signals
                        Rout = 0; MARin = 0; Zin = 0;
                        PCin = 0; MDRin = 0; IRin = 0; Yin = 0;
                        Read = 0; ALU_operation = NONE;
                        Rin = 0; Mdatain = 32'h00000000;
            end
            Reg_load1a: begin
								
                        Mdatain <= 32'h00000034;
                        Read <= 1; MDRin <= 1; 
            end
            Reg_load1b: begin
                        MDRout <= 1; reg_select <= 3; Rin <= 1;
                        // initialize R3 with the value 0x34
            end
            Reg_load2a: begin
                        Mdatain <= 32'h00000045;
                        Read <= 1; MDRin <= 1;
            end
            Reg_load2b: begin
                        MDRout <= 1; reg_select <= 1; Rin <= 1;
                        // initialize R1 with the value 0x45
            end
            T0: begin // see if you need to de-assert these signals
                        PCout <= 1; MARin <= 1; ALU_operation <= IncPC; Zin <= 1;
            end
            T1: begin
                        Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
                        Mdatain <= 32'h112B0000; // opcode for “and R2, R5, R6”
            end
            T2: begin
                        MDRout <= 1; IRin <= 1;
            end
            T3: begin
                        reg_select <= 3; Rout <= 1; Yin <= 1;
            end
            T4: begin
                        reg_select <= 1; Rout <= 1; ALU_operation <= MUL; Zin <= 1;
            end
            T5: begin
                        Zlowout <= 1; LOin <= 1;
            end
				T6: begin
				            Zhighout <= 1; HIin <= 1;
				end
        endcase
    end
	 
always @(negedge Clock) begin 
    case (Present_state)
        T0: begin
            $display("T0 @ %0t | PC=%h MAR=%h MDR=%h IR=%h ALU_op=%0d Z=%h R3=%h R1=%h HI=%h LO=%h Y=%h Bus=%h",
                $time, DUT.PC.storage, DUT.MAR.storage, DUT.MDR.MDR_Reg.storage, DUT.IR.storage, ALU_operation, {DUT.RZhigh.storage, DUT.RZlow.storage}, DUT.R3.storage, DUT.R1.storage, DUT.HI.storage, DUT.LO.storage, DUT.RY.storage, DUT.bus.q
            );
        end
        T1: begin
            $display("T1 @ %0t | PC=%h MAR=%h MDR=%h IR=%h ALU_op=%0d Z=%h R3=%h R1=%h HI=%h LO=%h Y=%h Bus=%h",
                $time, DUT.PC.storage, DUT.MAR.storage, DUT.MDR.MDR_Reg.storage, DUT.IR.storage, ALU_operation, {DUT.RZhigh.storage, DUT.RZlow.storage}, DUT.R3.storage, DUT.R1.storage, DUT.HI.storage, DUT.LO.storage, DUT.RY.storage, DUT.bus.q
            );
        end
        T2: begin
            $display("T2 @ %0t | PC=%h MAR=%h MDR=%h IR=%h ALU_op=%0d Z=%h R3=%h R1=%h HI=%h LO=%h Y=%h Bus=%h",
                $time, DUT.PC.storage, DUT.MAR.storage, DUT.MDR.MDR_Reg.storage, DUT.IR.storage, ALU_operation, {DUT.RZhigh.storage, DUT.RZlow.storage}, DUT.R3.storage, DUT.R1.storage, DUT.HI.storage, DUT.LO.storage, DUT.RY.storage, DUT.bus.q
            );
        end
        T3: begin
            $display("T3 @ %0t | PC=%h MAR=%h MDR=%h IR=%h ALU_op=%0d Z=%h R3=%h R1=%h HI=%h LO=%h Y=%h Bus=%h",
                $time, DUT.PC.storage, DUT.MAR.storage, DUT.MDR.MDR_Reg.storage, DUT.IR.storage, ALU_operation, {DUT.RZhigh.storage, DUT.RZlow.storage}, DUT.R3.storage, DUT.R1.storage, DUT.HI.storage, DUT.LO.storage, DUT.RY.storage, DUT.bus.q
            );
        end
        T4: begin
            $display("T4 @ %0t | PC=%h MAR=%h MDR=%h IR=%h ALU_op=%0d Z=%h R3=%h R1=%h HI=%h LO=%h Y=%h Bus=%h",
                $time, DUT.PC.storage, DUT.MAR.storage, DUT.MDR.MDR_Reg.storage, DUT.IR.storage, ALU_operation, {DUT.RZhigh.storage, DUT.RZlow.storage}, DUT.R3.storage, DUT.R1.storage, DUT.HI.storage, DUT.LO.storage, DUT.RY.storage, DUT.bus.q
            );
        end
        T5: begin
            $display("T5 @ %0t | PC=%h MAR=%h MDR=%h IR=%h ALU_op=%0d Z=%h R3=%h R1=%h HI=%h LO=%h Y=%h Bus=%h",
                $time, DUT.PC.storage, DUT.MAR.storage, DUT.MDR.MDR_Reg.storage, DUT.IR.storage, ALU_operation, {DUT.RZhigh.storage, DUT.RZlow.storage}, DUT.R3.storage, DUT.R1.storage, DUT.HI.storage, DUT.LO.storage, DUT.RY.storage, DUT.bus.q
            );
        end
        T6: begin
            $display("T6 @ %0t | PC=%h MAR=%h MDR=%h IR=%h ALU_op=%0d Z=%h R3=%h R1=%h HI=%h LO=%h Y=%h Bus=%h",
                $time, DUT.PC.storage, DUT.MAR.storage, DUT.MDR.MDR_Reg.storage, DUT.IR.storage, ALU_operation, {DUT.RZhigh.storage, DUT.RZlow.storage}, DUT.R3.storage, DUT.R1.storage, DUT.HI.storage, DUT.LO.storage, DUT.RY.storage, DUT.bus.q
            );
        end
        done: begin
            $display("End @ %0t | PC=%h MAR=%h MDR=%h IR=%h ALU_op=%0d Z=%h R3=%h R1=%h HI=%h LO=%h Y=%h Bus=%h",
                $time, DUT.PC.storage, DUT.MAR.storage, DUT.MDR.MDR_Reg.storage, DUT.IR.storage, ALU_operation, {DUT.RZhigh.storage, DUT.RZlow.storage}, DUT.R3.storage, DUT.R1.storage, DUT.HI.storage, DUT.LO.storage, DUT.RY.storage, DUT.bus.q
            );
            $stop;
        end
    endcase
end

endmodule 