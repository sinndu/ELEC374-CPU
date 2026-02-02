module ALU_Shifter (
    input [31:0] A, 
    input [4:0] shift_amount, 
    input SHR, SHRA, SHL, ROR, ROL,
    output reg [31:0] shift_result
);
    always @(*) begin
        if (SHR)        // Logical right shift
            shift_result = A >> shift_amount; 

        else if (SHRA)  // Arithmetic right shift
            shift_result = $signed(A) >>> shift_amount; 

        else if (SHL)   // Logical left shift
            shift_result = A << shift_amount; 
    
        else if (ROR)   // Rotate right
            shift_result = (A >> shift_amount) | (A << (32 - shift_amount)); 
        
        else if (ROL)   // Rotate left
            shift_result = (A << shift_amount) | (A >> (32 - shift_amount)); 
        
        else            // No shift
            shift_result = A; 
        
    end
endmodule