`timescale 1ns/10ps
module tb_brpl;
    reg Clock, clear;
    reg PCin, PCout, IRin, CONin;
    reg MARin, MDRin, MDRout, Read;
    reg Rin, Rout, Yin, Zin, Zlowout;
    reg Cout, BAout, Gra, Grb, Grc, Glr;

    parameter   Default = 4'b0000, T0 = 4'b0001, T1 = 4'b0010, T2 = 4'b0011, 
                T3 = 4'b0100, T4 = 4'b0101, T5 = 4'b0110, T6 = 4'b0111, done = 4'b1111;
    reg [3:0] Present_state = Default;

    parameter   ADD = 4'b0000, IncPC = 4'b1101, NONE = 4'b1110;
    reg [3:0] ALU_operation = NONE;
    wire con_ff_out;

    Computer SRC(
        .Clock(Clock), .clear(clear),
        .PCin(PCin), .PCout(PCout), 	
        .IRin(IRin), .CONin(CONin),
        .MARin(MARin), .MDRin(MDRin), .MDRout(MDRout), .Read(Read),
        .Rin(Rin), .Rout(Rout),
        .Yin(Yin), .Zin(Zin), .ZLowout(Zlowout), 
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
        clear = 1;
        #25;
        clear = 0;
        $readmemh("brpl_r3_48.hex", SRC.memory.mem);
        SRC.DUT.R3.storage = 32'h00000001;
    end

    always @(posedge Clock) begin
        case (Present_state)
            Default : Present_state = T0;
            T0, T1, T2, T3, T4, T5 : Present_state = Present_state + 1;
            T6 : Present_state = done;
        endcase
    end

    always @(negedge Clock) begin
        PCout <= 0; Zlowout <= 0; MDRout <= 0; Rout <= 0;
        MARin <= 0; Zin <= 0; PCin <= 0; MDRin <= 0;
        IRin <= 0; Yin <= 0; Read <= 0; Rin <= 0;
        ALU_operation <= NONE; Gra <= 0; Grb <= 0; Grc <= 0; Glr <= 0;
        Cout <= 0; BAout <= 0; CONin <= 0;

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
                Gra <= 1; Rout <= 1; CONin <= 1; 
            end
            T4: begin 
                PCout <= 1; Yin <= 1; 
            end
            T5: begin 
                Cout <= 1; ALU_operation <= ADD; Zin <= 1; 
            end
            T6: begin 
                Zlowout <= 1; PCin <= con_ff_out; 
            end
        endcase
    end
endmodule