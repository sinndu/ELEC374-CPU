module RAM(
    input wire clk, clear,
    input wire read, write,
    input wire [8:0] addr,
    input wire [31:0] data_in, 
    output wire [31:0] data_out
);
reg [31:0] mem [0:511];


//synchronous clear/write logic, asynchronous read logic 
integer idx;
always@(posedge clk) begin
    if (clear) begin
//        for (idx = 0; idx < 512; idx = idx + 1) begin
//            mem[idx] <= 32'b0;
//        end
		  $readmemh("../testbenches/Phase_4/Phase_4.hex", mem);
    end
    else if (write) begin
        mem[addr] <= data_in;
    end 
end

//read logic must be asynchronous to meet timing requirements 
assign data_out = read ? mem[addr] : 32'bz;

endmodule