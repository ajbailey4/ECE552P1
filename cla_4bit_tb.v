module addsub_4bit_tb();
reg [3:0] A, B;
reg sub, sat, cin;
wire [3:0] Sum;
wire cout;

cla_4bit DUT(.a(A), .b(B), .sum(Sum), .cout(cout), .sub(sub), .sat(sat), .cin(cin));
	initial begin
		$monitor("A=%d, B=%d | Sub=%d | Sum=%d", A, B, sub, Sum);
		cin = 0;
		sat = 1;

		sub = 0; //Test addition
		A = 4;
		B = 1;
		#10; //Wait for 10 time units
		
		//Check to see if add matches sum and if not if it is due to overflow
		if((A + B) != Sum && Sum != 5) begin
			$display("Sum didn't match | Sum: %d | Real: %d", Sum, (A+B));
			$stop;
		end
		
		sub = 1; //Test subtraction
		A = -2;
		B = 5;
		#10;
		
		//Check to see if sub matches sum and if not if it is due to overflow
		if((A - B) != Sum && Sum != -7) begin
			$display("Sub didn't match | Sub: %d | Real: %d", Sum, (A-B));
			$stop;
		end
		
		sub = 0; //Test positive sat
		A = 7; //Generate a random number between 0 and 15
		B = 1;
		#10;
		
		//Check to see if sub matches sum and if not if it is due to overflow
		if(Sum != 4'b0111) begin
			$display("case 2: Sub didn't match | Sub: %d | Real: %d", Sum, (A-B));
			$stop;
		end

		//test negative saturation
		sub = 0; 
		A = -6;
		B = -7;
		#10; //Wait for 10 time units
		
		//Check to see if add matches sum and if not if it is due to overflow
		if(Sum != 4'b1000) begin
			$display("Sum didn't match | Sum: %d | Real: %d", Sum, (A+B));
			$stop;
		end
		
		$display("Sum and Sub Tests Passed!");
		$stop;
	end
endmodule
