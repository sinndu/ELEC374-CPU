module ALU (
    input [31:0] A, B,
    input ADD, SUB,          
    input AND, OR, NEG, NOT, 
    input SHR, SHRA, SHL, ROR, ROL,
    input MUL, DIV,
	 input IncPC,
	output wire [63:0] ALU_Out_64
);

    wire [31:0] cla_result;
    wire cla_cout;

    wire [31:0] cla_A;
    assign cla_A = (NEG || IncPC ? 32'b0 : A); // set to 0 for neg or incrementing PC

    wire [31:0] cla_B;
    assign cla_B = (SUB || NEG ? ~B : B); // invert for neg/sub (2s comp)

    wire c_in_signal;
    assign c_in_signal = (SUB || NEG || IncPC ? 1'b1 : 1'b0); // carry to 1 for neg/sub (2s comp), or to increment PC by 1

	 // add/sub
    CLA_32 adder ( 
        .A(cla_A),
        .B(cla_B), 
        .c_in(c_in_signal), 
        .result(cla_result), 
        .c_out(cla_cout)
    );
	 
	 // Multiplication
	 wire [63:0] mul_result;
	 Booth_Multiplier multiplier (
        .M(A), 
        .Q(B), 
        .product(mul_result)
    );
	 
	 // Division
    wire [31:0] div_quotient;
    wire [31:0] div_remainder;
    NR_Division divider ( 
        .Q(A), 
        .M(B),
        .quotient(div_quotient), 
        .remainder(div_remainder)
    );


    reg[31:0] C;
    always @(*) begin
        if (ADD || SUB || NEG || IncPC) begin
           C = cla_result;
        end
        else if (AND) begin
            C = A & B;
        end
        else if (OR) begin
            C = A | B;
        end
        else if (NOT) begin
            C = ~B; 
        end
        else if (SHR) begin
            C = A >> B; 
        end
        else if (SHL) begin
            C = A << B; 
        end
        else if (SHRA) begin
            C = $signed(A) >>> B; 
        end
        else if (ROR) begin
            C = (A >> B) | (A << (32 - B));
        end
        else if (ROL) begin
            C = (A << B) | (A >> (32 - B));
        end
        else begin
            C = 32'b0; // default case
        end
    end
	 
    assign ALU_Out_64 =
      ({64{MUL}} & mul_result) |
      ({64{DIV}} & {div_remainder, div_quotient}) |
      {32'b0, C};
		
endmodule