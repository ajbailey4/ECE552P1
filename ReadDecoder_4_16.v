module ReadDecoder_4_16(RegId, Wordline);
	input [3:0] RegId;
	output [15:0] Wordline;
	
	wire [15:0] shiftOut;
	
	Shifter shifter(.Shift_Out(shiftOut), .Shift_Val(RegId), .Shift_In(16'b1));
	assign Wordline = ~shiftOut;
endmodule

