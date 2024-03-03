module t_PC_Updater();
	reg clk, rst, branch, Z, N, V;
	reg [2:0] cond;
	reg [15:0] InAddr;
	wire [15:0] OutAddr;

	PC_Updater DUT(.clk(clk), .rst(rst), .InAddr(InAddr), .branch(branch), .cond(cond), .Z(Z), .N(N), .V(V), .OutAddr(OutAddr));

	initial begin
		clk = 0;
		rst = 1;
		branch = 0;
		
		@(posedge clk);
		@(posedge clk);
		
		rst = 0;
		
		@(posedge clk);
		
		if (OutAddr != 16'd0) begin
			$display("OutAddr: (%b) didn't reset", OutAddr);
		end

		@(posedge clk);
		if (OutAddr != 16'd2) begin
			$display("OutAddr: (%b) didn't increment", OutAddr);
		end

		branch = 1;
		cond = 3'b000;
		Z = 0;

		3'b000: begin // Not Equal
			isBranching = ~Z ? branch : 1'b0;
		end

		3'b001: begin // Equal
			isBranching = Z ? branch : 1'b0;
		end

		3'b010: begin // Greater Than
			isBranching = (~Z & ~N) ? branch : 1'b0;
		end

		3'b011: begin // Less Than
			isBranching = N ? branch : 1'b0;
		end

		3'b100: begin // Greater Than or Equal
			isBranching = (Z | (~Z & ~N) ? branch : 1'b0;
		end

		3'b101: begin // Less Than or Equal
			isBranching = (N | Z) ? branch : 1'b0;
		end

		3'b110: begin // Overflow
			isBranching = V ? branch : 1'b0;
		end

		3'111: begin // Unconditional
			isBranching = branch;
		end*/
		

		@(posedge clk);
	$stop
	end

	always
		#5 clk = ~clk;
endmodule
