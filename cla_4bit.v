module cla_4bit(
    input [3:0] a,
    input [3:0] b,
    input cin,
    input sub,
    output signed [3:0] sum,
    output cout
);
    wire [3:0] g, p, b_xor_sub;
    wire [4:0] c;

    assign b_xor_sub = sub ? ~b : b;

    assign g = a & b_xor_sub;
    assign p = a ^ b_xor_sub;

    assign c[0] = cin | sub;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & c[1]);
    assign c[3] = g[2] | (p[2] & c[2]);
    assign c[4] = g[3] | (p[3] & c[3]);

    assign sum = p ^ c[3:0];

    assign cout = c[4];
endmodule
