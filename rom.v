module rom ( input wire[5:0] addr, input wire ce, output reg[31:0] inst);

reg [31:0] rom [0:63];

initial	$readmemh ("rom.data",rom);

always  @(addr,ce)
begin	
	if ( ce == 1'b0 )begin
		inst <= 32'h0;
	end
	else if ( ce == 1'b1)begin
		inst <= rom[addr];
	end
end
endmodule
