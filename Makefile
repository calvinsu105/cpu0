#cpu0_makfile

cpu0_tb: core_top.v cpu0_tb.v defs.v if_id.v pc_reg.v rom.v decode.v regfile.v execute.v
	iverilog -o cpu0_test SOPC.v core_top.v cpu0_tb.v defs.v if_id.v pc_reg.v rom.v decode.v regfile.v execute.v
	
.PHONY:clean
clean: 
	rm -f *.o cpu0_test

gtkwave: cpu0_tb.vcd
	gtkwave cpu0_tb.vcd

.PHONY:cleanwave
cleanwave:
	rm -f *.vcd cpu0_tb.vcd
