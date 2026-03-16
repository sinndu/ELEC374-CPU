module RAM(
    input wire clk, clear,
    input wire read, write,
    input wire [8:0] addr,
    input wire [31:0] data_in, 
    output wire [31:0] data_out
);
reg [31:0] mem [0:511];
reg [31:0] out_reg;

integer idx;
always@(posedge clk) begin
    if (clear) begin
        for (idx = 0; idx < 512; idx = idx + 1) begin
            mem[idx] <= 32'b0;
        end
		  out_reg <= 32'b0;
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