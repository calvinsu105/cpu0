module cpu0_tb;
reg CLOCK;
reg rst;


// block clock register and start the clock

initial
begin
	CLOCK = 1'b0;
	forever #10 CLOCK = ~CLOCK;
end

// setup rst and stop time

initial 
begin
	rst = 1'b1;

	#190 rst = 1'b0;

	#2000 $stop;
end

// test module

SOPC cpu_rv32i( .clk(CLOCK), .rst(rst));

//core_top core_top( .clk(CLOCK), .rst(rst), .if_id_inst_o(inst), .if_id_inst_pc(pc) );
//rom rom0( .addr(inst_pc), .ce(rom_ce0), .inst(inst_o));

initial begin
	$dumpfile("cpu0_tb.vcd");
	$dumpvars(0,cpu0_tb);
end

endmodule
