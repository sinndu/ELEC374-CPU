module Booth_Multiplier (
    input signed [31:0] M, 
    input signed [31:0] Q,
    output reg signed [63:0] product
);

    reg [2:0] three_bits;
    integer i;
    reg signed [63:0] partial_product;
    
    wire [32:0] Q_extended;
    assign Q_extended = {Q, 1'b0}; // Adding 0 on the right

    always @(M or Q or Q_extended) begin
        product = 64'b0; 
        
        
        for (i = 0; i < 16; i = i + 1) begin
            
            three_bits = Q_extended[2*i + 2 : 2*i]; // Get 3 bits
            
            partial_product = 64'b0;

            case (three_bits) // Get value from table for bit pair
                3'b000: partial_product = 0;             // 0
                3'b001: partial_product = M;             // 1M
                3'b010: partial_product = M;             // 1M
                3'b011: partial_product = 2 * M;         // 2M
                3'b100: partial_product = -(2 * M);      // 2M
                3'b101: partial_product = -M;            // 1M
                3'b110: partial_product = -M;            // 1M
                3'b111: partial_product = 0;             // 0
                default: partial_product = 0;
            endcase

            product = product + (partial_product << (2*i)); // Shift by 2*i for total
        end
    end

endmodule