module cpu0_tb;
reg CLOCK;
reg rst;
wire [31:0]  inst;

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

inst_fetch inst_fetch0( .clk(CLOCK), .rst(rst), .inst_o(inst) );

initial begin
	$dumpfile("cpu0_tb.vcd");
	$dumpvars(0,cpu0_tb);
end

endmodule
