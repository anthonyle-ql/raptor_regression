module r1024x16_1024x16 (WA,RA,WD,WClk,RClk,WClk_En,RClk_En,WEN,RD);

input [9:0] WA;
input [9:0] RA;
input WClk,RClk;
input WClk_En,RClk_En;
input [1:0] WEN;
input [15:0] WD;
output [15:0] RD;

parameter memfile="init_1024x16.hex";	

parameter addr_int = 10 ;
parameter data_depth_int = 1024;
parameter data_width_int = 16;
parameter wr_enable_int = 2;
parameter reg_rd_int = 0;

reg  [15:0] RD;

reg [data_width_int-1:0] 		mem [0: data_depth_int-1] /* verilator public */;

always @(posedge WClk) begin
  if (WEN[0]) mem[WA][7:0]   <= WD[7:0];
  if (WEN[1]) mem[WA][15:8]  <= WD[15:8];
end

always @(posedge RClk) begin
  RD <= mem[RA];
end

initial
  if(|memfile) begin
    $readmemh(memfile, mem);
  end

endmodule

