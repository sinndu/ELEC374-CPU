module ALU (
    input [31:0] A, B,
    input [4:0] shift_amount,

    //control signals
    input ADD, SUB, NEG,
    input AND, OR, NOT,
    input SHR, SHL, SHRA, ROR, ROL,
    input MUL, DIV,

    //results
    output reg [63:0] Z_data_in
);
    //internal wires to get results from sub-modules
    wire [31:0] add_sub_res;
    wire [63:0] mul_res;
    wire [31:0] div_quotient, div_remainder;
    wire cout;

	 // Addition/Subtraction module
    ALU_Add_Sub adder_unit (
        .A((NEG) ? 32'b0 : A), 
        .B(B), 
        .sub_ctrl(SUB | NEG), 
        .result(add_sub_res), 
        .c_out(cout)
    );

	 // Multiplication  
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
            Z_data_in = { {32{add_sub_res[31]}}, add_sub_res};
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