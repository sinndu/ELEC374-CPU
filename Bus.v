module Bus (
	//Mux
	input [31:0]BusMuxIn_R0, [31:0]BusMuxIn_R1, [31:0]BusMuxIn_R2, [31:0]BusMuxIn_R3, 
		   [31:0]BusMuxIn_R4, [31:0]BusMuxIn_R5, [31:0]BusMuxIn_R6, [31:0]BusMuxIn_7, 
			[31:0]BusMuxIn_R8, [31:0]BusMuxIn_R9, [31:0]BusMuxIn_R10, [31:0]BusMuxIn_R11, 
			[31:0]BusMuxIn_R12, [31:0]BusMuxIn_R13, [31:0]BusMuxIn_R14, [31:0]BusMuxIn_R15, 
			[31:0]BusMuxIn_HI, [31:0]BusMuxIn_LO, [31:0]BusMuxIn_Zhigh, [31:0]BusMuxIn_Zlow,
			[31:0]BusMuxIn_PC, [31:0]BusMuxIn_MDR, [31:0]BusMuxIn_InPort, [31:0]C_Sign_Extended
	//Encoder
	input R0Out, R1Out, R2Out, R3Out, R4Out, R5Out, R6Out, R7Out, 
			R8Out, R9Out, R10Out, R11Out, R12Out, R13Out, R14Out, R15Out, 
			HIOut, LOOut, ZhighOut, ZlowOut, PCOut, MDROut, InPortOut, Cout
			
	output wire [31:0]BusMuxOut
);

reg [31:0] q; 

always @ (*) begin 
	if(R0Out) q = BusMuxIn_R0;
	if(R1Out) q = BusMuxIn_R1;
	if(R2Out) q = BusMuxIn_R2;
	if(R3Out) q = BusMuxIn_R3;
	if(R4Out) q = BusMuxIn_R4;
	if(R5Out) q = BusMuxIn_R5;
	if(R6Out) q = BusMuxIn_R6;
	if(R7Out) q = BusMuxIn_R7;
	if(R8Out) q = BusMuxIn_R8;
	if(R9Out) q = BusMuxIn_R9;
	if(R10Out) q = BusMuxIn_R10;
	if(R11Out) q = BusMuxIn_R11;
	if(R12Out) q = BusMuxIn_R12;
	if(R13Out) q = BusMuxIn_R13;
	if(R14Out) q = BusMuxIn_R14;
	if(R15Out) q = BusMuxIn_R15;
	if(HIOut) q = BusMuxIn_HI;
	if(LOOut) q = BusMuxIn_LO;
	if(ZhighOut) q = BusMuxIn_Zhigh;
	if(ZlowOut) q = BusMuxIn_Zlow;
	if(PCOut) q = BusMuxIn_PC;
	if(MDROut) q = BusMuxIn_MDR;
	if(InPortOut) q = BusMuxIn_InPort;
	if(Cout) q = C_Sign_Extended;
end

assign BusMuxOut = q;

endmodule 