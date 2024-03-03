module Control_tb();

    // Inputs
    reg [3:0] Instruction;

    // Outputs
    wire RegWrite, MemWrite, MemtoReg, MemRead, Branch, ALUSrc;

    // Instantiate the Control module
    Control uut (
        .Instruction(Instruction),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .MemRead(MemRead),
        .Branch(Branch),
        .ALUSrc(ALUSrc)
    );

    initial begin
        // Test Case 1: ADD
        Instruction = 4'h0;
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ALUSrc) begin
            $display("Test Failed with ADD instruction");
        end

        // Test Case 2: SUB
        Instruction = 4'h1;
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ALUSrc) begin
            $display("Test Failed with SUB instruction");
        end

        // Test Case 3: XOR
        Instruction = 4'h2;
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ALUSrc) begin
            $display("Test Failed with XOR instruction");
        end

        // Test Case 4: RED
        Instruction = 4'h3;
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ALUSrc) begin
            $display("Test Failed with RED instruction");
        end

        // Test Case 5: SLL
        Instruction = 4'h4;
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with SLL instruction");
        end

        // Test Case 6: SRA
        Instruction = 4'h5;
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with SRA instruction");
        end

        // Test Case 7: ROR
        Instruction = 4'h6;
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with ROR instruction");
        end

        // Test Case 8: PADDSB
        Instruction = 4'h7;
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ALUSrc) begin
            $display("Test Failed with PADDSB instruction");
        end

        // Test Case 9: LW
        Instruction = 4'h8;
        #10;
        if(~RegWrite | MemWrite | ~MemtoReg | ~MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with LW instruction");
        end

        // Test Case 10: SW
        Instruction = 4'h9;
        #10;
        if(RegWrite | ~MemWrite | MemtoReg | MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with SW instruction");
        end

        // Test Case 11: LLB
        Instruction = 4'hA;
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with LLB instruction");
        end

        // Test Case 12: LHB
        Instruction = 4'hB;
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with LHB instruction");
        end

        // Test Case 13: B
        Instruction = 4'hC;
        #10;
        if(RegWrite | MemWrite | MemtoReg | MemRead | ~Branch | ~ALUSrc) begin
            $display("Test Failed with B instruction");
        end

        // Test Case 14: BR
        Instruction = 4'hD;
        #10;
        if(RegWrite | MemWrite | MemtoReg | MemRead | ~Branch) begin
            $display("Test Failed with BR instruction");
        end

        // Test Case 15: PCS
        Instruction = 4'hE;
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch) begin
            $display("Test Failed with PCS instruction");
        end

        // Test Case 16: HLT
        Instruction = 4'hF;
        #10;
        if(RegWrite | MemWrite | MemtoReg | MemRead | Branch) begin
            $display("Test Failed with HLT instruction");
        end

        $display("Test Passed");

        $stop; // Finish simulation
    end
endmodule
