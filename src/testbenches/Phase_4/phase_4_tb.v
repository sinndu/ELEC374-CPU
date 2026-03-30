`timescale 1ns/10ps
module phase_4_tb;
    reg clock, reset;
    reg stop;
    reg [31:0] in_inport_data;
    wire [7:0] seven_seg_ones;
    wire [7:0] seven_seg_tens;
    wire tb_stop;

    // Instance of the Computer
    Computer SRC(
        .clock(clock), .reset(reset),
        .stop(stop),

        .in_port_data(in_inport_data),
        .seven_seg_ones(seven_seg_ones),
        .seven_seg_tens(seven_seg_tens),
        .tb_stop(tb_stop)
    );

    initial begin
        clock = 0;
        forever #10 clock = ~clock;
    end

    initial begin
        stop = 0;
        in_inport_data = 32'h000000E0; //CHANGE THIS SIGNAL TO BE ASSERTED BY THE SWITCHES!!
        reset = 1;
        #15;
        reset = 0;
        #5; //wait for clear signal to fall before initializing memory
        $readmemh("Phase_4.hex", SRC.memory.mem);
    end

    always@(*) begin
        if (tb_stop) begin
            $stop;
        end
    end
endmodule