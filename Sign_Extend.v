module Sign_Extend(Instruction, Out);

	input [15:0] Instruction;
	output [15:0] Out;

	assign Out = {{7{Instruction[8]}}, Instruction[8:0]};
endmodule
