module datapath(
	input wire clock, clear,

    //external data
    input wire [31:0] in_memory_data,
    input wire [31:0] in_inport_data,

    //control signals
    input wire PCin, PCout,
    input wire IRin,
    input wire MARin, MDRin, MDRout, read,
    input wire HIin, HIout, LOin, LOout,
    input wire Yin, Zin, ZHighout, ZLowout, 
    input wire InPortin, InPortout,
    input wire OutPortin, OutPortout,
    input wire Cout,
    input wire [3:0] reg_select,
    input wire Rin, Rout, 
    input wire [3:0] ALU_operation
);

wire [31:0] BusMuxOut, BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, 
    BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, 
	BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, 
	BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, 
	BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Zhigh, BusMuxIn_Zlow,
	BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_InPort, C_Sign_Extended;
 
//decoder
wire [15:0] reg_decode;
assign reg_decode = 16'b1 << reg_select;

//ensure one-hot IF Rin is enabled
wire [15:0] reg_in;
assign reg_in = reg_decode & {16{Rin}};
wire [15:0] reg_out;
assign reg_out = reg_decode & {16{Rout}};

//Instantiate devices

//General-purpose registers
Register_32 R0(clock, clear, reg_in[0], BusMuxOut, BusMuxIn_R0);
Register_32 R1(clock, clear, reg_in[1], BusMuxOut, BusMuxIn_R1);
Register_32 R2(clock, clear, reg_in[2], BusMuxOut, BusMuxIn_R2);
Register_32 R3(clock, clear, reg_in[3], BusMuxOut, BusMuxIn_R3);
Register_32 R4(clock, clear, reg_in[4], BusMuxOut, BusMuxIn_R4);
Register_32 R5(clock, clear, reg_in[5], BusMuxOut, BusMuxIn_R5);
Register_32 R6(clock, clear, reg_in[6], BusMuxOut, BusMuxIn_R6);
Register_32 R7(clock, clear, reg_in[7], BusMuxOut, BusMuxIn_R7);
Register_32 R8(clock, clear, reg_in[8], BusMuxOut, BusMuxIn_R8);
Register_32 R9(clock, clear, reg_in[9], BusMuxOut, BusMuxIn_R9);
Register_32 R10(clock, clear, reg_in[10], BusMuxOut, BusMuxIn_R10);
Register_32 R11(clock, clear, reg_in[11], BusMuxOut, BusMuxIn_R11);
Register_32 R12(clock, clear, reg_in[12], BusMuxOut, BusMuxIn_R12);
Register_32 R13(clock, clear, reg_in[13], BusMuxOut, BusMuxIn_R13);
Register_32 R14(clock, clear, reg_in[14], BusMuxOut, BusMuxIn_R14);
Register_32 R15(clock, clear, reg_in[15], BusMuxOut, BusMuxIn_R15);

//data
//use special mdr register 
MDR MDR(clock, clear, MDRin, read, BusMuxOut, in_memory_data, BusMuxIn_MDR);
Register_32 HI(clock, clear, HIin, BusMuxOut, BusMuxIn_HI);
Register_32 LO(clock, clear, LOin, BusMuxOut, BusMuxIn_LO);

wire [31:0] IR_wire; //IR output does not feed back into the bus
Register_32 IR(clock, clear, IRin, BusMuxOut, IR_wire);

//control
Register_32 PC(clock, clear, PCin, BusMuxOut, BusMuxIn_PC);

wire [31:0] MAR_wire; //subject to change, this is the MAR output to the memory chip
Register_32 MAR(clock, clear, MARin, BusMuxOut, MAR_wire);

//IO
wire[31:0] to_InPort;
Register_32 InPort(clock, clear, InPortin, in_inport_data, BusMuxIn_InPort);
wire[31:0] out_outport_data;
Register_32 OutPort(clock, clear, OutPortin, BusMuxOut, out_outport_data);


//ALU

wire [31:0] Yout;
wire [63:0] Z;


Register_32 RY(clock, clear, Yin, BusMuxOut, Yout);
//decode ALU op
wire [15:0] ALU_decode;
assign ALU_decode = 16'b1 << ALU_operation;

ALU alu_op(
    Yout, BusMuxOut, 
    ALU_decode[0], ALU_decode[1],
    ALU_decode[2], ALU_decode[3], ALU_decode[4], ALU_decode[5],
    ALU_decode[6], ALU_decode[7], ALU_decode[8], ALU_decode[9], ALU_decode[10],
    ALU_decode[11], ALU_decode[12],
	 ALU_decode[13],
    Z
);

Register_32 RZhigh(clock, clear, Zin, Z[63:32], BusMuxIn_Zhigh);
Register_32 RZlow(clock, clear, Zin, Z[31:0], BusMuxIn_Zlow);


//Bus
Bus bus(
	BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, 
	BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, 
	BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, 
	BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, 
	BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Zhigh, BusMuxIn_Zlow,
	BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_InPort, C_Sign_Extended,

	reg_out[0], reg_out[1], reg_out[2], reg_out[3], reg_out[4], reg_out[5], reg_out[6], reg_out[7], 
	reg_out[8], reg_out[9], reg_out[10], reg_out[11], reg_out[12], reg_out[13], reg_out[14], reg_out[15], 
	HIout, LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout,
			
	BusMuxOut
);





endmodule
