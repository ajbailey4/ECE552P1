module cla_16bit(
    input [7:0] a,
    input [7:0] b,
    input sub,
    output signed [7:0] sum,
    output cout
);
    wire [3:0] carry;
    wire signed [7:0] result; 
    wire signed [7:0] max_value = 8'h7F; 
    wire signed [7:0] min_value = 8'h80;

    cla_4bit cla1(.a(a[3:0]), .b(b[3:0]), .cin(sub), .sub(sub), .sum(result[3:0]), .cout(carry[0]));
    cla_4bit cla2(.a(a[7:4]), .b(b[7:4]), .cin(carry[0]), .sub(sub), .sum(result[7:4]), .cout(carry[1]));

    //assign sum = result;
    assign sum = (~result[7] & |result[6:0]) ? 8'h7F :
        (result[7] & ~&result[6:0]) ? 8'h80 :
        result[7:0];

    assign cout = carry[1];
endmodule