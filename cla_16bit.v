module cla_16bit(
    input [15:0] a,
    input [15:0] b,
    input sub,
    output signed [15:0] sum,
    output cout,
    output N,
    output Z,
    output V
);

    wire [15:0] g, p, b_xor_sub;
    wire [16:0] c;

    wire [15:0] result; 

    assign b_xor_sub = sub ? ~b : b;

    assign g = a & b_xor_sub;
    assign p = a ^ b_xor_sub;

    assign c[0] = sub;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & c[1]);
    assign c[3] = g[2] | (p[2] & c[2]);
    assign c[4] = g[3] | (p[3] & c[3]);
    assign c[5] = g[4] | (p[4] & c[4]);
    assign c[6] = g[5] | (p[5] & c[5]);
    assign c[7] = g[6] | (p[6] & c[6]);
    assign c[8] = g[7] | (p[7] & c[7]);
    assign c[9] = g[8] | (p[8] & c[8]);
    assign c[10] = g[9] | (p[9] & c[9]);
    assign c[11] = g[10] | (p[10] & c[10]);
    assign c[12] = g[11] | (p[11] & c[11]);
    assign c[13] = g[12] | (p[12] & c[12]);
    assign c[14] = g[13] | (p[13] & c[13]);
    assign c[15] = g[14] | (p[14] & c[14]);
    assign c[16] = g[15] | (p[15] & c[15]);

    assign result = p ^ c[15:0];

    assign cout = c[16];

    // saturation arithmatic
    assign sum = result[15] ? ((~a[15] & ~b[15]) ? 16'h7FFF : result)
        : ((a[15] & b[15]) ? 16'h8000 : result);

    // overflow flag to alu
    assign V = result[15] ? ((~a[15] & ~b[15]) ? 1'b1 : 1'b0)
        : ((a[15] & b[15]) ? 1'b1 : 1'b0);

    // Negative flag set
    assign N = sum[15] ? 1'b1 : 1'b0;

    // Zero Flag
    assign Z = (sum == 0);

    // carryout
    assign cout = c[16];
endmodule
