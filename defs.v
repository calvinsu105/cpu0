/*Instruction decode*/
`define opcode 6:0
`define func3 14:12
`define func7 31:25

`define rd 11:7
`define rsa 19:15
`define rsb 24:20
`define IntSize 31:0

/*The defs related to rom*/
`define InstaddrBus 31:0
`define InstBus 31:0

/*Global defs*/
`define Rsten 1'b1
`define Rstdis 1'b0
`define ZWord 32'h00000000

`define CLOG2(x) (x<=2)?1:(x<=4)?2:(x<=8)?3:(x<=16)?4:(x<=32)?5:-1

/*opcode*/
