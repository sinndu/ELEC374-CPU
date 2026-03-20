`timescale 1ns/1ps

module Booth_Multiplier_tb;

    reg signed [31:0] M;
    reg signed [31:0] Q;

    wire signed [63:0] product;

    Booth_Multiplier tb_mul (
        .M(M), 
        .Q(Q), 
        .product(product)
    );

    initial begin
        $display("Starting Booth Multiplier Tests:");
        
        M = 10; Q = 10; // POS * POS
        #10; // Wait 10ns
        if (product === 100) 
            $display("PASS: 10 * 10 = %d", product);
        else 
            $display("FAIL: 10 * 10. Expected 100, got %d", product);

        M = 20; Q = -5; // POS * NEG
        #10;
        if (product === -100) 
            $display("PASS: 20 * -5 = %d", product);
        else 
            $display("FAIL: 20 * -5. Expected -100, got %d", product);

        M = -5; Q = -5; // NEG * NEG
        #10;
        if (product === 25) 
            $display("PASS: -5 * -5 = %d", product);
        else 
            $display("FAIL: -5 * -5. Expected 25, got %d", product);

        M = 12345; Q = 0; // * BY 0
        #10;
        if (product === 0) 
            $display("PASS: 12345 * 0 = %d", product);
        else 
            $display("FAIL: 12345 * 0. Expected 0, got %d", product);

        M = 100000; Q = -2; // BIG
        #10;
        if (product === -200000) 
            $display("PASS: 100000 * -2 = %d", product);
        else 
            $display("FAIL: 100000 * -2. Expected -200000, got %d", product);

        $display("Tests Complete.");
        $stop; 
    end

endmodule