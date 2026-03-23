module Computer(
	input Clock, clear,

    input [31:0] in_port_data,
    output [31:0] out_port_data,

	input PCin, PCout,
	input IRin, CONin,
	input MARin, MDRin, MDRout,
	input Read, Write,
	input Rin, Rout,
    input HIin, HIout, LOin, LOout,
	input Yin, Zin, ZHighout, ZLowout, 
	input Cin, Cout,
    input InPortin, InPortout,
    input OutPortin, OutPortout,
	input [3:0] ALU_operation,
	input Gra, Grb, Grc, Glr,
    input BAout,              
    output con_ff_out
);

wire [31:0] Mdatain; 
wire [31:0] MDR_out;
wire [31:0] MAR_out;


datapath DUT(
    .clock(Clock), .clear(clear),
    .in_memory_data(Mdatain),
    .in_inport_data(in_port_data),
    .out_outport_data(out_port_data),
    .PCin(PCin), .PCout(PCout), 	
    .IRin(IRin), .CONin(CONin),
    .MARin(MARin), .MDRin(MDRin), .MDRout(MDRout), .read(Read),
    .Rin(Rin), .Rout(Rout),
    .HIin(HIin), .HIout(HIout), .LOin(LOin), .LOout(LOout),
    .Yin(Yin), .Zin(Zin), .ZHighout(ZHighout), .ZLowout(ZLowout), 
    .Cout(Cout),
    .InPortin(InPortin), .InPortout(InPortout),
    .OutPortin(OutPortin), .OutPortout(OutPortout),
    .ALU_operation(ALU_operation), 
    .Gra(Gra), .Grb(Grb), .Grc(Grc), .Glr(Glr),
    .BAout(BAout),
    .con_ff_out(con_ff_out),
    .MAR_out(MAR_out), .MDR_out(MDR_out)
);

RAM memory(
    .clk(Clock), .clear(clear),
    .read(Read), .write(Write),
    .addr(MAR_out[8:0]),
    .data_in(MDR_out), 
    .data_out(Mdatain)
);

endmodule