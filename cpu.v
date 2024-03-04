module cpu(clk, rst_n, hlt, pc);
	
	input clk, rst_n;
	output hlt;
	output [15:0] pc;

	wire [15:0] pcAddr, PCSOut, instr, wb, dstData, srcData1, srcData2, signExtOut, ALU_In2, ALU_Out, memOut;
	wire [3:0] srcReg1;
	wire RegWrite, ALUSrc, MemWrite, MemtoReg, MemRead, Branch, PCStore, LxB, Br, N, Z, V, hlt, enable;
	
	PC_Updater PCU(.clk(clk), .rst(~rst_n), .AddrSrc(Br), .InAddrReg(srcData2), .InAddrImm(signExtOut), .branch(Branch), .cond(instr[11:9]), .Z(Z), .N(N), .V(V), .hlt(hlt), .OutAddr(pcAddr), .PCSOut(PCSOut));
	
	memory_instr instrMem(.data_out(instr), .data_in(), .addr(pcAddr), .enable(1'b1), .wr(1'b0), .clk(clk), .rst(~rst_n));

	assign srcReg1 = LxB ? instr[11:8] : instr[7:4];
	assign dstData = PCStore ? PCSOut : wb;
	RegisterFile registerFile(.clk(clk), .rst(~rst_n), .SrcReg1(srcReg1), .SrcReg2(instr[3:0]), .DstReg(instr[11:8]), .WriteReg(RegWrite), .DstData(dstData), .SrcData1(srcData1), .SrcData2(srcData2));

	Control control(.Instruction(instr[15:12]), .RegWrite(RegWrite), .ALUSrc(ALUSrc), .MemWrite(MemWrite), .MemtoReg(MemtoReg), .MemRead(MemRead), .Branch(Branch), .PCStore(PCStore), .LxB(LxB), .Br(Br), .hlt(hlt));

	Sign_Extend signExtend(.Instruction(instr), .Out(signExtOut));

	assign ALU_In2 = ALUSrc ? signExtOut : srcData2;
	ALU alu(.clk(clk), .rst(~rst_n), .ALU_Out(ALU_Out), .ALU_In1(srcData1), .ALU_In2(ALU_In2), .Opcode(instr[15:12]), .N_Flag(N), .Z_Flag(Z), .V_Flag(V));

	assign enable = MemRead | MemWrite;
	memory1c mem(.data_out(memOut), .data_in(srcData2), .addr(ALU_Out), .enable(enable), .wr(MemWrite), .clk(clk), .rst(~rst_n));
	assign wb = MemtoReg ? memOut : ALU_Out;

endmodule
