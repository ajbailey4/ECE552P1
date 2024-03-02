module mux_16b(A, B, Ctrl, Out);

	input [15:0] A, B;
	input Ctrl;
	output [15:0] Out;

	assign Out = Ctrl ? A : B;
endmodule
