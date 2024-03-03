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

    intial beign
        Instruction = 4'h0; // ADD
        #10; 
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ALUSrc) begin
            $display("Test Failed with ADD instruction");
        end

        Instruction = 4'h1; // SUB
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ALUSrc) begin
            $display("Test Failed with SUB instruction");
        end

        Instruction = 4'h2; // XOR
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ALUSrc) begin
            $display("Test Failed with XOR instruction");
        end

        Instruction = 4'h3; // RED
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ALUSrc) begin
            $display("Test Failed with RED instruction");
        end

        Instruction = 4'h4; // SLL
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with SLL instruction");
        end

        Instruction = 4'h5; // SRA
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with SRA instruction");
        end

        Instruction = 4'h6; // ROR
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with ROR instruction");
        end

        Instruction = 4'h7; // PADDSB
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ALUSrc) begin
            $display("Test Failed with PADDSB instruction");
        end

        Instruction = 4'h8; // LW
        #10;
        if(~RegWrite | MemWrite | ~MemtoReg | ~MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with LW instruction");
        end

        Instruction = 4'h9; // SW
        #10;
        if(RegWrite | ~MemWrite | MemtoReg | MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with SW instruction");
        end

        Instruction = 4'hA; // LLB
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with LLB instruction");
        end

        Instruction = 4'hB; // LHB
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch | ~ALUSrc) begin
            $display("Test Failed with LHB instruction");
        end

        Instruction = 4'hC; // B
        #10;
        if(RegWrite | MemWrite | MemtoReg | MemRead | ~Branch | ~ALUSrc) begin
            $display("Test Failed with B instruction");
        end

        Instruction = 4'hD; // BR
        #10;
        if(RegWrite | MemWrite | MemtoReg | MemRead | ~Branch) begin
            $display("Test Failed with BR instruction");
        end

        Instruction = 4'hE; // PCS
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch) begin
            $display("Test Failed with PCS instruction");
        end

        Instruction = 4'hF; // HLT
        #10;
        if(~RegWrite | MemWrite | MemtoReg | MemRead | Branch) begin
            $display("Test Failed with HLT instruction");
        end

    end

endmodule