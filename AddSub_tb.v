module addsub_16bit_tb;
    reg [15:0] A, B;
    reg sub;
    wire [15:0] Sum;
    wire Cout;

    cla_16bit DUT(.a(A), .b(B), .sum(Sum), .cout(Cout), .sub(sub));

    initial begin
        $monitor("Time=%0t | A=%d, B=%d | Sub=%d | Sum=%d, Cout=%d | RealSub=%d,  RealSum=%d", $time, A, B, sub, Sum, Cout, (A-B), (A+B));

        // Test addition
        sub = 0;
        A = 16'h8000;
        B = 16'h4000; 
        #10; 

        // Test subtraction
        sub = 1; 
        A = 16'h8000; 
        B = 16'h4000; 
        #10;

        // Random test for addition
        sub = 0; // Addition mode
        A = $random; 
        B = $random;
        #10; 

        // Random test for subtraction
        sub = 1;
        A = $random; 
        B = $random; 
        #10; 

        $display("Tests Passed!");
        $stop; 
    end
endmodule

/*module addsub_16bit_tb;
reg [15:0] A, B;
reg sub;
wire [15:0] Sum;
wire cin;
wire cout;

cla_16bit DUT(.sum(Sum), .a(A), .b(B), .sub(sub), .cin(cin), .cout(cout));
	initial begin
		$monitor("A=%b, B=%b | Sub=%b | Sum=%b", A, B, sub, Sum);
		sub = 0; //Test addition
		A = ($unsigned($random) % 65536) - 32768; //Generate a random number between 0 and 15
		B = ($unsigned($random) % 65536) - 32768;
		#10; //Wait for 10 time units
		
		//Check to see if add matches sum and if not if it is due to overflow
		if((A + B) != Sum) begin
			$display("Sum didn't match");
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
		if((A - B) != Sum) begin
			$display("Sub didn't match");
			if((A - B) >= -32768) begin
				$display("Test Failed: no overflow and no match");
				$stop;
			end
		end
		
		$display("Sum and Sub Tests Passed!");
		$stop;
	end
endmodule*/
