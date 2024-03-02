module Shifter (Shift_Out, Shift_In, Shift_Val, Mode);
	input[15:0] Shift_In;
	input[3:0] Shift_Val;
	input Mode; // 0=SLL, 1=SRA
	output[15:0] Shift_Out;
	
	// 8 bit shift
	wire [15:0] bit3R1 = (Shift_Val[3] & Mode) ? Shift_In >> 8 : Shift_In;
	wire [15:0] bit3R2 = (Shift_Val[3] & Mode) ? {{8{bit3R1[7]}}, bit3R1[7:0]} : bit3R1;
	wire [15:0] bit3L = (Shift_Val[3] & ~Mode) ? bit3R2 << 8 : bit3R2;

	// 4 bit shift
	wire [15:0] bit2R1 = (Shift_Val[2] & Mode) ? bit3L >> 4 : bit3L;
	wire [15:0] bit2R2 = (Shift_Val[2] & Mode) ? {{4{bit2R1[11]}}, bit2R1[11:0]} : bit2R1;
	wire [15:0] bit2L = (Shift_Val[2] & ~Mode) ? bit2R2 << 4 : bit2R2;

	// 2 bit shift
	wire [15:0] bit1R1  = (Shift_Val[1] & Mode) ? bit2L >> 2 : bit2L;
	wire [15:0] bit1R2 = (Shift_Val[1] & Mode) ? {{2{bit1R1[13]}}, bit1R1[13:0]} : bit1R1;
	wire [15:0] bit1L  = (Shift_Val[1] & ~Mode) ? bit1R2 << 2 : bit1R2;

	// 1 bit shift
	wire [15:0] bit0R1  = (Shift_Val[0] & Mode) ? bit1L >> 1 : bit1L;
	wire [15:0] bit0R2 = (Shift_Val[0] & Mode) ? {bit0R1[14], bit0R1[14:0]} : bit0R1;
	assign Shift_Out  = (Shift_Val[0] & ~Mode) ? bit0R2 << 1 : bit0R2;

endmodule


