module Shifter (Shift_Out, Shift_In, Shift_Val, Mode);
	input[15:0] Shift_In;
	input[3:0] Shift_Val;
	input Mode; // 0=SLL, 1=SRA
	output[15:0] Shift_Out;
	
		wire [15:0] shift8 = Shift_In >> 8;

	wire [15:0] bit3 = Shift_Val[3] ? (Mode ? {{8{shift8[7]}}, shift8[7:0]} : (Shift_In << 8)) : Shift_In;

		wire [15:0] shift4 = bit3 >> 4;

	wire [15:0] bit2 = Shift_Val[2] ? (Mode ? {{4{shift4[11]}}, shift4[11:0]} : (bit3 << 4)) : bit3;

		wire [15:0] shift2 = bit2 >> 2;

	wire [15:0] bit1 = Shift_Val[1] ? (Mode ? {{2{shift2[13]}}, shift2[13:0]} : (bit2 << 2)) : bit2;

		wire [15:0] shift1 = bit1 >> 1;

	wire [15:0] bit0 = Shift_Val[0] ? (Mode ? {shift1[14], shift1[14:0]} : (bit1 << 1)) : bit1;

	assign Shift_Out = bit0;

endmodule