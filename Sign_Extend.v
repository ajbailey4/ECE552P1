module Sign_Extend(Instruction, Out);

	input [15:0] Instruction;
	output signed [15:0] Out;

	assign Out = {{16{Instruction[8]}}, Instruction[8:0]};
endmodule
