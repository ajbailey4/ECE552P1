/*module Mem_Access(
    input Mode,
    input [3:0] rs,  
    input [3:0] rt,
    input signed [3:0] offset,
    input [15:0] write_data,
    output reg [15:0] read_data,
);

wire [15:0] addr = (rs & 16'hFFFE) + ({12{offset[3]}, offset} << 1);



endmodule*/
module Mem_Access(
    input clk,
    input rst,
    input mode,
    input [3:0] baseReg, 
    input [3:0] targetReg,
    input signed [3:0] offset,
    input enable,
    inout [15:0] data_bus
);

wire writeMem, writeReg, readMem;
wire [15:0] addr, data_out, data_in;
wire [15:0] baseAddr, targetData;


//assign addr = baseAddr + offset;

endmodule
