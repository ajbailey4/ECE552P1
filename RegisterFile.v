module RegisterFile(clk, rst, SrcReg1,  SrcReg2, DstReg, WriteReg, DstData, SrcData1, SrcData2);
	input clk;
	input rst;
	input [3:0] SrcReg1;
	input [3:0] SrcReg2;
	input [3:0] DstReg;
	input WriteReg;
	input [15:0] DstData;
	inout [15:0] SrcData1;
	inout [15:0] SrcData2;
	
	wire [15:0] rdecoded1, rdecoded2, wdecoded, rout1, rout2;
	
	ReadDecoder_4_16 rdecoder1(.RegId(SrcReg1), .Wordline(rdecoded1));
	ReadDecoder_4_16 rdecoder2(.RegId(SrcReg2), .Wordline(rdecoded2));
		
	WriteDecoder_4_16 wdecoder(.RegId(DstReg), .WriteReg(WriteReg), .Wordline(wdecoded));

	Register registers[15:0] (.clk(clk), .rst(rst), .D(DstData), .WriteReg(wdecoded),
		.ReadEnable1(rdecoded1), .ReadEnable2(rdecoded2), .Bitline1(SrcData1), .Bitline2(SrcData2));
		
	//assign SrcData1 = (WriteReg & (SrcReg1 == DstReg)) ? DstData : rout1;
	//assign SrcData2 = (WriteReg & (SrcReg2 == DstReg)) ? DstData : rout2;
endmodule
