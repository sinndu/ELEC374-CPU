module ALU (
    input [31:0] A, B,
    input ADD, SUB,          
    input AND, OR, NEG, NOT, 
    input SHR, SHRA, SHL, ROR, ROL,
    input MUL, DIV, 
	output wire [63:0] ALU_Out_64 // 64 output for div and mul
);

    reg [63:0] C, // result 

    wire [31:0] rca_result;
    wire rca_cout;

    wire [31:0] rca_A;
    assign rca_A = (NEG ? 32'b0 : A); // set to 0 for neg

    wire [31:0] rca_B;
    assign rca_B = (SUB || NEG ? ~B : B); //invert for neg/sub (2s comp)

    wire c_in_signal;
    assign c_in_signal = (SUB || NEG ? 1'b1 : 1'b0); // carry to 1 for neg/sub (2s comp)

//	 // Addition / Subtraction
//    RCA_32 adder ( 
//        .A(rca_A), 
//        .B(rca_B), 
//        .c_in(c_in_signal), 
//        .result(rca_result), 
//        .c_out(rca_cout)
//    );
	 
	 // Multiplication
	 wire [63:0] mul_result;
	 Booth_Multiplier multiplier (
        .M(A), .Q(B), .product(mul_res)
    );
	 
	 // Division
    NR_Division divider ( 
        .Q(A), .M(B), .quotient(div_quotient), .remainder(div_remainder)
    );

    // Final output multiplexer based on control signals
    always @(*) begin
        //default to zero
        Z_data_in = 64'b0;

        // addition/subtraction/negation unit
        if (ADD || SUB || NEG) begin
//            C = rca_result;
        end

        // internal logic unit
        else if (AND) begin
            Z_data_in = {32'b0, A & B};
        end
        else if (OR) begin
            Z_data_in = {32'b0, A | B};
        end
        else if (NOT) begin 
            Z_data_in = {32'b0, ~A};
        end

        // shift/rotate unit
        else if (SHR) begin
            Z_data_in = {32'b0, A >> shift_amount};
        end
        else if (SHRA) begin
            Z_data_in = {32'b0, $signed(A) >>> shift_amount};
        end
        else if (SHL) begin
            Z_data_in = {32'b0, A << shift_amount};
        end
        else if (ROR) begin
            Z_data_in = {32'b0, (A >> shift_amount) | (A << (32 - shift_amount))};
        end
        else if (ROL) begin
            Z_data_in = {32'b0, (A << shift_amount) | (A >> (32 - shift_amount))};
        end
        
        // multiplication unit
        else if (MUL) begin
            Z_data_in = mul_res;
        end

        // division unit
        else if (DIV) begin
            Z_data_in = {div_remainder, div_quotient}; // Remainder in upper 32 bits, Quotient in lower 32 bits
        end
        
        else
            Z_data_in = 64'b0; // Default case
    end

endmodule