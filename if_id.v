`include "defs.v"
module if_id(
    input wire clk,
    input wire rst,
    input wire [`InstaddrBus] if_pc,
    input wire [`InstBus] if_inst,
    output reg [`InstaddrBus] id_pc,
    output reg [`InstBus] id_inst 
    );
    
    always @(posedge clk)
    begin
        if(rst == `Rsten)
        begin
            id_pc <=`ZWord;
            id_inst <=`ZWord;
        end
        else
        begin
            id_pc <= if_pc;
            id_inst <= if_inst;
        end
    end
endmodule

