module WriteDecoder_4_16(RegId, WriteReg, Wordline);
	input [3:0] RegId;
	input WriteReg;
	output [15:0] Wordline;
	
	wire [15:0] shiftOut;
	
	Shifter shifter(.Shift_Out(shiftOut), .Shift_Val(RegId), .Shift_In(16'b1), .Mode(1'b0));
	assign Wordline = WriteReg ? shiftOut : 0;
endmodule

