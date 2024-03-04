module t_RED.v();

	reg [15:0] A, B;
	wire [15:0] Out

	RED DUT(.A(A), .B(B), .Out(Out));

	initial begin
		A = 16'h1122;
		B = 16'h3344;

		if (Out != 16'hFFAA) begin
			$display("test failed: Output was %h, should be %h", Out);
		end else begin
			$display("test passed!");
		end

		$stop;
	end
endmodule
