module Bus (
	// Mux
	input [31:0]BusMuxIn_R0, [31:0]BusMuxIn_R1, [31:0]BusMuxIn_R2, [31:0]BusMuxIn_R3, 
	input [31:0]BusMuxIn_R4, [31:0]BusMuxIn_R5, [31:0]BusMuxIn_R6, [31:0]BusMuxIn_7, 
	input [31:0]BusMuxIn_R8, [31:0]BusMuxIn_R9, [31:0]BusMuxIn_R10, [31:0]BusMuxIn_R11, 
	input [31:0]BusMuxIn_R12, [31:0]BusMuxIn_R13, [31:0]BusMuxIn_R14, [31:0]BusMuxIn_R15, 
	input [31:0]BusMuxIn_HI, [31:0]BusMuxIn_LO, [31:0]BusMuxIn_Zhigh, [31:0]BusMuxIn_Zlow,
	input [31:0]BusMuxIn_PC, [31:0]BusMuxIn_MDR, [31:0]BusMuxIn_InPort, [31:0]C_Sign_Extended,

	// Encoder
	input R0Out, R1Out, R2Out, R3Out, R4Out, R5Out, R6Out, R7Out, 
	input R8Out, R9Out, R10Out, R11Out, R12Out, R13Out, R14Out, R15Out, 
	input HIOut, LOOut, ZhighOut, ZlowOut, PCOut, MDROut, InPortOut, Cout
			
	output wire [31:0]BusMuxOut
);

reg [31:0] q; 

always @ (*) begin 
	//default set q to all 0
	q = 32'b0;

	if      (R0Out) q = BusMuxIn_R0;
	else if (R1Out) q = BusMuxIn_R1;
	else if (R2Out) q = BusMuxIn_R2;
	else if (R3Out) q = BusMuxIn_R3;
	else if (R4Out) q = BusMuxIn_R4;
	else if (R5Out) q = BusMuxIn_R5;
	else if (R6Out) q = BusMuxIn_R6;
	else if (R7Out) q = BusMuxIn_R7;
	else if (R8Out) q = BusMuxIn_R8;
	else if (R9Out) q = BusMuxIn_R9;
	else if (R10Out) q = BusMuxIn_R10;
	else if (R11Out) q = BusMuxIn_R11;
	else if (R12Out) q = BusMuxIn_R12;
	else if (R13Out) q = BusMuxIn_R13;
	else if (R14Out) q = BusMuxIn_R14;
	else if (R15Out) q = BusMuxIn_R15;
	else if (HIOut) q = BusMuxIn_HI;
	else if (LOOut) q = BusMuxIn_LO;
	else if (ZhighOut) q = BusMuxIn_Zhigh;
	else if (ZlowOut) q = BusMuxIn_Zlow;
	else if (PCOut) q = BusMuxIn_PC;
	else if (MDROut) q = BusMuxIn_MDR;
	else if (InPortOut) q = BusMuxIn_InPort;
	else if (Cout) q = C_Sign_Extended;
end

assign BusMuxOut = q;

endmodule 