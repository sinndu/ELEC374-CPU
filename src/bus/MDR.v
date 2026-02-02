module MDR (
    input [31:0] BusMuxOut,
    input [31:0] Mdatain,
    input Read,       
    input clear, 
    input clock, 
    input MDRin,      
    output [31:0] MDRout
);

    wire [31:0] mux_out;

    
    assign mux_out = (Read ? Mdatain : BusMuxOut); 

    
    Register MDR_Reg (
        .clear(clear),
        .clock(clock),
        .enable(MDRin),
        .BusMuxOut(mux_out),  
        .BusMuxIn(MDRout)     
    );

endmodule