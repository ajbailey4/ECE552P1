module t_PC_Updater();
	reg clk, rst, branch, Z, N, V, AddrSrc, testFailed;
	reg [2:0] cond;
	reg [15:0] InAddrImm, InAddrReg;
	wire [15:0] OutAddr;

	PC_Updater DUT(.clk(clk), .rst(rst), .AddrSrc(AddrSrc), .InAddrImm(InAddrImm), .InAddrReg(InAddrReg), .branch(branch), .cond(cond), .Z(Z), .N(N), .V(V), .OutAddr(OutAddr), .PCSOut());

	initial begin
		clk = 0;
		rst = 1;
		branch = 0;
		testFailed = 0;
		AddrSrc = 1;
		
		@(posedge clk);
		#1;
		
		rst = 0;

		if (OutAddr != 16'd0) begin
			testFailed = 1;
			$display("OutAddr: (%b) didn't reset", OutAddr);
		end

		@(posedge clk);
		#1;

		if (OutAddr != 16'd2) begin
			testFailed = 1;
			$display("OutAddr: (%b) didn't increment", OutAddr);
		end

		// Not Equal (is 2, next 4)
		branch = 1;
		cond = 3'b000;
		Z = 1;
		InAddrImm = 16'd5;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd4) begin
			testFailed = 1;
			$display("000: Jumped or didn't increment (OutAddr: %b)", OutAddr);
		end

		// is 4, next 10
		Z = 0;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd10) begin
			testFailed = 1;
			$display("000: Didn't jump (OutAddr: %b)", OutAddr);
		end

		// Equal (is 10, next 12)
		Z = 0;
		cond = 3'b001;
		InAddrImm = 16'd10;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd12) begin
			testFailed = 1;
			$display("001: Jumped or didn't increment (OutAddr: %b)", OutAddr);
		end

		Z = 1; // (is 12, next 20)
		@(posedge clk);
		#1;

		if (OutAddr != 16'd20) begin
			testFailed = 1;
			$display("001: Didn't jump (OutAddr: %b)", OutAddr);
		end

		// Greater Than (is 20, next 22)
		Z = 1;
		N = 1;
		cond = 3'b010;
		InAddrImm = 16'd15;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd22) begin
			testFailed = 1;
			$display("010: Jumped or didn't increment (OutAddr: %b)", OutAddr);
		end

		// is 22, next 30
		Z = 0;
		N = 0;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd30) begin
			testFailed = 1;
			$display("010: Didn't jump (OutAddr: %b)", OutAddr);
		end

		// Less Than
		N = 0;
		cond = 3'b011;
		InAddrImm = 16'd20;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd32) begin
			testFailed = 1;
			$display("011: Jumped or didn't increment (OutAddr: %b)", OutAddr);
		end

		N = 1;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd40) begin
			testFailed = 1;
			$display("011: Didn't jump (OutAddr: %b)", OutAddr);
		end

		// Greater Than or Equal
		Z = 0;
		N = 1;
		cond = 3'b100;
		InAddrImm = 16'd25;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd42) begin
			testFailed = 1;
			$display("100: Jumped or didn't increment (OutAddr: %b)", OutAddr);
		end

		Z = 0;
		N = 0;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd50) begin
			testFailed = 1;
			$display("100: Didn't jump (OutAddr: %b)", OutAddr);
		end

		Z = 1;
		InAddrImm = 16'd30;
		@(posedge clk);
		#1;
		#1;

		if (OutAddr != 16'd60) begin
			testFailed = 1;
			$display("100: Didn't jump (OutAddr: %b)", OutAddr);
		end

		// Less Than or Equal
		Z = 0;
		N = 0;
		cond = 3'b101;
		InAddrImm = 16'd35;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd62) begin
			testFailed = 1;
			$display("101: Jumped or didn't increment (OutAddr: %b)", OutAddr);
		end

		Z = 1;
		N = 0;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd70) begin
			testFailed = 1;
			$display("101: Didn't jump (OutAddr: %b)", OutAddr);
		end

		N = 1;
		Z = 0;
		InAddrImm = 16'd40;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd80) begin
			testFailed = 1;
			$display("101: Didn't jump (OutAddr: %b)", OutAddr);
		end

		// Overflow
		Z = 0;
		N = 0;
		V = 0;
		cond = 3'b110;
		InAddrImm = 16'd45;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd82) begin
			testFailed = 1;
			$display("110: Jumped or didn't increment (OutAddr: %b)", OutAddr);
		end

		V = 1;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd90) begin
			testFailed = 1;
			$display("110: Didn't jump (OutAddr: %b)", OutAddr);
		end

		// Unconditional
		Z = 1'bx;
		N = 1'bx;
		V = 1'bx;
		cond = 3'b111;
		InAddrImm = 16'd50;
		@(posedge clk);
		#1;

		if (OutAddr != 16'd100) begin
			testFailed = 1;
			$display("111: Didn't jump (OutAddr: %b)", OutAddr);
		end

		if (testFailed == 0) begin
			$display("All tests passed");
		end

	$stop;
	end

	always
		#5 clk = ~clk;
endmodule
