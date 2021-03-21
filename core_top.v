`include "defs.v"
module core_top #(parameter XLEN=32,parameter NUM_REGS=32,parameter RSLEN = `CLOG2(NUM_REGS))(
	input wire clk, 
	input wire rst,
	input wire [`InstBus] inst_i,
	output wire rom_ce0,
	output wire [`InstaddrBus] inst_pc);

	
	wire [`InstBus] inst_o;
	wire [`InstaddrBus] if_id_pc_o;
	wire [`InstBus] if_id_inst_o;

	wire [RSLEN-1:0] rsa_o;
	wire [RSLEN-1:0] rsb_o;
	wire [XLEN-1:0] rsa_data;
	wire [XLEN-1:0] rsb_data;
	wire regfile_we;
	wire [RSLEN-1:0] rsd_a;
	wire ALUSrc;
	wire [3:0] ALUOp;
	wire memtoreg;
	wire [XLEN-1:0] mem_data;
	wire [XLEN-1:0] wb_data;
	wire [XLEN-1:0] ALUOut;
	wire zero;
	wire [XLEN-1:0] imm_o;
	wire [XLEN-1:0] mux_ALUSrc;
	/*instrution fetch*/
	pc_reg pc_reg0( .clk(clk), .rst(rst), .pc(inst_pc), .ce(rom_ce0));

	if_id if_id0( .clk(clk), .rst(rst), .if_pc(inst_pc), .if_inst(inst_i), .id_pc(if_id_pc_o), .id_inst(if_id_inst_o));
	/*Instruction decode*/
	decode decode0(.rst(rst), .pc_i(if_id_pc_o), .inst_i(if_id_inst_o), .regfile_we(regfile_we), .rsa_a_o(rsa_o), .rsb_a_o(rsb_o), .rsd_o(rsd_a), .imm_o(imm_o), .ALUSrc(ALUSrc), .ALUOp(ALUOp), .memtoreg(memtoreg));

	regfile regfile(.clk(clk), .rst(rst), .rsa_a(rsa_o), .rsb_a(rsb_o), .wb_data(wb_data), .wb_addr(rsd_a), .wb_e(regfile_we), .rsa_o(rsa_data), .rsb_o(rsb_data));
	/*execute*/
	assign mux_ALUSrc = (ALUSrc == 1'b1) ? imm_o:rsb_data;
	execute execute0(.ALUcrl(ALUOp), .ALU_src_a(rsa_data), . ALU_src_b(mux_ALUSrc), .ALUOut(ALUOut), .zero(zero));
	/*memory read*/

	/*write back */
	assign wb_data = (memtoreg == 1'b1) ? mem_data:ALUOut;//data memory 待擴充

endmodule




