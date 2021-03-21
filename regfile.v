`include "defs.v"
module regfile #(
    parameter NUM_REGS = 32,
    parameter XLEN = 32,
    parameter RSLEN = `CLOG2(NUM_REGS))(
    input clk,
    input rst,
    /*讀取rsa*/
    input [RSLEN-1:0] rsa_a,//rsa addr
    /*讀取rsb*/
    input [RSLEN-1:0] rsb_a,
    /*寫暫存器rd*/
    input [`IntSize] wb_data,
    input [RSLEN-1:0] wb_addr,
    input wb_e,
    /*輸出data1 2*/
    output [`IntSize] rsa_o,
    output [`IntSize] rsb_o     
);
reg [XLEN-1:0] rf[0:NUM_REGS-1];

wire we = wb_e &(|wb_addr);

assign rsa_o = (we&(rsa_a==wb_addr))?wb_data:rf[rsa_a];
assign rsb_o = (we&(rsb_a==wb_addr))?wb_data:rf[rsb_a];

always @(posedge clk)
begin
    if(rst==`Rsten)
    begin
        rf[0] <= `ZWord;
        rf[1] <= `ZWord;
        rf[2] <= `ZWord;
        rf[3] <= `ZWord;
        rf[4] <= `ZWord;
        rf[5] <= `ZWord;
        rf[6] <= `ZWord;
        rf[7] <= `ZWord;
        rf[8] <= `ZWord;
        rf[9] <= `ZWord;
        rf[10] <= `ZWord;
        rf[11] <= `ZWord;
        rf[12] <= `ZWord;
        rf[13] <= `ZWord;
        rf[14] <= `ZWord;
        rf[15] <= `ZWord;
        rf[16] <= `ZWord;
        rf[17] <= `ZWord;
        rf[18] <= `ZWord;
        rf[19] <= `ZWord;
        rf[20] <= `ZWord;
        rf[21] <= `ZWord;
        rf[22] <= `ZWord;
        rf[23] <= `ZWord;
        rf[24] <= `ZWord;
        rf[25] <= `ZWord;
        rf[26] <= `ZWord;
        rf[27] <= `ZWord;
        rf[28] <= `ZWord;
        rf[29] <= `ZWord;
        rf[30] <= `ZWord;
        rf[31] <= `ZWord; 
    end
   else 
   begin
       if(we)
       begin
            rf[wb_addr] <= wb_data;   
       end
   end 
   
end

endmodule