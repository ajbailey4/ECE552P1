module Sign_Extend(Instruction, SignExt, NineBits, Out);

	input [15:0] Instruction;
	input NineBits, SignExt; // If not 9, 4
	output [15:0] Out;

	wire [15:0] nine = (SignExt && NineBits) ? {7{Instruction[8]}, Instruction[8:0]} : Instruction;
	wire [15:0] four = (SignExt && ~NineBits) ? {12{Instruction[3]}, Instruction[3;0]} : nine;
	assign Out = ~SignExt ? {12'd0, Instruction[3:0]} : four;

endmodule
