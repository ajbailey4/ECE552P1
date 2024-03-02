module ALU (ALU_Out, Error, ALU_In1, ALU_In2, Opcode, N_Flag, Z_Flag, V_Flag);
    input [15:0] ALU_In1, ALU_In2;
    input [3:0] Opcode;
    output reg [15:0] ALU_Out;
    output reg Error;
    output N_Flag, Z_Flag, V_Flag;
    
    wire [15:0] sum;
    wire ovfl;

    wire [15:0] shift_output;
    
    addsub_4bit addsub(.Sum(sum), .Ovfl(ovfl), .A(ALU_In1), .B(ALU_In2), .sub(Opcode[0]));
    Shifter shift(.Shift_In(ALU_In1), .Shift_Val(ALU_In1), .Shift_Out(shift_output), .Mode(Opcode[0]));
    
    always_comb begin
        case (Opcode)
            4'b0000: begin //ADD
                ALU_Out = sum;
                Error = ovfl;
            end
            4'b0001: begin //SUB
                ALU_Out = sum;
                Error = ovfl;
            end
            4'b0010: begin //XOR
                ALU_Out = ALU_In1 ^ ALU_In2;
                Error = 0;
            end
            4'b0011: begin //RED
                ALU_Out =
                Error = 0;
            end
            4'b0100: begin //SLL
                ALU_Out = shift_output;
                Error = 0;
            end
            4'b0101: begin //SRA
                ALU_Out = shift_output;
                Error = 0;
            end
            4'b0110: begin //ROR

            end
            4'b0111: begin //PADDSB

            end
            4'b1000: begin //LW

            end
            4'b1001: begin //SW

            end
            4'b1010: begin //LLB

            end
            4'b1011: begin //LHB

            end
            4'b1100: begin //B

            end
            4'b1101: begin //BR

            end
            4'b1110: begin //PCS

            end
            4'b1111: begin //HLT

            end
            default: begin
                ALU_Out = 4'bxxxx;
                Error = 1;
            end
        endcase
    end
endmodule
