`timescale 1ns/10ps
module tb_ldi_case1;
    reg PCout, Zlowout, MDRout, Rout;
    reg MARin, Zin, PCin, MDRin, IRin, Yin, CONin;
    reg Read, Write, Rin;
    reg Gra, Grb, Grc;
	reg Cout;
    reg Clock, clear;
    reg BAout;
    parameter   Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
                Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
                T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, done = 4'b1111;
    reg [3:0] Present_state = Default;

    parameter   ADD = 4'b0000, SUB = 4'b0001, AND = 4'b0010, OR = 4'b011, NEG = 4'b0100, NOT = 4'b0101, 
                SHR = 4'b0110, SHRA = 4'b0111, SHL = 4'b1000, ROR = 4'b1001, ROL = 4'b1010,
                MUL = 4'b1011, DIV = 4'b1100, IncPC = 4'b1101, NONE = 4'b1110;
    reg [3:0] ALU_operation = NONE;
	 
Computer SRC(
	.Clock(Clock), .clear(clear),
	.PCin(PCin), .PCout(PCout),
	.IRin(IRin), .CONin(CONin),
	.ZLowout(Zlowout),
	.MARin(MARin), .MDRin(MDRin), .MDRout(MDRout),
	.Read(Read), .Write(Write),
	.Rin(Rin), .Rout(Rout),
	.Yin(Yin), .Zin(Zin),
	.Cout(Cout),
	.ALU_operation(ALU_operation),
	.Gra(Gra), .Grb(Grb), .Grc(Grc),
    .BAout(BAout)
);

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

		//initialize memory and registers
		$readmemh("ldi_case1.hex", SRC.memory.mem);
end

always @(posedge Clock) // finite state machine; if clock rising-edge
    begin
        case (Present_state)
            Default : Present_state = Reg_load1a;
            Reg_load1a : Present_state = Reg_load1b;
            Reg_load1b : Present_state = Reg_load2a;
            Reg_load2a : Present_state = Reg_load2b;
            Reg_load2b : Present_state = Reg_load3a;
            Reg_load3a : Present_state = Reg_load3b;
            Reg_load3b : Present_state = T0;
            T0 : Present_state = T1;
            T1 : Present_state = T2;
            T2 : Present_state = T3;
            T3 : Present_state = T4;
            T4 : Present_state = T5;
			T5 : Present_state = done;
        endcase
    end

always @(negedge Clock)
    begin
    //clear all signals before switch case
    PCout <= 0; Zlowout <= 0; MDRout <= 0; Rout <= 0;
    MARin <= 0; Zin <= 0; PCin <= 0; MDRin <= 0;
    IRin <= 0; Yin <= 0; Read <= 0; Write <= 0;
    Rin <= 0; ALU_operation <= NONE;
    Gra <= 0; Grb <= 0; Grc <= 0;
	Cout <= 0; CONin <= 0; BAout <= 0;

        case (Present_state)
            Default: begin
                        PCout = 0; Zlowout = 0; MDRout = 0; // initialize the signals
                        Rout = 0; MARin = 0; Zin = 0;
                        PCin = 0; MDRin = 0; IRin = 0; Yin = 0;
                        Read = 0; Write = 0; ALU_operation = NONE;
                        Rin = 0;
						Gra = 0; Grb = 0; Grc = 0;
						Cout = 0; CONin = 0;
                        BAout = 0;
								
            end
            T0: begin
                        PCout <= 1; MARin <= 1; ALU_operation <= IncPC; Zin <= 1;
            end
            T1: begin
                        Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
            end
            T2: begin
                        MDRout <= 1; IRin <= 1;
            end
            T3: begin
                        Grb <= 1; BAout <= 1; Yin <= 1;
            end
            T4: begin
                        Cout <= 1; ALU_operation <= ADD; Zin <= 1;
            end
            T5: begin
                        Zlowout <= 1; Gra <= 1; Rin <= 1;
            end
        endcase
    end
	 
endmodule 