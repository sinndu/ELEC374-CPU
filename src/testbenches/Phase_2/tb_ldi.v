`timescale 1ns/10ps
module tb_ldi;
    reg Clock, clear;
    reg PCout, Zlowout, MDRout, Rout;
    reg MARin, Zin, PCin, MDRin, IRin, Yin, CONin;
    reg Read, Write, Rin;
    reg Gra, Grb, Grc, Glr;
    reg Cout, BAout;
    reg [3:0] ALU_operation;

    // State definitions
    parameter Default = 4'b0000, 
              T0 = 4'b0001, T1 = 4'b0010, T2 = 4'b0011, T3 = 4'b0100, T4 = 4'b0101, T5 = 4'b0110,
              CASE2_INIT = 4'b0111,
              done = 4'b1111;

    // ALU Operations
    parameter ADD = 4'b0000, IncPC = 4'b1101, NONE = 4'b1110;

    reg [3:0] Present_state = Default;

    // Instantiate System
    Computer SRC(
        .Clock(Clock), .clear(clear),
        .PCin(PCin), .PCout(PCout),
        .IRin(IRin), .CONin(CONin),
        .ZLowout(Zlowout),
        .MARin(MARin), .MDRin(MDRin), .MDRout(MDRout),
        .Read(Read), .Write(Write),
        .Rin(Rin), .Rout(Rout),
        .Yin(Yin), .Zin(Zin),
        .Cout(Cout),
        .ALU_operation(ALU_operation),
        .Gra(Gra), .Grb(Grb), .Grc(Grc), .Glr(Glr),
        .BAout(BAout)
    );

    // Clock Generation
    initial begin
        Clock = 0;
        forever #10 Clock = ~Clock;
    end

    // Initialization and Execution Control
    initial begin
        clear = 1;
        #25 clear = 0;

        // Load instructions into memory
        $readmemh("ldi.hex", SRC.memory.mem);
        SRC.DUT.R2.storage = 32'h00000057; 
    end

    // FSM State Transitions
    always @(posedge Clock) begin
        case (Present_state)
            Default    : Present_state = T0;
            T0, T1, T2, T3, T4 : Present_state = Present_state + 1;
            T5         : Present_state = done;
            done       : $finish;
            default    : Present_state = Default;
        endcase
    end

    // Control Signal Generation (at Negedge)
    always @(negedge Clock) begin
        PCout <= 0; Zlowout <= 0; MDRout <= 0; Rout <= 0;
        MARin <= 0; Zin <= 0; PCin <= 0; MDRin <= 0;
        IRin <= 0; Yin <= 0; Read <= 0; Write <= 0;
        Rin <= 0; ALU_operation <= NONE;
        Gra <= 0; Grb <= 0; Grc <= 0; Glr <= 0; 
        Cout <= 0; CONin <= 0; BAout <= 0;

        case (Present_state)
            T0: begin
                PCout <= 1; MARin <= 1; ALU_operation <= IncPC; Zin <= 1;
            end
            T1: begin 
                Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
            end
            T2: begin 
                MDRout <= 1; IRin <= 1;
            end
            T3: begin 
                Grb <= 1; BAout <= 1; Rout <= 1; Yin <= 1;
            end
            T4: begin
                Cout <= 1; ALU_operation <= ADD; Zin <= 1;
            end
            T5: begin
                Zlowout <= 1; Gra <= 1; Rin <= 1;
            end
        endcase
    end
endmodule