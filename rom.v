`include "defs.v"
module rom ( input wire[31:0] addr, input wire ce, output reg[31:0] inst);

reg [31:0] rom [0:13071];

initial	$readmemh ("rom.data",rom);

always  @(addr,ce)
begin	
	if ( ce == 1'b0 )begin
		inst <= `ZWord;
	end
	else if ( ce == 1'b1)begin
		inst <= rom[addr[18:2]];
	end
end
endmodule
