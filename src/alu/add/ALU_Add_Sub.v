module ALU_Add_Sub (
    input [31:0] A,
    input [31:0] B,
    input sub_ctrl,
    output [31:0] result,
    output cout
);
    wire [31:0] B_input;

    // If sub_ctrl is 1, invert B for subtraction (2's complement)
    assign B_input = B ^ {32{sub_ctrl}};

    // Instantiate the 32-bit carry-lookahead adder
    CLA_32 adder (
        .A(A),
        .B(B_input),
        .cin(sub_ctrl), // Use sub_ctrl as carry-in for subtraction
        .sum(result),
        .cout(cout)
    );
endmodule