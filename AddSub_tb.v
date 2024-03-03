module addsub_16bit_tb();
reg [15:0] A, B;
reg sub;
wire [15:0] Sum;
wire cin;
wire cout;

cla_16bit DUT(.a(A), .b(B), .sum(Sum), .cout(Cout), .sub(sub));
	initial begin
		$monitor("A=%b, B=%b | Sub=%b | Sum=%b", A, B, sub, Sum);
		sub = 0; //Test addition
		A = ($unsigned($random) % 65536) - 32768; //Generate a random number between 0 and 15
		B = ($unsigned($random) % 65536) - 32768;
		#10; //Wait for 10 time units
		
		//Check to see if add matches sum and if not if it is due to overflow
		if((A + B) != Sum && Sum != 32767) begin
			$display("Sum didn't match | Sum: %d | Real: %d", Sum, (A+B));
			if((A + B) <= 32767) begin
				$display("Test Failed: no overflow and no match");
				$stop;
			end
		end
		
		sub = 1; //Test subtraction
		A = ($unsigned($random) % 65536) - 32768; //Generate a random number between 0 and 15
		B = ($unsigned($random) % 65536) - 32768;
		#10;
		
		//Check to see if sub matches sum and if not if it is due to overflow
		if((A - B) != Sum && Sum != -32768) begin
			$display("Sub didn't match | Sub: %d | Real: %d", Sum, (A-B));
			if((A - B) >= -32768) begin
				$display("Test Failed: no overflow and no match");
				$stop;
			end
		end
		
		$display("Sum and Sub Tests Passed!");
		$stop;
	end
endmodule
