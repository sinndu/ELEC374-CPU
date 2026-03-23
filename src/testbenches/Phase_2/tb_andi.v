`timescale 1ns/10ps
module tb_andi;
    reg Clock, clear;
    reg PCin, PCout;
    reg IRin;
    reg MARin, MDRin, MDRout;
    reg Read;
    reg Rin, Rout;
    reg Yin, Zin, Zlowout;
    reg Cout;
    reg Gra, Grb, Grc, Glr;
    reg BAout;

    parameter   Default = 4'b0000, T0 = 4'b0001, T1 = 4'b0010, T2 = 4'b0011, 
                T3 = 4'b0100, T4 = 4'b0101, T5 = 4'b0110, done = 4'b1111;
    reg [3:0] Present_state = Default;

    parameter   AND = 4'b0010, IncPC = 4'b1101, NONE = 4'b1110;
    reg [3:0] ALU_operation = NONE;

    // Instance of the Computer
    Computer SRC(
        .Clock(Clock), .clear(clear),
        .PCin(PCin), .PCout(PCout), 	
        .IRin(IRin),
        .MARin(MARin), .MDRin(MDRin), .MDRout(MDRout), .Read(Read),
        .Rin(Rin), .Rout(Rout),
        .Yin(Yin), .Zin(Zin), .ZLowout(Zlowout), 
        .Cout(Cout),
        .ALU_operation(ALU_operation), 
        .Gra(Gra), .Grb(Grb),  .Grc(Grc), .Glr(Glr),
        .BAout(BAout)
    );

    initial begin
        Clock = 0;
        forever #10 Clock = ~Clock;
    end

    initial begin
        clear = 1;
        #25;
        clear = 0;
        // Load memory and pre-initialize registers R7 and R4 [cite: 72]
        $readmemh("andi_r7_r4.hex", SRC.memory.mem);
        SRC.DUT.R7.storage = 32'h00001234;
        SRC.DUT.R4.storage = 32'h000000f2;
    end

    always @(posedge Clock) begin
        case (Present_state)
            Default : Present_state = T0;
            T0 : Present_state = T1;
            T1 : Present_state = T2;
            T2 : Present_state = T3;
            T3 : Present_state = T4;
            T4 : Present_state = T5;
            T5 : Present_state = done;
        endcase
    end

    always @(negedge Clock) begin
        // Reset all control signals [cite: 78, 79, 80, 81]
        PCout <= 0; Zlowout <= 0; MDRout <= 0; Rout <= 0;
        MARin <= 0; Zin <= 0; PCin <= 0; MDRin <= 0;
        IRin <= 0; Yin <= 0; Read <= 0; Rin <= 0;
        ALU_operation <= NONE; Gra <= 0; Grb <= 0; Grc <= 0; Glr <= 0; Cout <= 0; BAout <= 0;

        case (Present_state)
            T0: begin PCout <= 1; MARin <= 1; ALU_operation <= IncPC; Zin <= 1; end
            T1: begin Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1; end           
            T2: begin MDRout <= 1; IRin <= 1; end                                  
            T3: begin Grb <= 1; Rout <= 1; Yin <= 1; end                           
            T4: begin Cout <= 1; ALU_operation <= AND; Zin <= 1; end                
            T5: begin Zlowout <= 1; Gra <= 1; Rin <= 1; end                        
        endcase
    end
endmodule