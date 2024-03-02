module PC_Updater(clk, rst, InAddr, cond, Z, N, V, OutAddr);
	input clk, rst, Z, N, V;
	input [2:0] cond;
	input [15:0] InAddr;
	output [15:0] OutAddr;

	wire [15:0] pcOut, pcPlus2, shiftOut, branchAddr, newAddr;
	wire branch;

	Register pc(.clk(clk), .rst(rst), D(newAddr), WriteReg(1'b1), ReadEnable1(1'b1), ReadEnable2(), Bitline1(pc_out), Bitline2());
	
	CLA_16bit plus2(.A(pcOut), .B(16'd2), .Out(pcPlus2));
	CLA_16bit branchAdd(.A(pcPlus2), .B(shiftOut), .Out(branchAddr));

	Shifter ls1(.Shift_Out(shiftOut), .Shift_In(InAddr), .Shift_Val(4'd1), .Mode(1'b0));

	assign newAddr = branch ? newAddr : pcPlus2;
	assign OutAddr = pc_out;

	always_comb begin
		case(cond) begin
		3'b000: begin // Not Equal
			branch = ~Z ? 1'b1 : 1'b0;
		end

		3'b001: begin // Equal
			branch = Z ? 1'b1 : 1'b0;
		end

		3'b010: begin // Greater Than
			branch = (~Z & ~N) ? 1'b1 : 1'b0;
		end

		3'b011: begin // Less Than
			branch = N ? 1'b1 : 1'b0;
		end

		3'b100: begin // Greater Than or Equal
			branch = (Z | (~Z & ~N) ? 1'b1 : 1'b0;
		end

		3'b101: begin // Less Than or Equal
			branch = (N | Z) ? 1'b1 : 1'b0;
		end

		3'b110: begin // Overflow
			branch = V ? 1'b1 : 1'b0;
		end

		3'111: begin // Unconditional
			branch = 1'b1;
		end
		
		// Should never happen
		default: branch = 1'b0;
	end
endmodule

