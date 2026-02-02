module ALU_LogicUnit (
    input [31:0] A,
    input [31:0] B,
    input AND, OR, NOT,
    output reg [31:0] logic_result
);
    always @(*) begin
        if (AND) begin
            logic_result = A & B;
        end
        else if (OR) begin
            logic_result = A | B;
        end
        else if (NOT) begin
            logic_result = ~A;
        end
        else begin
            logic_result = 32'b0; // Default case
        end
    end
endmodule