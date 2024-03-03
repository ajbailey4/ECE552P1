module PADDSB_tb();

    reg [15:0] reg1, reg2;
    wire [15:0] out;
    reg fail;

    PADDSB DUI(.regT(reg1), .regS(reg2), .regD(out));

    initial begin

        $monitor("Reg1: %b | Reg2: %b | Output: %b", reg1, reg2, out);
        reg1 = 0;
        reg2 = 0;
        fail = 0;

        #10;

        reg1 = 16'h1234;
        reg2 = 16'h1111;

        #10;

        if(out != 16'h2345) begin
            $display("Test 1 Failed");
            fail = 1;
        end

        #10;

        reg1 = 16'h7FFF;
        reg2 = 16'h1000;

        #10;

        if(out != 16'h8FFF) begin
            $display("Test 2 Failed");
            fail = 1;
        end

        #10;

        reg1 = 16'h444F;
        reg2 = 16'h1111;

        #10;

        if(out != 16'h555F) begin
            $display("Test 3 Failed");
            fail = 1;
        end

        #10;

        if(!fail) begin
            $display("All Tests Passed!");
        end

    end


endmodule