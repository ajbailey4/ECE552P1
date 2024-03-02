module cla_16bit(
    input [15:0] a,
    input [15:0] b,
    input sub,
    output [15:0] sum,
    output cout
);
    wire [3:0] carry;

    cla_4bit cla1(a[3:0], b[3:0], sub, sub, sum[3:0], carry[0]);
    cla_4bit cla2(a[7:4], b[7:4], carry[0], sub, sum[7:4], carry[1]);
    cla_4bit cla3(a[11:8], b[11:8], carry[1], sub, sum[11:8], carry[2]);
    cla_4bit cla4(a[15:12], b[15:12], carry[2], sub, sum[15:12], carry[3]);

    assign cout = carry[3];
endmodule