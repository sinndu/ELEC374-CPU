`timescale 1ns/1ps

module CLA_32_tb;

    reg [31:0] A, B;
    reg CIN;

    wire [31:0] SUM;
    wire COUT;
    wire OVERFLOW;

    CLA cla_tb (
        .A(A), .B(B),
        .CIN(CIN),
        .OPCODE(OPCODE),
        .SUM(SUM),
        .COUT(COUT),
        .OVERFLOW(OVERFLOW)
    );

    initial begin
        $display("Starting CLA Tests:");

        // Test 1: Addition
        A = 32'h00000015; B = 32'h00000027; CIN = 0; OPCODE = 3'b000; // ADD
        #20;
        if (SUM === 32'h0000003C && COUT === 0) 
            $display("PASS: ADD 15 + 27 = %h", SUM);
        else 
            $display("FAIL: ADD. Expected 3C, Got %h", SUM);

        // Test 2: Subtraction
        A = 32'h00000050; B = 32'h00000020; CIN = 0; OPCODE = 3'b001; // SUB
        #20;
        if (SUM === 32'h00000030 && COUT === 0) 
            $display("PASS: SUB 50 - 20 = %h", SUM);
        else 
            $display("FAIL: SUB. Expected 30, Got %h", SUM);

        // Test 3: Negation
        A = 32'h00000015; B = 32'h00000027; CIN` = 1; OPCODE = 3'b111; // NEG
        #20;
        if (SUM === 32'hFFFFFFE9 && COUT === 1) 
            $display("PASS: NEG -15 = %h", SUM);
        else 
            $display("FAIL: NEG. Expected FFFFFFE9, Got %h", SUM);

        $display("CLA Tests Complete.");
        $stop;
    end
endmodule