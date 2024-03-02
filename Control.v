// TODO: 3 bits for num of bits. one bit as sined or unsigned out

module Control(Instruction, RegWrite, ALUSrc, 
    MemWrite, MemtoReg, MemRead, Branch);

    input [3:0] Instruction;
    output RegWrite, MemWrite, MemtoReg, MemRead, Branch, ALUSrc; // General Controls
    output [3:0] Opcode;

    assign Opcode = Instruction;
    
    // Needed revision
    // comp. inst. & lw,
    assign RegWrite = (~Instruction[3] | (Instruction[3] & ~Instruction[0]));

    // sw
    assign MemWrite = (Instruction[3] & ~Instruction[2] & ~Instruction[1] & Instruction[0]);

    // lw
    assign MemRead = (Instruction[3] & ~Instruction[2] & ~Instruction[1] & ~Instruction[0]);

    // lw
    assign MemtoReg = (Instruction[3] & ~Instruction[2] & ~Instruction[1] & ~Instruction[0]);

    // B
    assign Branch = (Instruction[3] & Instruction[2] & ~Instruction[1]);

    assign ALUSrc = ();

endmodule