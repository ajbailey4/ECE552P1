module PADDSB(
    input [15:0] regT,
    input [15:0] regS,
    output [15:0] regD
);

wire [3:0] first, second, third, fourth;
wire ovfl1, ovfl2, ovfl3, ovfl4;

cla_4bit cla1(.a(regT[15:12]), .b(regS[15:12]), .sum(first), .cin(1'b0), .sub(1'b0), .cout(ovfl1), .sat(1'b1));
cla_4bit cla2(.a(regT[11:8]), .b(regS[11:8]), .sum(second), .cin(1'b0), .sub(1'b0), .cout(ovfl2), .sat(1'b1));
cla_4bit cla3(.a(regT[7:4]), .b(regS[7:4]), .sum(third), .cin(1'b0), .sub(1'b0), .cout(ovfl3), .sat(1'b1));
cla_4bit cla4(.a(regT[3:0]), .b(regS[3:0]), .sum(fourth), .cin(1'b0), .sub(1'b0), .cout(ovfl4), .sat(1'b1));

assign regD = {first, second, third, fourth};

endmodule