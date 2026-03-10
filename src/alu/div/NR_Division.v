module NR_Division (
    input [31:0] Q,  // dividend 
    input [31:0] M,  // divisor
    output reg [31:0] quotient,
    output reg [31:0] remainder
);
    reg [63:0] AQ; // AQ combined 
    integer i;

    always @(Q or M) begin
        AQ = {32'b0, Q};  // Init AQ

        for (i = 0; i < 32; i = i + 1) begin
            AQ = AQ << 1; // Shift AQ by 1
            if (AQ[63] == 0) begin
                AQ[63:32] = AQ[63:32] - M; // If positive, sub M
            end else begin
                AQ[63:32] = AQ[63:32] + M; // Else if negative, add M
            end

            if (AQ[63] == 0) begin
                AQ[0] = 1; // Set last bit to 1 if positive
            end else begin
                AQ[0] = 0;	// Set last bit to 0 if negative
            end
        end

        if (AQ[63] == 1) begin
            AQ[63:32] = AQ[63:32] + M; // add M to the end if negative (correction)
        end

        quotient = AQ[31:0];
        remainder = AQ[63:32];
    end
endmodule