`timescale 1ns/10ps
module tb_in_out;
    reg PCout, Zlowout, MDRout, Rout;
    reg MARin, Zin, PCin, MDRin, IRin, Yin, CONin;
    reg Read, Write, Rin;
    reg Gra, Grb, Grc, Glr;
	reg Cout;
    reg Clock, clear;
    reg BAout;
    reg InPortin, InPortout, OutPortin, OutPortout;
    reg [31:0] in_port_data;
    wire [31:0] out_port_data;

    parameter   Default = 4'b0000,
                T0_IN = 4'b0001, T1_IN = 4'b0010, T2_IN = 4'b0011, T3_IN = 4'b0100,
                T0_OUT = 4'b0101, T1_OUT = 4'b0110, T2_OUT = 4'b0111, T3_OUT = 4'b1000, 
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
        in_port_data = 32'h0000AAAA; // Example input data for IN instruction
		#25;
		clear = 0;

		//initialize memory and registers
        $readmemh("in_out.hex", SRC.memory.mem);
		SRC.DUT.R5.storage = 32'h0000FFFF;
        SRC.DUT.R7.storage = 32'h0000BBBB;
end

always @(posedge Clock) // finite state machine; if clock rising-edge
    begin
        case (Present_state)
            Default  : Present_state = T0_IN;
            // IN r5 Instruction sequence
            T0_IN    : Present_state = T1_IN;
            T1_IN    : Present_state = T2_IN;
            T2_IN    : Present_state = T3_IN;
            T3_IN    : Present_state = T0_OUT; // Move to next instruction
            
            // OUT r7 Instruction sequence
            T0_OUT   : Present_state = T1_OUT;
            T1_OUT   : Present_state = T2_OUT;
            T2_OUT   : Present_state = T3_OUT;
            T3_OUT   : Present_state = done;
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
    InPortin <= 0; InPortout <= 0; OutPortin <= 0; OutPortout <= 0;

        case (Present_state)
            Default: begin
                        PCout = 0; Zlowout = 0; MDRout = 0; // initialize the signals
                        Rout = 0; MARin = 0; Zin = 0;
                        PCin = 0; MDRin = 0; IRin = 0; Yin = 0;
                        Read = 0; Write = 0; 
                        ALU_operation = NONE; Rin = 0;
						Gra = 0; Grb = 0; Grc = 0; Glr = 0;
						Cout = 0; CONin = 0; BAout = 0; 
						InPortin = 0; InPortout = 0; OutPortin = 0; OutPortout = 0;
            end
            T0_IN: begin
                        PCout <= 1; MARin <= 1; ALU_operation <= IncPC; Zin <= 1;
            end
            T1_IN: begin
                        Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
            end
            T2_IN: begin
                        MDRout <= 1; IRin <= 1; InPortin <= 1;
            end
            T3_IN: begin
                        Gra <= 1; Rin <= 1; InPortout <= 1;
            end

            T0_OUT: begin
                        PCout <= 1; MARin <= 1; ALU_operation <= IncPC; Zin <= 1;
            end
            T1_OUT: begin
                        Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
            end
            T2_OUT: begin
                        MDRout <= 1; IRin <= 1;
            end
            T3_OUT: begin
                        Gra <= 1; Rout <= 1; OutPortin <= 1;
            end
        endcase
    end
	 
endmodule 