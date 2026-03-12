module Select_encode(
    input wire Gra, Grb, Grc,
    input wire Rin, Rout,
    input wire Cout,
    input wire [31:0] IR_out,
    output wire [3:0] reg_select,
    output wire [31:0] C_sign_extended
);

wire [3:0] Ra = IR_out[26:23];
wire [3:0] Rb = IR_out[22:19];
wire [3:0] Rc = IR_out[18:15];

assign C_sign_extended = $signed(IR_out[18:0]);

assign reg_select = ({4{Gra}} & Ra) | ({4{Grb}} & Rb) | ({4{Grc}} & Rc);
endmodule