module Computer(
	input Clock, clear,
	input PCin, PCout,
	input IRin, CONin,
	input ZLowout,
	input MARin, MDRin, MDRout,
	input Read, Write,
	input Rin, Rout,
	input Yin, Zin,
	input Cout,
	input [3:0] ALU_operation,
	input Gra, Grb, Grc
	
);

wire [31:0] Mdatain;
wire [31:0] MDR_out;
wire [31:0] MAR_out;


datapath DUT(

    .clock(Clock), .clear(clear),
    .in_memory_data(Mdatain),
    .PCin(PCin), .PCout(PCout), 	
    .IRin(IRin), .CONin(CONin),
    .ZLowout(ZLowout), 
    .MARin(MARin), .MDRin(MDRin), .MDRout(MDRout), .read(Read),
    .Rin(Rin), .Rout(Rout), 
    .Yin(Yin), .Zin(Zin),
	 .Cout(Cout),
    .ALU_operation(ALU_operation), 
    .Gra(Gra), .Grb(Grb), .Grc(Grc),

    .MAR_out(MAR_out),
    .MDR_out(MDR_out)
);

RAM memory(
    .clk(Clock), .clear(clear),
    .read(Read), .write(Write),
    .addr(MAR_out[8:0]),
    .data_in(MDR_out), 
    .data_out(Mdatain)

);

endmodule