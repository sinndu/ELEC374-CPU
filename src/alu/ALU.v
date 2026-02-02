module ALU (
    input [31:0] A, 
    input [31:0] B,
    input [4:0] shift_amount,

    //control signals
    input ADD, SUB, NEG,
    input AND_op, OR_op, NOT_op,
    input SHR, SHL, SHRA, ROR, ROL,
    input MUL, DIV,

    //results
    output reg [63:0] Z_data_in; // placehold for 64-bit Z register
);
    //internal wires to get results from sub-modules
    wire [31:0] add_sub_res;
    wire [31:0] logic_res;
    wire [31:0] shift_res;
    wire [63:0] mul_res;
    wire [31:0] div_quotient;
    wire [31:0] div_remainder;
    wire cout;

	 // Addition/Subtraction
     wire [31:0] actual_A = (NEG) ? 32'b0 : A; // If NEG is high, set A to 0 for negation

    ALU_Add_Sub adder_unit ( 
        .A(actual_A), 
        .B(B), 
        .sub_ctrl(SUB | NEG), 
        .result(add_sub_res), 
        .c_out(cout)
    );
	 
     // Logic unit 
    ALU_LogicUnit logic_unit ( 
        .A(A), 
        .B(B), 
        .AND(AND_op), 
        .OR(OR_op), 
        .NOT(NOT_op), 
        .logic_result(logic_res)
    );
    
     // Shifter
    ALU_Shifter shifter_unit (
        .A(A), 
        .shift_amount(shift_amount), 
        .SHR(SHR), 
        .SHRA(SHRA), 
        .SHL(SHL), 
        .ROR(ROR), 
        .ROL(ROL), 
        .shift_result(shift_res)
    );

	 // Multiplication  
	 Booth_Multiplier multiplier (
        .M(A), 
        .Q(B), 
        .product(mul_res)
    );
	 
	 // Division
    NR_Division divider ( 
        .Q(A), 
        .M(B),
        .quotient(div_quotient), 
        .remainder(div_remainder)
    );

    // Final output multiplexer based on control signals
    always @(*) begin
        if (ADD || SUB || NEG) begin
            Z_data_in = {32'b0, add_sub_res}; // Extend to 64 bits
        end
        else if (AND_op || OR_op || NOT_op) begin
            Z_data_in = {32'b0, logic_res}; // Extend to 64 bits
        end
        else if (SHR || SHL || SHRA || ROR || ROL) begin
            Z_data_in = {32'b0, shift_res}; // Extend to 64 bits
        end
        else if (MUL) begin
            Z_data_in = mul_res; // Already 64 bits
        end
        else if (DIV) begin
            Z_data_in = {div_remainder, div_quotient}; // Remainder in upper 32 bits, Quotient in lower 32 bits
        end
        else begin
            Z_data_in = 64'b0; // Default case
        end
    end

endmodule
    