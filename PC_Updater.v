module PC_Updater(clk, rst, AddrSrc, InAddrReg, InAddrImm, branch, cond, Z, N, V, hlt, OutAddr, PCSOut);
	input clk, rst, branch, Z, N, V, AddrSrc, hlt; //AddrSrc: 0 = Imm, 1 = Reg
	input [2:0] cond;
	input [15:0] InAddrImm, InAddrReg;
	output [15:0] OutAddr, PCSOut;

	wire [15:0] pcOut, pcPlus2, shiftOut, pcBranchImm, newPc;
	reg isBranching;

	Register pc(.clk(clk), .rst(rst), .D(newPc), .WriteReg(1'b1), .ReadEnable1(1'b0), .ReadEnable2(), .Bitline1(pcOut), .Bitline2());
	
	cla_16bit plus2(.a(pcOut), .b(16'd2), .sub(1'b0), .sum(pcPlus2), .cout(), .N(), .Z(), .V());
	cla_16bit branchAdd(.a(pcPlus2), .b(shiftOut), .sub(1'b0), .sum(pcBranchImm), .cout(), .N(), .Z(), .V());

	Shifter ls1(.Shift_Out(shiftOut), .Shift_In(InAddrImm), .Shift_Val(4'd1), .Mode(1'b0));

	assign newPc = hlt ? pcOut : (isBranching ? (AddrSrc ? InAddrReg : pcBranchImm) : pcPlus2);
	assign OutAddr = pcOut;
	assign PCSOut = pcPlus2;

	always @* case(cond)
		3'b000: begin // Not Equal
			isBranching = ~Z ? branch : 1'b0;
		end

		3'b001: begin // Equal
			isBranching = Z ? branch : 1'b0;
		end

		3'b010: begin // Greater Than
			//isBranching = (~Z & ~N) ? branch : 1'b0;
			isBranching = (Z == 1'b0 && N == 1'b0) ? branch : 1'b0;
		end

		3'b011: begin // Less Than
			isBranching = N ? branch : 1'b0;
		end

		3'b100: begin // Greater Than or Equal
			isBranching = (Z | (~Z & ~N)) ? branch : 1'b0;
		end

		3'b101: begin // Less Than or Equal
			isBranching = (N | Z) ? branch : 1'b0;
		end

		3'b110: begin // Overflow
			isBranching = V ? branch : 1'b0;
		end

		3'b111: begin // Unconditional
			isBranching = branch;
		end
		
		// Should never happen
		default: begin
			isBranching = 1'b0;
		end
	endcase
endmodule

