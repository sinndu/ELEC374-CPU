`timescale 1ns/1ps

module ALU_tb;

    reg [31:0] A, B;
    reg ADD, SUB, AND, OR, NEG, NOT;
    reg SHR, SHRA, SHL, ROR, ROL;
    reg MUL, DIV;

    wire [31:0] C;            
    wire [63:0] ALU_Out_64;   // for mul/div

    ALU alu_tb (
        .A(A), .B(B),
        .ADD(ADD), .SUB(SUB),
        .AND(AND), .OR(OR), .NEG(NEG), .NOT(NOT),
        .SHR(SHR), .SHRA(SHRA), .SHL(SHL), .ROR(ROR), .ROL(ROL),
        .MUL(MUL), .DIV(DIV),
        .C(C),
        .ALU_Out_64(ALU_Out_64)
    );

    task clear_signals; // task to clear all signals
        begin
            ADD=0; SUB=0; AND=0; OR=0; NEG=0; NOT=0;
            SHR=0; SHRA=0; SHL=0; ROR=0; ROL=0;
            MUL=0; DIV=0;
        end
    endtask

    initial begin
        $display("Starting ALU Tests:");
        clear_signals();
        
		  // AND
        A = 32'hFFFF0000; B = 32'h00FFFF00; AND = 1;
        #20;
        if (C === 32'h00FF0000) $display("PASS: AND Correct");
        else $display("FAIL: AND. Got %h", C);
        clear_signals();

        // OR
        A = 32'hF0F0F0F0; B = 32'h0F0F0F0F; OR = 1;
        #20;
        if (C === 32'hFFFFFFFF) $display("PASS: OR Correct");
        else $display("FAIL: OR. Got %h", C);
        clear_signals();

        // NOT
        A = 0; B = 32'h0000FFFF; NOT = 1;
        #20;
        if (C === 32'hFFFF0000) $display("PASS: NOT Correct");
        else $display("FAIL: NOT. Got %h", C);
        clear_signals();

        // MUL
        A = 100; B = 100; MUL = 1;
        #50; 
        if (ALU_Out_64 === 10000) $display("PASS: MUL 100 * 100 = 10000");
        else $display("FAIL: MUL. Expected 10000, Got %d", ALU_Out_64);
        clear_signals();

        // DIV
        A = 100; B = 4; DIV = 1;
        #50; 
        if (ALU_Out_64[31:0] === 25 && ALU_Out_64[63:32] === 0) 
            $display("PASS: DIV 100 / 4 = 25 r0");
        else 
            $display("FAIL: DIV. Expected 25 r0, Got Q:%d R:%d", ALU_Out_64[31:0], ALU_Out_64[63:32]);
        clear_signals();

        // SHL
        A = 1; B = 4; SHL = 1;
        #20;
        if (C === 16) $display("PASS: SHL 1 << 4 = 16");
        else $display("FAIL: SHL. Got %d", C);
        clear_signals();

        // SHR
        A = 16; B = 2; SHR = 1;
        #20;
        if (C === 4) $display("PASS: SHR 16 >> 2 = 4");
        else $display("FAIL: SHR. Got %d", C);
        clear_signals();

        // ROL
        A = 32'h80000000; B = 1; ROL = 1;
        #20;
        if (C === 1) $display("PASS: ROL Correct");
        else $display("FAIL: ROL. Got %h", C);
        clear_signals();

        // ROR
        A = 1; B = 1; ROR = 1;
        #20;
        if (C === 32'h80000000) $display("PASS: ROR Correct");
        else $display("FAIL: ROR. Got %h", C);
        clear_signals();

        $display("ALU Logic & Shift Tests Complete.");
        $stop;
    end

endmodule