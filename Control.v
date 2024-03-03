// TODO: 3 bits for num of bits. one bit as sined or unsigned out

module Control(Instruction, RegWrite, ALUSrc, 
    MemWrite, MemtoReg, MemRead, Branch, Lbits, PCStore);

    input [3:0] Instruction;
    output RegWrite, MemWrite, MemtoReg, MemRead, Branch, ALUSrc, LxB, PCStore, Br; // General Controls

    // comp. inst. & lw,llb,lhb,pcs
    assign RegWrite = (~Instruction[3] | 
        (Instruction[3] & ~Instruction[2] & ~Instruction[1] & ~Instruction[0]) | 
        (Instruction[3] & ~Instruction[2] & Instruction[1] & ~Instruction[0]) |
        (Instruction[3] & ~Instruction[2] & Instruction[1] & Instruction[0]) | 
        (Instruction[3] & Instruction[2] & Instruction[1] & ~Instruction[0]));

    // sw
    assign MemWrite = (Instruction[3] & ~Instruction[2] & ~Instruction[1] & Instruction[0]);

    // lw
    assign MemRead = (Instruction[3] & ~Instruction[2] & ~Instruction[1] & ~Instruction[0]);

    // lw
    assign MemtoReg = (Instruction[3] & ~Instruction[2] & ~Instruction[1] & ~Instruction[0]);

    // B, Br
    assign Branch = (Instruction[3] & Instruction[2] & ~Instruction[1]);

    // SLL, SRA, ROR, LW, SW, LLB, LHB, B
    // some cases don't matter
    assign ALUSrc = ((~Instruction[3] & Instruction[2] & ~Instruction[1])|
        (~Instruction[3] & Instruction[2] & Instruction[1] & ~Instruction[0])|
        (Instruction[3]));

    assign LxB = (Instruction[3] & ~Instruction[2] & Instruction[1]);

    assign PCStore = (Instruction[3] & Instruction[2]);

    // Br
    assign Br = Instruction[0];


endmodule