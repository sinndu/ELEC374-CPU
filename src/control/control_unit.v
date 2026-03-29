module control_unit(
    input clock, reset,
    input stop,
    input CON_FF,
    input [31:0] IR,

    //control signals (in)
    output     HIin, LOin, CONin,
               PCin, IRin,
               Yin, Zin,
               MARin, MDRin, 
               OutPortin, InPortout,
               Read, Write,
               Cout, BAout,

    //control signals (out)
               PCout,
               MDRout, 
               ZHighout, ZLowout,
               HIout, LOout,

    //control signals (registers)
               Rin, Rout,
               Gra, Grb, Grc, Glr,

    output reg clear
);

parameter N_STATES  = 8;
//28 control signals (including Halt), plus 4-bit encoded ALU operation 
//set to 32 so that, in hex, the first 7 digits are enable inputs, and the last digit is the ALU_op 
parameter N_SIGNALS = 32; 
parameter N_INSTRS  = 28;

//register storing the signals that need to be on, for each instruction, for each clock cycle
reg [N_SIGNALS-1:0] ctrl_rom [0:N_INSTRS-1][0:N_STATES-1];

//one-hot control signal encoding for cleanliness
parameter s_HIin         = 32'h00000001,
          s_LOin         = 32'h00000002,
          s_CONin        = 32'h00000004,
          s_PCin         = 32'h00000008,
          s_IRin         = 32'h00000010,
          s_Yin          = 32'h00000020,
          s_Zin          = 32'h00000040,
          s_MARin        = 32'h00000080,
          s_MDRin        = 32'h00000100,
          s_OutPortin    = 32'h00000200,
          s_InPortout    = 32'h00000400,
          s_Read         = 32'h00000800,
          s_Write        = 32'h00001000,
          s_Cout         = 32'h00002000,
          s_BAout        = 32'h00004000,
          s_PCout        = 32'h00008000,
          s_MDRout       = 32'h00010000,
          s_ZHighout     = 32'h00020000,
          s_ZLowout      = 32'h00040000,
          s_HIout        = 32'h00080000,
          s_LOout        = 32'h00100000,
          s_Rin          = 32'h00200000,
          s_Rout         = 32'h00400000,
          s_Gra          = 32'h00800000,
          s_Grb          = 32'h01000000,
          s_Grc          = 32'h02000000,
          s_Glr          = 32'h04000000,
          s_Halt         = 32'h08000000;

//encoded ALU operations
parameter s_ADD = 32'b0 | (4'b0000 << 28), s_SUB = 32'b0   | (4'b0001 << 28), s_AND = 32'b0  | (4'b0010 << 28), 
          s_OR  = 32'b0 | (4'b0011 << 28), s_NEG = 32'b0   | (4'b0100 << 28), s_NOT = 32'b0  | (4'b0101 << 28), 
          s_SHR = 32'b0 | (4'b0110 << 28), s_SHRA = 32'b0  | (4'b0111 << 28), s_SHL = 32'b0  | (4'b1000 << 28), 
          s_ROR = 32'b0 | (4'b1001 << 28), s_ROL = 32'b0   | (4'b1010 << 28), s_MUL = 32'b0  | (4'b1011 << 28), 
          s_DIV = 32'b0 | (4'b1100 << 28), s_IncPC = 32'b0 | (4'b1101 << 28), s_NONE = 32'b0 | (4'b1110 << 28);

//list of states
parameter T0 = 4'h0, T1 = 4'h1, T2 = 4'h2, T3 = 4'h3, 
          T4 = 4'h4, T5 = 4'h5, T6 = 4'h6, T7 = 4'h7, 
          IDLE = 4'h8, RESET_STATE = 4'h9;

//list of instruction opcodes
parameter ADD = 5'b00000, SUB = 5'b00001, AND = 5'b00010, OR = 5'b00011, 
          SHR = 5'b00100, SHRA = 5'b00101, SHL = 5'b00110, ROR = 5'b00111, 
          ROL = 5'b01000, ADDI = 5'b01001, ANDI = 5'b01010, ORI = 5'b01011, 
          DIV = 5'b01100, MUL = 5'b01101, NEG = 5'b01110, NOT = 5'b01111, 
          LD = 5'b10000, LDI = 5'b10001, ST = 5'b10010, JAL = 5'b10011, 
          JR = 5'b10100, BR = 5'b10101, IN = 5'b10110, OUT = 5'b10111, 
          MFHI = 5'b11000, MFLO = 5'b11001, NOP = 5'b11010, HALT = 5'b11011;

//LUT for opcodes
//Each entry is the T_enable value for that opcode
reg [7:0] opcode_lut [0:27]; 

