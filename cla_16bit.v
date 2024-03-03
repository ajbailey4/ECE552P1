module cla_16bit(
    input [15:0] a,
    input [15:0] b,
    input sub,
    output signed [15:0] sum,
    output cout,
    output OvrFlow
);
    wire [4:0] carry;
    wire [19:0] result; 

    // sign extend a 16 bit value to 20 bits
    wire [19:0] a_signext;
    wire [19:0] b_signext;

    assign a_signext = {{16{a[15]}}, a};
    assign b_signext = {{16{b[15]}}, b};

    cla_4bit cla1(.a(a_signext[3:0]), .b(b_signext[3:0]), .cin(sub), .sub(sub), .sum(result[3:0]), .cout(carry[0]));
    cla_4bit cla2(.a(a_signext[7:4]), .b(b_signext[7:4]), .cin(carry[0]), .sub(sub), .sum(result[7:4]), .cout(carry[1]));
    cla_4bit cla3(.a(a_signext[11:8]), .b(b_signext[11:8]), .cin(carry[1]), .sub(sub), .sum(result[11:8]), .cout(carry[2]));
    cla_4bit cla4(.a(a_signext[15:12]), .b(b_signext[15:12]), .cin(carry[2]), .sub(sub), .sum(result[15:12]), .cout(carry[3]));

    // carry[4] does not matter!
    cla_4bit satlogic(.a(a_signext[19:16]), .b(b_signext[19:16]), .cin(carry[3]), .sub(sub), .sum(result[19:16]), .cout(carry[4]));

    // saturation arithmatic
    assign sum = (result[19]) ? ((~&result[18:15]) ? 16'h8000:result[15:0]) : ((|result[18:15]) ? 16'h7FFF:result[15:0]);

    // overflow flag to alu
    assign OvrFlow = (result[19]) ? (~&result[18:15]) : (|result[18:15]);

    // carryout
    assign cout = carry[3];
    
endmodule