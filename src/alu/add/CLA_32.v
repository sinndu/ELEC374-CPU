module CLA_32 (
    input [31:0] A,
    input [31:0] B,
    input c_in,
    output [31:0] result,
    output c_out
);
    wire c_mid; //carry signal between the two 16-bit CLAs

    // lower 16 bits (0-15)
    CLA_16 low_16 (
        .A(A[15:0]),
        .B(B[15:0]),
        .cin(c_in),
        .sum(result[15:0]),
        .cout(c_mid)
    );

    // upper 16 bits (16-31)
    CLA_16 high_16 (
        .A(A[31:16]),
        .B(B[31:16]),
        .cin(c_mid),
        .sum(result[31:16]),
        .cout(c_out)
    );

endmodule