module Computer(
	input clock, reset,
    input stop,


    input [31:0] in_port_data,
    output [7:0] seven_seg_ones,
    output [7:0] seven_seg_tens,


    output tb_stop
);

//data
wire [31:0] Mdatain;
wire [31:0] MDR_out;
wire [31:0] MAR_out;
wire [31:0] out_port_data;
wire [31:0] IR;
wire [3:0] ALU_operation;
wire con_ff_out;

//control signals
wire HIin, LOin, CONin,
     PCin, IRin,
     Yin, Zin,
     MARin, MDRin, 
     OutPortin, InPortout,
     Read, Write,
     Cout, BAout,

     PCout,
     MDRout, 
     ZHighout, ZLowout,
     HIout, LOout,

     Rin, Rout,
     Gra, Grb, Grc, Glr,
     clear;

datapath DUT(
    .clock(clock), .clear(clear),
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
    .InPortout(InPortout),
    .OutPortin(OutPortin),
    .ALU_operation(ALU_operation), 
    .Gra(Gra), .Grb(Grb), .Grc(Grc), .Glr(Glr),
    .BAout(BAout),
    .con_ff_out(con_ff_out),
    .MAR_out(MAR_out), .MDR_out(MDR_out),
    .IR_output(IR)
);

RAM memory(
    .clk(clock), .clear(clear),
    .read(Read), .write(Write),
    .addr(MAR_out[8:0]),
    .data_in(MDR_out), 
    .data_out(Mdatain)
);

control_unit control(
    .clock(clock), .reset(reset),
    .stop(stop),
    .CON_FF(con_ff_out),
    .IR(IR),
    .HIin(HIin), .LOin(LOin), .CONin(CONin),
    .PCin(PCin), .IRin(IRin),
    .Yin(Yin), .Zin(Zin),
    .MARin(MARin), .MDRin(MDRin), 
    .OutPortin(OutPortin), .InPortout(InPortout),
    .Read(Read), .Write(Write),
    .Cout(Cout), .BAout(BAout),
    .PCout(PCout),
    .MDRout(MDRout), 
    .ZHighout(ZHighout), .ZLowout(ZLowout),
    .HIout(HIout), .LOout(LOout),
    .Rin(Rin), .Rout(Rout),
    .Gra(Gra), .Grb(Grb), .Grc(Grc), .Glr(Glr),
    .ALU_op(ALU_operation),
    .clear(clear),
    .tb_stop(tb_stop)
);

Seven_Seg_Display_Out ones_digit(
    .outputt(seven_seg_ones),
    .clk(clock),
    .data(out_port_data[3:0])
);

Seven_Seg_Display_Out tens_digit(
    .outputt(seven_seg_tens),
    .clk(clock),
    .data(out_port_data[7:4])
);

endmodule