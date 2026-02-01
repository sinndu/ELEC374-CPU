module RCA (
    input [31:0] A, B,
    input c_in,          // Set to 1 for sub
    output reg [31:0] result, 
    output c_out         
);

    reg [32:0] localCarry; 
    integer i;

    always @(A or B or c_in) begin
        localCarry[0] = c_in; 

        for(i = 0; i < 32; i = i + 1) begin
            result[i] = A[i] ^ B[i] ^ localCarry[i];
            localCarry[i + 1] = (A[i] & B[i]) | (A[i] & localCarry[i]) | (B[i] & localCarry[i]);
        end
    end

    assign c_out = localCarry[32]; 

endmodule