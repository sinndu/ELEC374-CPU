module RAM(
    input wire clk, clear,
    input wire read, write,
    input wire [8:0] addr,
    input wire [31:0] data_in, 
    output wire [31:0] data_out
);
reg [31:0] mem [0:511];
reg [31:0] out_reg;


always@(posedge clk) begin
    if (clear) begin
		  integer i;
        for (i = 0; i < 512; i = i + 1) begin
            mem[i] <= 32'b0;
        end
    end
    else if (read) begin
        out_reg <= mem[addr];
    end
    else if (write) begin
        mem[addr] <= data_in;
    end 
end

assign data_out = out_reg;

endmodule