integer i;
initial begin
    //setting T_enable values
    opcode_lut[ADD]  = 8'b00011111;
    opcode_lut[SUB]  = 8'b00011111;
    opcode_lut[AND]  = 8'b00011111;
    opcode_lut[OR]   = 8'b00011111;
    opcode_lut[SHR]  = 8'b00011111;
    opcode_lut[SHRA] = 8'b00011111;
    opcode_lut[SHL]  = 8'b00011111;
    opcode_lut[ROR]  = 8'b00011111;
    opcode_lut[ROL]  = 8'b00011111;
    opcode_lut[ADDI] = 8'b00011111;
    opcode_lut[ANDI] = 8'b00011111;
    opcode_lut[ORI]  = 8'b00011111;
    opcode_lut[DIV]  = 8'b00111111;
    opcode_lut[MUL]  = 8'b00111111;
    opcode_lut[NEG]  = 8'b00001111;
    opcode_lut[NOT]  = 8'b00001111;
    opcode_lut[LD]   = 8'b01111111;
    opcode_lut[LDI]  = 8'b00011111;
    opcode_lut[ST]   = 8'b01111111;
    opcode_lut[JAL]  = 8'b00001111;
    opcode_lut[JR]   = 8'b00000111;
    opcode_lut[BR]   = 8'b00111111;
    opcode_lut[IN]   = 8'b00000111;
    opcode_lut[OUT]  = 8'b00000111;
    opcode_lut[MFHI] = 8'b00000111;
    opcode_lut[MFLO] = 8'b00000111;
    opcode_lut[NOP]  = 8'b00000011;
    opcode_lut[HALT] = 8'b00000111;

    //set T0-T2 for all instructions
    for (i = 0; i < N_INSTRS; i = i + 1) begin
        ctrl_rom[i][T0] = s_PCout   | s_MARin | s_IncPC | s_Zin;
        ctrl_rom[i][T1] = s_ZLowout | s_PCin  | s_Read  | s_MDRin;
        ctrl_rom[i][T2] = s_MDRout  | s_IRin;
        ctrl_rom[i][T3] = 0;
        ctrl_rom[i][T4] = 0;
        ctrl_rom[i][T5] = 0;
        ctrl_rom[i][T6] = 0;
        ctrl_rom[i][T7] = 0;
    end
    //go instruction by instruction now
    ctrl_rom[ADD][T3]   = s_Grb   | s_Rout | s_Yin;
    ctrl_rom[ADD][T4]   = s_Grc   | s_Rout | s_Zin | s_ADD;
    ctrl_rom[ADD][T5]   = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[SUB][T3]   = s_Grb   | s_Rout | s_Yin;
    ctrl_rom[SUB][T4]   = s_Grc   | s_Rout | s_Zin | s_SUB;
    ctrl_rom[SUB][T5]   = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[AND][T3]   = s_Grb   | s_Rout | s_Yin;
    ctrl_rom[AND][T4]   = s_Grc   | s_Rout | s_Zin | s_AND;
    ctrl_rom[AND][T5]   = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[OR][T3]    = s_Grb   | s_Rout | s_Yin;
    ctrl_rom[OR][T4]    = s_Grc   | s_Rout | s_Zin | s_OR;
    ctrl_rom[OR][T5]    = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[SHR][T3]   = s_Grb   | s_Rout | s_Yin;
    ctrl_rom[SHR][T4]   = s_Grc   | s_Rout | s_Zin | s_SHR;
    ctrl_rom[SHR][T5]   = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[SHRA][T3]  = s_Grb   | s_Rout | s_Yin;
    ctrl_rom[SHRA][T4]  = s_Grc   | s_Rout | s_Zin | s_SHRA;
    ctrl_rom[SHRA][T5]  = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[SHL][T3]   = s_Grb   | s_Rout | s_Yin;
    ctrl_rom[SHL][T4]   = s_Grc   | s_Rout | s_Zin | s_SHL;
    ctrl_rom[SHL][T5]   = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[ROR][T3]   = s_Grb   | s_Rout | s_Yin;
    ctrl_rom[ROR][T4]   = s_Grc   | s_Rout | s_Zin | s_ROR;
    ctrl_rom[ROR][T5]   = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[ROL][T3]   = s_Grb   | s_Rout | s_Yin;
    ctrl_rom[ROL][T4]   = s_Grc   | s_Rout | s_Zin | s_ROR;
    ctrl_rom[ROL][T5]   = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[ADDI][T3]  = s_Grb   | s_Rout | s_Yin;
    ctrl_rom[ADDI][T4]  = s_Cout  | s_Zin  | s_ADD;
    ctrl_rom[ADDI][T5]  = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[ANDI][T3]  = s_Grb   | s_Rout | s_Yin;
    ctrl_rom[ANDI][T4]  = s_Cout  | s_Zin  | s_AND;
    ctrl_rom[ANDI][T5]  = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[ORI][T3]   = s_Grb   | s_Rout | s_Yin;
    ctrl_rom[ORI][T4]   = s_Cout  | s_Zin  | s_OR;
    ctrl_rom[ORI][T5]   = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[DIV][T3]   = s_Gra   | s_Rout | s_Yin;
    ctrl_rom[DIV][T4]   = s_Grb   | s_Zin  | s_DIV;
    ctrl_rom[DIV][T5]   = s_LOin  | s_ZLowout;
    ctrl_rom[DIV][T6]   = s_HIin  | s_ZHighout;

    ctrl_rom[MUL][T3]   = s_Gra   | s_Rout | s_Yin;
    ctrl_rom[MUL][T4]   = s_Grb   | s_Zin  | s_MUL;
    ctrl_rom[MUL][T5]   = s_LOin  | s_ZLowout;
    ctrl_rom[MUL][T6]   = s_HIin  | s_ZHighout;

    ctrl_rom[NEG][T3]   = s_Grb   | s_Rout | s_Zin | s_NEG;
    ctrl_rom[NEG][T4]   = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[NOT][T3]   = s_Grb   | s_Rout | s_Zin | s_NOT;
    ctrl_rom[NOT][T4]   = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[LD][T3]    = s_Grb   | s_Rout | s_BAout | s_Yin;
    ctrl_rom[LD][T4]    = s_Cout  | s_Zin  | s_ADD;
    ctrl_rom[LD][T5]    = s_MARin | s_ZLowout;
    ctrl_rom[LD][T6]    = s_Read  | s_MDRin;
    ctrl_rom[LD][T7]    = s_Gra   | s_Rin  | s_MDRout;
    
    ctrl_rom[LDI][T3]   = s_Grb   | s_Rout | s_BAout | s_Yin;
    ctrl_rom[LDI][T4]   = s_Cout  | s_Zin  | s_ADD;
    ctrl_rom[LDI][T5]   = s_Gra   | s_Rin  | s_ZLowout;

    ctrl_rom[ST][T3]    = s_Grb   | s_Rout | s_BAout | s_Yin;
    ctrl_rom[ST][T4]    = s_Cout  | s_Zin  | s_ADD;
    ctrl_rom[ST][T5]    = s_MARin | s_ZLowout;
    ctrl_rom[ST][T6]    = s_Gra   | s_Rout | s_MDRin;
    ctrl_rom[ST][T7]    = s_Write | s_MDRout;

    ctrl_rom[JAL][T3]   = s_Glr   | s_Rin  | s_PCout;
    ctrl_rom[JAL][T4]   = s_Gra   | s_Rout | s_PCin;

    ctrl_rom[JR][T3]    = s_Gra   | s_Rout | s_PCin;

    ctrl_rom[BR][T3]    = s_Gra   | s_Rout | s_CONin;
    ctrl_rom[BR][T4]    = s_PCout | s_Yin;
    ctrl_rom[BR][T5]    = s_Cout  | s_Zin  | s_ADD;
    ctrl_rom[BR][T6]    = s_ZLowout; //PCin condition based on con_ff is handled at runtime

    ctrl_rom[IN][T3]    = s_Gra   | s_Rin  | s_InPortout;

    ctrl_rom[IN][T3]    = s_Gra   | s_Rout | s_OutPortin;

    ctrl_rom[MFHI][T3]  = s_Gra   | s_Rin  | s_HIout;

    ctrl_rom[MFLO][T3]  = s_Gra   | s_Rin  | s_LOout;

    ctrl_rom[MFLO][T3]  = s_Halt;

