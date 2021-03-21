`include "defs.v"
module decode #(parameter XLEN = 32)(
    input rst,
    input [`InstaddrBus] pc_i,
    input [`InstBus] inst_i,
    output reg regfile_we,
    output [4:0] rsa_a_o,
    output [4:0] rsb_a_o,
    output [4:0] rsd_o,
    output [XLEN-1:0] imm_o,
    output reg ALUSrc,
    output reg [3:0] ALUOp,
    output reg memtoreg);

/*decode*/
wire [XLEN-1:0] rv32_inst = inst_i;
wire [6:0] opcode = rv32_inst[`opcode];
wire [2:0] func3 = rv32_inst[`func3];
wire [6:0] func7 = rv32_inst[`func7];
wire [XLEN-1:0] imm_I,imm_J,imm_S,imm_B,imm_U;
wire [XLEN-1:0] imm;

wire rv32_based = (opcode[1:0]==2'b11);

/*R-type*/
wire rv32_op =(opcode[6:2] == 5'b01100);
wire rv32_func3_000 = (func3==3'b000);
wire rv32_func7_0100000 = (func7==7'b0100000);
wire rv32_func7_0000000 = (func7==7'b0000000);
wire rv32_sub = (rv32_func3_000 & rv32_func7_0100000);
wire rv32_add = (rv32_func3_000 & rv32_func7_0000000);

/*I-type*/
wire rv32_op_imm = (opcode[6:2]==5'b00100);
wire rv32_addi = (rv32_func3_000 & rv32_op_imm);
assign imm_I = { {21{rv32_inst[31]}}, rv32_inst[30: 25], rv32_inst[24: 21], rv32_inst[20] };


wire rv32_imm_seli = rv32_op_imm;
assign imm = {32{rv32_imm_seli}} & imm_I;

/*Output data*/
assign rsa_a_o = rv32_inst[`rsa];
assign rsb_a_o = rv32_inst[`rsb];
assign rsd_o = rv32_inst[`rd];
assign imm_o = imm;


always @ (*)
begin
    if(rst==`Rsten)
    begin
        regfile_we <= 1'b0;//write back enable
        ALUOp <= 1'b0;
        ALUSrc <= 1'b0;
    end
    else if(rv32_op == 1'b1)
    begin
        ALUSrc <= 1'b0;//1'b0 from regfile, 1'b1 from imm 
        regfile_we <= 1'b1;
        memtoreg <= 1'b0;//write back to regfile :1'b0 from ALU,1'b1 from memory
        if(rv32_sub == 1'b1) 
        begin
            ALUOp <= 4'b0110;//ALU_SUB
        end
        else if(rv32_add)
        begin
            ALUOp <= 4'b0010;//ALU_ADD
        end
    end 
    else if(rv32_op_imm) 
    begin
        memtoreg <= 1'b0;//write back to regfile :1'b0 from ALU,1'b1 from memory
        regfile_we <= 1'b1;//write back enable
        ALUSrc <= 1'b1;  
        if(rv32_addi)
        begin
           ALUOp <= 4'b0010; 
        end
    end
end

endmodule