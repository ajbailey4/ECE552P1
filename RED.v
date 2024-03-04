module RED(
    input [15:0] A,
    input [15:0] B,
    output [15:0] Out
);

wire [8:0] upper, lower;
wire [11:0] upper_ext, lower_ext;
wire [12:0] final_out;
wire u0_cout, l0_cout, f0_cout, f1_cout;

// upper
cla_4bit cla_u0(.a(A[11:8]), .b(B[11:8]), .cin(1'b0), .sub(1'b0), .sat(1'b0), .sum(upper[3:0]), .cout(u0_cout));
cla_4bit cla_u1(.a(A[15:12]), .b(B[15:12]), .cin(u0_cout), .sub(1'b0), .sat(1'b0), .sum(upper[7:4]), .cout(upper[8]));

// lower
cla_4bit cla_l0(.a(A[3:0]), .b(B[3:0]), .cin(1'b0), .sub(1'b0), .sat(1'b0), .sum(lower[3:0]), .cout(l0_cout));
cla_4bit cla_l1(.a(A[7:4]), .b(B[7:4]), .cin(l0_cout), .sub(1'b0), .sat(1'b0), .sum(lower[7:4]), .cout(lower[8]));

// sign extension
assign upper_ext = {{3{upper[8]}}, upper};
assign lower_ext = {{3{lower[8]}}, lower};

// final
cla_4bit cla_f0(.a(upper_ext[3:0]), .b(lower_ext[3:0]), .cin(1'b0), .sub(1'b0), .sat(1'b0), .sum(final_out[3:0]), .cout(f0_cout));
cla_4bit cla_f1(.a(upper_ext[7:4]), .b(lower_ext[7:4]), .cin(1'b0), .sub(1'b0), .sat(1'b0), .sum(final_out[7:4]), .cout(f1_cout));
cla_4bit cla_f2(.a(upper_ext[11:8]), .b(lower_ext[11:8]), .cin(1'b0), .sub(1'b0), .sat(1'b0), .sum(final_out[11:8]), .cout(final_out[12]));

assign Out = {{3{final_out[12]}}, final_out};

endmodule