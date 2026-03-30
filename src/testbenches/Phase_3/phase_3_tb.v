`timescale 1ns/10ps
module phase_3_tb;
    reg clock, reset;
    reg stop;
    reg [31:0] in_inport_data;
    wire [31:0] out_outport_data;
    wire tb_stop;

    // Instance of the Computer
    Computer SRC(
        .clock(clock), .reset(reset),
        .stop(stop),

        .in_port_data(in_inport_data),
        .tb_stop(tb_stop)
    );

    initial begin
        clock = 0;
        forever #10 clock = ~clock;
    end

    initial begin
        stop = 0;
        in_inport_data = 32'b0;
        reset = 1;
        #15;
        reset = 0;
        #5; //wait for clear signal to fall before initializing memory
        $readmemh("Phase_3.hex", SRC.memory.mem);
    end

    always@(*) begin
        if (tb_stop) begin
            $stop;
        end
    end
endmodule