module BitCell(clk, rst, D, WriteEnable, ReadEnable1, ReadEnable2, Bitline1, Bitline2);
	input clk;
	input rst;
	input D;
	input WriteEnable;
	input ReadEnable1;
	input ReadEnable2;
	inout Bitline1;
	inout Bitline2;
	
	reg q;
	
	dff flipflop(.q(q), .d(D), .wen(WriteEnable), .clk(clk), .rst(rst));
	assign Bitline1 = ReadEnable1 ? 1'bz : q;
	assign Bitline2 = ReadEnable2 ? 1'bz : q;
	
endmodule

