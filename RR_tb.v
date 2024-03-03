module RightRot_tb();

reg [15:0] RR_In;
wire [15:0] RR_Out;
reg [3:0] RR_Amt;
reg fail;

RightRot RR(.RR_In(RR_In), .RR_Out(RR_Out), .RR_Amt(RR_Amt));

    initial begin
        $monitor("Rotate Amt: %d | Rotate Input: %b | Rotate Output: %b", RR_Amt, RR_In, RR_Out);

        fail = 0; 

        RR_Amt = 0;
        RR_In = 16'b1110110000100001;
        #10;

        if(RR_Out != 16'b1110110000100001) begin
            $display("Test 0 Failed :(");
            fail = 1;
        end

        RR_Amt = 4;
        RR_In = 16'b1001111100001010;
        #10;

        if(RR_Out != 16'b1010100111110000) begin
            $display("Test 1 Failed :(");
            fail = 1;
        end

        RR_Amt = 7;
        RR_In = 16'b1100001011100101;
        #10;

        if(RR_Out != 16'b1100101110000101) begin 
            $display("Test 2 Failed :(");
            fail = 1;
        end

        RR_Amt = 15;
        RR_In = 16'b1111000011110000;
        #10;

        if(RR_Out != 16'b1110000111100001) begin
            $display("Test 3 Failed :(");
            fail = 1;
        end

        #10;

        if(!fail) begin
            $display("All Tests Passed!");
        end

        $stop();
    end

endmodule