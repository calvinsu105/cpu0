module SOPC (input clk, input rst);

wire [31:0] pc_o;
wire [31:0]  inst_o;
wire [31:0]  pc;
wire rom_ce0;

core_top core0( .clk(clk), .rst(rst), .inst_i(inst_o), .rom_ce0(rom_ce0), .inst_pc(pc));

rom rom0( .addr(pc), .ce(rom_ce0), .inst(inst_o));

endmodule