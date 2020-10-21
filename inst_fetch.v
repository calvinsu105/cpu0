module inst_fetch (input wire clk, input wire rst, output wire [31:0] inst_o);

	wire [5:0] pc0;
	wire rom_ce0;
	
	pc_reg pc_reg0( .clk(clk), .rst(rst), .pc(pc0), .ce(rom_ce0));

	rom rom0( .addr(pc0), .ce(rom_ce0), .inst(inst_o));

endmodule




