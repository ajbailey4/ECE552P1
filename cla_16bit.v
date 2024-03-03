module cla_16bit(
    input [15:0] a,
    input [15:0] b,
    input sub,
    output signed [15:0] sum,
    output cout
);
    wire [3:0] carry;
    wire signed [15:0] result; 
    wire signed [15:0] max_value = 16'h7FFF; 
    wire signed [15:0] min_value = 16'h8000;

    cla_4bit cla1(.a(a[3:0]), .b(b[3:0]), .cin(sub), .sub(sub), .sum(result[3:0]), .cout(carry[0]));
    cla_4bit cla2(.a(a[7:4]), .b(b[7:4]), .cin(carry[0]), .sub(sub), .sum(result[7:4]), .cout(carry[1]));
    cla_4bit cla3(.a(a[11:8]), .b(b[11:8]), .cin(carry[1]), .sub(sub), .sum(result[11:8]), .cout(carry[2]));
    cla_4bit cla4(.a(a[15:12]), .b(b[15:12]), .cin(carry[2]), .sub(sub), .sum(result[15:12]), .cout(carry[3]));

    //assign sum = result;
    assign sum = (result > max_value) ? max_value : ((result < min_value) ? min_value : result);
    assign cout = carry[3];
endmodule