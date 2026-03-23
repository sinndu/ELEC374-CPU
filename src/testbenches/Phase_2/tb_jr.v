`timescale 1ns/10ps
module tb_jr;
    reg Clock, clear;
    reg PCin, PCout, IRin, CONin;
    reg MARin, MDRin, MDRout, Read, Write;
    reg Rin, Rout, Yin, Zin, ZLowout;
    reg Cout, BAout, Gra, Grb, Grc, Glr;

    parameter   Default = 4'b0000, T0 = 4'b0001, T1 = 4'b0010, T2 = 4'b0011, 
                T3 = 4'b0100, done = 4'b1111;
    reg [3:0] Present_state = Default;

    parameter   IncPC = 4'b1101, NONE = 4'b1110;
    reg [3:0] ALU_operation = NONE;
    wire con_ff_out;

    Computer SRC(
        .Clock(Clock), .clear(clear),
        .PCin(PCin), .PCout(PCout), 	
        .IRin(IRin), .CONin(CONin),
        .MARin(MARin), .MDRin(MDRin), .MDRout(MDRout), .Read(Read), .Write(Write),
        .Rin(Rin), .Rout(Rout),
        .Yin(Yin), .Zin(Zin), .ZLowout(ZLowout), 
        .Cout(Cout), .BAout(BAout),
        .ALU_operation(ALU_operation), 
        .Gra(Gra), .Grb(Grb), .Grc(Grc), .Glr(Glr), 
        .con_ff_out(con_ff_out)
    );

    initial begin
        Clock = 0;
        forever #10 Clock = ~Clock;
    end

    initial begin
        // Initialize all signals to 0 to prevent X propagation
        PCin = 0; PCout = 0; IRin = 0; CONin = 0;
        MARin = 0; MDRin = 0; MDRout = 0; Read = 0; Write = 0;
        Rin = 0; Rout = 0; Yin = 0; Zin = 0; ZLowout = 0;
        Cout = 0; BAout = 0; Gra = 0; Grb = 0; Grc = 0; Glr = 0;
        
        clear = 1;
        #25;
        clear = 0;

        // Initialize memory
        $readmemh("jr.hex", SRC.memory.mem);
        SRC.DUT.R12.storage = 32'h000000FF; 
        SRC.DUT.PC.storage = 32'h00000010;
    end

    always @(posedge Clock) begin
        begin
        case (Present_state)
            Default : Present_state = T0;
            T0 : Present_state = T1;
            T1 : Present_state = T2;
            T2 : Present_state = T3;
            T3 : Present_state = done;
        endcase
    end
    end

    always @(negedge Clock) begin
        // Reset all control signals each cycle
        PCout <= 0; ZLowout <= 0; MDRout <= 0; Rout <= 0;
        MARin <= 0; Zin <= 0; PCin <= 0; MDRin <= 0; 
        IRin <= 0; Yin <= 0; Read <= 0; Write <= 0; Rin <= 0;
        ALU_operation <= NONE; Gra <= 0; Grb <= 0; Grc <= 0; Glr <= 0; 
        Cout <= 0; BAout <= 0; CONin <= 0;

        case (Present_state)
            T0: begin 
                PCout <= 1; MARin <= 1; ALU_operation <= IncPC; Zin <= 1;
            end
            T1: begin 
                ZLowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
            end
            T2: begin 
                MDRout <= 1; IRin <= 1;
            end
            T3: begin 
                Gra <= 1; Rout <= 1; PCin <= 1;
            end
        endcase
    end
endmodule