end

//IR opcode decoding
wire [4:0] instr_id = IR[31:27];
wire [7:0] T_enable = opcode_lut[instr_id];

//reg's for FSM and signal assertion
reg [N_SIGNALS-1:0] control_signals;
reg [3:0] current_state, next_state;

always @(*) begin
    control_signals = ctrl_rom[instr_id][current_state];
    
    //handling PCin for branch instruction now
    if (instr_id == BR && current_state == T6) begin
        control_signals[3] = CON_FF; //3 is the PCin bit
    end
end

wire run = ~(control_signals[27] | stop); //Halt NOR stop

always @ (negedge clock, posedge reset) begin
  if (reset) begin
    current_state <= RESET_STATE;
    clear <= 1;
  end
  else if (run) begin
    clear <= 0;
    current_state <= next_state;
  end
end

always @(*) begin
    case (current_state)
        RESET_STATE: next_state = T0;
        T7:          next_state = T0;
        default:
            //T_enable stores whether to transition FROM that state
            if (T_enable[current_state]) begin
                next_state = current_state + 1;
            end
            else begin
                next_state = T0;
            end
    endcase
end

assign HIin         = control_signals[0];
assign LOin         = control_signals[1];
assign CONin        = control_signals[2];
assign PCin         = control_signals[3];
assign IRin         = control_signals[4];
assign Yin          = control_signals[5];
assign Zin          = control_signals[6];
assign MARin        = control_signals[7];
assign MDRin        = control_signals[8];
assign OutPortin    = control_signals[9];
assign InPortout    = control_signals[10];
assign Read         = control_signals[11];
assign Write        = control_signals[12];
assign Cout         = control_signals[13];
assign BAout        = control_signals[14];
assign PCout        = control_signals[15];
assign MDRout       = control_signals[16];
assign ZHighout     = control_signals[17];
assign ZLowout      = control_signals[18];
assign HIout        = control_signals[19];
assign LOout        = control_signals[20];
assign Rin          = control_signals[21];
assign Rout         = control_signals[22];
assign Gra          = control_signals[23];
assign Grb          = control_signals[24];
assign Grc          = control_signals[25];
assign Glr          = control_signals[26];

endmodule