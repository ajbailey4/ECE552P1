module cla_16bit(
    input [7:0] a,
    input [7:0] b,
    input sub,
    output signed [7:0] sum,
    output cout
);
    wire [3:0] carry;
    wire signed [7:0] result; 

    cla_4bit cla1(.a(a[3:0]), .b(b[3:0]), .cin(sub), .sub(sub), .sum(result[3:0]), .cout(carry[0]));
    cla_4bit cla2(.a(a[7:4]), .b(b[7:4]), .cin(carry[0]), .sub(sub), .sum(result[7:4]), .cout(carry[1]));

    //assign sum = result;
    assign sum = (result[7]) ? ((~carry[1]) ? max_value : result):((carry[1]) ? min_value : result);
    
    assign cout = carry[1];

endmodule