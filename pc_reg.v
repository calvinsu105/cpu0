`include "defs.v"
module pc_reg ( input wire clk, input wire rst, output reg [`InstaddrBus] pc, output reg ce);

always @(posedge clk)
begin
       if(rst==1'b1)
       	begin
       		ce <= 1'b0;
	end
	else if(rst==1'b0) 
	begin
		ce <=1'b1;
	end

end

always @(posedge clk)
begin
	if(ce==1'b0)
	begin
		pc <= 32'h0;
	end
	else if(ce==1'b1)
	begin
		pc = pc + 4'h4;
	end

end
endmodule

