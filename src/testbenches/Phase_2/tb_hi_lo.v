`timescale 1ns/10ps
module tb_hi_lo;
    reg Clock, clear;
    reg PCout, Zlowout, MDRout, Rout;
    reg MARin, Zin, PCin, MDRin, IRin, Yin, CONin;
    reg Read, Write, Rin;
    reg HIin, HIout, LOin, LOout;
    reg Gra, Grb, Grc, Glr;
	reg Cout;
    reg BAout;
    reg InPortin, InPortout, OutPortin, OutPortout;
    reg [31:0] in_port_data;
    wire [31:0] out_port_data;

    parameter   Default = 4'b0000,
                T0_HI = 4'b0001, T1_HI = 4'b0010, T2_HI = 4'b0011, T3_HI = 4'b0100,
                T0_LO = 4'b0101, T1_LO = 4'b0110, T2_LO = 4'b0111, T3_LO = 4'b1000, 
                done = 4'b1111;
    reg [3:0] Present_state = Default;

    parameter   ADD = 4'b0000, SUB = 4'b0001, AND = 4'b0010, OR = 4'b0011, NEG = 4'b0100, NOT = 4'b0101, 
                SHR = 4'b0110, SHRA = 4'b0111, SHL = 4'b1000, ROR = 4'b1001, ROL = 4'b1010,
                MUL = 4'b1011, DIV = 4'b1100, IncPC = 4'b1101, NONE = 4'b1110;
    reg [3:0] ALU_operation = NONE;
	wire con_ff_out;
	 
Computer SRC(
	.Clock(Clock), .clear(clear),
    .in_port_data(in_port_data),
    .out_port_data(out_port_data),
	.PCin(PCin), .PCout(PCout),
	.IRin(IRin), .CONin(CONin),
	.ZLowout(Zlowout),
	.MARin(MARin), .MDRin(MDRin), .MDRout(MDRout),
    .HIin(HIin), .HIout(HIout), .LOin(LOin), .LOout(LOout),
	.Read(Read), .Write(Write),
	.Rin(Rin), .Rout(Rout),
	.Yin(Yin), .Zin(Zin),
    .InPortin(InPortin), .InPortout(InPortout),
    .OutPortin(OutPortin), .OutPortout(OutPortout),
	.Cout(Cout),.BAout(BAout),
	.ALU_operation(ALU_operation),
	.Gra(Gra), .Grb(Grb), .Grc(Grc), .Glr(Glr),
    .con_ff_out(con_ff_out) 
);

initial
    begin
		Clock = 0;
		forever #10 Clock = ~ Clock;
end

initial 
	begin
		clear = 1;
        in_port_data = 32'h0000AAAA;
		#25;
		clear = 0;

		//initialize memory and registers
        $readmemh("hi_lo.hex", SRC.memory.mem);
		SRC.DUT.R5.storage = 32'h0000FFFF;
        SRC.DUT.R1.storage = 32'h0000BBBB;
        SRC.DUT.HI.storage = 32'hAAAA0000;
        SRC.DUT.LO.storage = 32'hCCCC0000;
end

always @(posedge Clock) // finite state machine; if clock rising-edge
    begin
        case (Present_state)
            Default  : Present_state = T0_HI;
            // mfhi r5 Instruction sequence
            T0_HI    : Present_state = T1_HI;
            T1_HI    : Present_state = T2_HI;
            T2_HI    : Present_state = T3_HI;
            T3_HI    : Present_state = T0_LO; 
            
            // mflo r1 Instruction sequence
            T0_LO   : Present_state = T1_LO;
            T1_LO   : Present_state = T2_LO;
            T2_LO   : Present_state = T3_LO;
            T3_LO   : Present_state = done;
        endcase
    end

always @(negedge Clock)
    begin
    //clear all signals before switch case
    PCout <= 0; Zlowout <= 0; MDRout <= 0; Rout <= 0;
    MARin <= 0; Zin <= 0; PCin <= 0; MDRin <= 0;
    IRin <= 0; Yin <= 0; Read <= 0; Write <= 0;
    Rin <= 0; ALU_operation <= NONE;
    Gra <= 0; Grb <= 0; Grc <= 0; Glr <= 0;
	Cout <= 0; CONin <= 0; BAout <= 0;
    HIout <= 0; LOout <= 0;

        case (Present_state)
            Default: begin
                        PCout = 0; Zlowout = 0; MDRout = 0; // initialize the signals
                        Rout = 0; MARin = 0; Zin = 0;
                        PCin = 0; MDRin = 0; IRin = 0; Yin = 0;
                        Read = 0; Write = 0; 
                        ALU_operation = NONE; Rin = 0;
						Gra = 0; Grb = 0; Grc = 0; Glr = 0;
						Cout = 0; CONin = 0; BAout = 0; 
						HIout = 0; LOout = 0;
            end
            T0_HI: begin
                        PCout <= 1; MARin <= 1; ALU_operation <= IncPC; Zin <= 1;
            end
            T1_HI: begin
                        Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
            end
            T2_HI: begin
                        MDRout <= 1; IRin <= 1;
            end
            T3_HI: begin
                        Gra <= 1; Rin <= 1; HIout <= 1;
            end

            T0_LO: begin
                        PCout <= 1; MARin <= 1; ALU_operation <= IncPC; Zin <= 1;
            end
            T1_LO: begin
                        Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
            end
            T2_LO: begin
                        MDRout <= 1; IRin <= 1;
            end
            T3_LO: begin
                        Gra <= 1; Rin <= 1; LOout <= 1;
            end
        endcase
    end
	 
endmodule 