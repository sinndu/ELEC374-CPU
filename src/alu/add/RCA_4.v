module RCA_4 (
	input [3:0] A,
	input [3:0] B,
	input cin,
	output [3:0] sum,
	output cout
);
	
	reg[3:0] s;
	reg[4:0] c;

	integer i;

	always @(*) begin
		c[0] = cin;

		for(i = 0; i < 4; i = i + 1) begin
			// sum = A XOR B XOR CarryIn
			s[i] = A[i] ^ B[i] ^ c[i];

			// carry = (A AND B) OR (CarryIn AND (A XOR B))
			c[i+1] = (A[i] & B[i] | (c[i] & (A ^ B)));
		end
	end

	assign sum = s;
	assign cout = c[4]; //final bit = carryout

endmodule