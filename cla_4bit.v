module cla_4bit(
    input [3:0] a,
    input [3:0] b,
    input cin,
    input sub,
    output [3:0] sum,
    output cout
);
    wire [3:0] g, p, b_xor_sub;
    wire [4:0] c;

    wire signed [3:0] result; 
    wire signed [3:0] max_value = 4'b0111; //+7
    wire signed [3:0] min_value = 4'b1000; //-8 (in two's complement)

    assign b_xor_sub = b ^ {4{sub}};

    assign g = a & b_xor_sub;
    assign p = a ^ b_xor_sub;

    assign c[0] = cin | sub;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & c[1]);
    assign c[3] = g[2] | (p[2] & c[2]);
    assign c[4] = g[3] | (p[3] & c[3]);

    assign result = (p ^ c[3:0]);
    assign sum = (result > max_value) ? max_value : ((result < min_value) ? min_value : result);
    //assign sum = p ^ c[3:0];

    assign cout = c[4];
endmodule
