module ALU (clk, rst, ALU_Out, ALU_In1, ALU_In2, Opcode, N_Flag, Z_Flag, V_Flag);
    input [15:0] ALU_In1, ALU_In2;
    input [3:0] Opcode;
    input clk, rst;
    output reg [15:0] ALU_Out;
    output N_Flag, Z_Flag, V_Flag;
    
    wire [15:0] sum;
    wire ovfl;

    wire [15:0] shift_output;
    wire N_In, Z_In, V_In, Z_Out;
    reg Z;
    reg [2:0] NZV_wen;

    wire [15:0] RR_output;

    wire [15:0] Mem_output;

    wire [15:0] pas_output;

    cla_16bit cla(.a(ALU_In1), .b(ALU_In2), .sub(Opcode[0]), .sum(sum), .cout(), .N(N_In), .Z(Z_Out), .V(V_In));

    Shifter shift(.Shift_In(ALU_In1), .Shift_Val(ALU_In2), .Shift_Out(shift_output), .Mode(Opcode[0]));

    RightRot rr(.RR_In(ALU_In1), .RR_Amt(ALU_In2), .RR_Out(RR_output));

    PADDSB pas(.regT(ALU_In1), .regS(ALU_In2), .regD(pas_output));

    dff N_dff(.q(N_Flag), .d(N_In), .wen(NZV_wen[2]), .clk(clk), .rst(rst));
    dff Z_dff(.q(Z_Flag), .d(Z_In), .wen(NZV_wen[1]), .clk(clk), .rst(rst));
    dff V_dff(.q(V_Flag), .d(V_In), .wen(NZV_wen[0]), .clk(clk), .rst(rst));

    Mem_Instr mem(.baseReg(ALU_In1), .offset(ALU_In2), .addr_out(Mem_output));

    assign Z_In = (Opcode[3:1] == 3'b000) ? Z_Out : Z;

    always @* case (Opcode)
        4'b0000: begin //ADD: N,Z,V
            ALU_Out = sum;
            NZV_wen = 3'b111;
        end
        4'b0001: begin //SUB: N,Z,V
            ALU_Out = sum;
            NZV_wen = 3'b111;
        end
        4'b0010: begin //XOR: Z
            ALU_Out = ALU_In1 ^ ALU_In2;
            NZV_wen = 3'b010;
            Z = (ALU_Out == 16'd0) ? 1'b1 : 1'b0;
        end
        4'b0011: begin //RED
            //ALU_Out =
            NZV_wen = 3'b000;
        end
        4'b0100: begin //SLL: Z
            ALU_Out = shift_output;
            NZV_wen = 3'b010;
            Z = (ALU_Out == 16'd0) ? 1'b1 : 1'b0;
        end
        4'b0101: begin //SRA: Z
            ALU_Out = shift_output;
            NZV_wen = 3'b010;
            Z = (ALU_Out == 16'd0) ? 1'b1 : 1'b0;
        end
        4'b0110: begin //ROR: Z
            ALU_Out = RR_output;
            NZV_wen = 3'b010;
            Z = (ALU_Out == 16'd0) ? 1'b1 : 1'b0;
        end
        4'b0111: begin //PADDSB
            ALU_Out = pas_output;
            NZV_wen = 3'b000;
        end
        4'b1000: begin //LW
            ALU_Out = Mem_output;
            NZV_wen = 3'b000;
        end
        4'b1001: begin //SW
            ALU_Out = Mem_output;
            NZV_wen = 3'b000;
        end
        4'b1010: begin //LLB
            ALU_Out = ((ALU_In1 & 16'hFF00) | {8'd0, ALU_In2[7:0]});
            NZV_wen = 3'b000;
        end
        4'b1011: begin //LHB
            ALU_Out = ((ALU_In1 & 16'h00FF) | {ALU_In2[7:0], 8'd0});
            NZV_wen = 3'b000;
        end
        4'b1100: begin //B

            NZV_wen = 3'b000;
        end
        4'b1101: begin //BR

            NZV_wen = 3'b000;
        end
        4'b1110: begin //PCS

            NZV_wen = 3'b000;
        end
        4'b1111: begin //HLT

            NZV_wen = 3'b000;
        end
        default: begin
            ALU_Out = 16'hxxxx;
            NZV_wen = 3'b000;
        end
    endcase
endmodule
