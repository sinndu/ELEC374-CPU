module MDR (
    input [31:0] BusMuxOut,
    input [31:0] MDataIn,
    input read,       
    input clr, 
    input clk, 
    input MDR_in,      
    output [31:0] MDR_out
);

    wire [31:0] Mux_out;

    // multiplexer to select between memory data and internal bus data
    assign Mux_out = (read ? MDataIn : BusMuxOut); 

    // MDR register
    Register_32 MDR_Reg (
        .clk(clk),
        .clr(clr),
        .enable(MDR_in),
        .d(Mux_out),  
        .q(MDR_out)     
    );

endmodule