module full_adder_1bit(A, B, Cin, Sum, Cout);
    input A, B;
	input Cin;
    output Sum;
	output Cout;
	
	//Full Adder implementation
    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | ((A ^ B) & Cin); 
endmodule