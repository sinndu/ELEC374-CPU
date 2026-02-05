module Register_32 #(parameter WIDTH = 32) (
	input wire clk,
	input wire clr,
	input wire enable,
	input wire [WIDTH - 1:0] d,
	output wire [WIDTH - 1:0] q
);

	reg [WIDTH - 1:0] storage;

	always @ (posedge clk) begin
		if (clr) begin
			storage <= {WIDTH{1'b0}};
		end
		else if (enable) begin
			storage <= d;
		end
	end
		
	assign q = storage;

endmodule