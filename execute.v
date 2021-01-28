`include "defs.v"

module execute #(parameter XLEN=32)(
    input [3:0] ALUcrl,
    input [XLEN-1:0] ALU_src_a,
    input [XLEN-1:0] ALU_src_b,
    output reg [XLEN-1:0] ALUOut,
    output zero );
 
 assign zero = (ALUOut==`ZWord);

always @(ALUcrl,ALU_src_a,ALU_src_b)
begin
    case(ALUcrl)
        4'b0000: ALUOut <= ALU_src_a & ALU_src_b;
        4'b0001: ALUOut <= ALU_src_a | ALU_src_b;
        4'b0010: ALUOut <= ALU_src_a + ALU_src_b;
        4'b0110: ALUOut <= ALU_src_a - ALU_src_b;
        4'b0111: ALUOut <= (ALU_src_a < ALU_src_b)?1:0;
        4'b1100: ALUOut <= ~(ALU_src_a | ALU_src_b);
        default: ALUOut <= `ZWord;
    endcase
end

endmodule   
