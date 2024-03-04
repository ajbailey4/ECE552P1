module Mem_Instr(
    input [3:0] baseReg, 
    input signed [3:0] offset,
    output [15:0] addr_out
);

    wire [15:0] regHold = baseReg & 16'hFFFE;
    wire [15:0] signExtended = ({{12{offset[3]}}, offset} << 1);
    
    cla_16bit cla(
        .a(regHold), 
        .b(signExtended), 
        .sub(1'b0), 
        .sum(addr_out), 
        .cout(), 
        .N(),
        .Z(),
        .V()
    );

endmodule