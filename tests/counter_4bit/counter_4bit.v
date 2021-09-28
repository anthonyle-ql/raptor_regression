module top (clk, reset, enable, count);
input clk, reset, enable;
output [3:0] count;
reg [3:0] count;
wire  clk_int;                

gclkbuff u_gclkbuff_clock (.A(clk), .Z(clk_int));                  

always @ (posedge clk_int or posedge reset) 
begin
  if (reset == 1'b1) begin
    count <= 0;
  end 
  else if ( enable == 1'b1) begin
    count <= count + 1;
  end
end

endmodule  
