module RightRot(
    input [15:0] RR_In, 
    input [3:0] RR_Amt,
    output [15:0] RR_Out
);

wire [15:0] RR_1 = RR_Amt[0] ? {RR_In[0], RR_In[15:1]} : RR_In;
wire [15:0] RR_2 = RR_Amt[1] ? {RR_1[1:0], RR_1[15:2]} : RR_1;
wire [15:0] RR_3 = RR_Amt[2] ? {RR_2[3:0], RR_2[15:4]} : RR_2;
wire [15:0] RR_4 = RR_Amt[3] ? {RR_3[7:0], RR_3[15:8]} : RR_3;

assign RR_Out = RR_4;

endmodule