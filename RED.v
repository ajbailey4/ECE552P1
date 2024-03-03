module RED(
    input [15:0] regT,
    input [15:0] regS,
    output [15:0] regD
);

wire [7:0] upper, lower;

cla_8bit cla1(.a(regT[15:8]), .b(regS[15:8]), .sub(0), .sum(upper), .cout());
cla_8bit cla2(.a(regT[7:0]), .b(regS[7:0]), .sub(0), .sum(lower), .cout());
cla_8bit cla3(.a(upper), .b(lower), .sub(0), .sum(regD), .cout());

endmodule