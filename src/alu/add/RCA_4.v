module RCA_4 (
	input [3:0] A,
	input [3:0] B,
	input cin,
	
	output result
);
	
reg[7:0] result;
reg[8:0] localCarry;

integer i;

always@(A or B)
	begin
		localCarry = 9'd0;
		for(i = 0; i < 8; i = i + 1)
			begin
				result[i] = A[i]^B[i]^localCarry[i];
				localCarry[i + 1] = (A[i] & B[i]) | (A[i] & localCarry[i]) | (B[i] & localCarry[i]);
			end
	end


endmodule