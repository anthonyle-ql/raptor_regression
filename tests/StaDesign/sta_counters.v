`timescale 1ns / 10ps
module top ( 
clock,
cen,
cout
);



//------Port Signals-------------------
//
input clock;
input [31:0] cen;
output cout;
reg cout;

//
// Misc
//
reg [31:0] cen_s1, cen_s2;
wire [31:0] count;
reg [31:0] scount;
reg [15:0] cnt_out0, cnt_out1, cnt_out2, cnt_out3, cnt_out4, cnt_out5, cnt_out6, cnt_out7;
reg [15:0] cnt_out8, cnt_out9, cnt_out10, cnt_out11, cnt_out12, cnt_out13, cnt_out14, cnt_out15;
reg	[15:0] cnt_out16, cnt_out17, cnt_out18, cnt_out19, cnt_out20, cnt_out21, cnt_out22, cnt_out23;
reg	[15:0] cnt_out24, cnt_out25, cnt_out26, cnt_out27, cnt_out28, cnt_out29, cnt_out30, cnt_out31;
wire clk_int;

//------Define Parameters--------------
//

gclkbuff u_gclkbuff_clock (.A(clock), .Z(clk_int));
//assign clk_int = clock;

always @( posedge clk_int)
begin
	cen_s1 <= cen;
	cen_s2 <= cen_s1;
	scount <= count;
	cout <= |{scount[31:0]};
end

// Counters in parallel
assign count[0] = &{cnt_out0};
always @( posedge clk_int )
begin
	if (cen_s2[0])
      cnt_out0 <= cnt_out0 + 1;
    else
      cnt_out0 <= 16'h0;  
end

assign count[1] = &{cnt_out1};
always @( posedge clk_int )
begin
	if (cen_s2[1])
      cnt_out1 <= cnt_out1 + 1;
    else
      cnt_out1 <= 16'h0;  
end

assign count[2] = &{cnt_out2};
always @( posedge clk_int )
begin
	if (cen_s2[2])
      cnt_out2 <= cnt_out2 + 1;
    else
      cnt_out2 <= 16'h0;  
end

assign count[3] = &{cnt_out3};
always @( posedge clk_int )
begin
	if (cen_s2[3])
      cnt_out3 <= cnt_out3 + 1;
    else
      cnt_out3 <= 16'h0;  
end

assign count[4] = &{cnt_out4};
always @( posedge clk_int )
begin
	if (cen_s2[4])
      cnt_out4 <= cnt_out4 + 1;
    else
      cnt_out4 <= 16'h0;  
end

assign count[5] = &{cnt_out5};
always @( posedge clk_int )
begin
	if (cen_s2[5])
      cnt_out5 <= cnt_out5 + 1;
    else
      cnt_out5 <= 16'h0;  
end

assign count[6] = &{cnt_out6};
always @( posedge clk_int )
begin
	if (cen_s2[6])
      cnt_out6 <= cnt_out6 + 1;
    else
      cnt_out6 <= 16'h0;  
end

assign count[7] = &{cnt_out7};
always @( posedge clk_int )
begin
	if (cen_s2[7])
      cnt_out7 <= cnt_out7 + 1;
    else
      cnt_out7 <= 16'h0;  
end

assign count[8] = &{cnt_out8};
always @( posedge clk_int )
begin
	if (cen_s2[8])
      cnt_out8 <= cnt_out8 + 1;
    else
      cnt_out8 <= 16'h0;  
end

assign count[9] = &{cnt_out9};
always @( posedge clk_int )
begin
	if (cen_s2[9])
      cnt_out9 <= cnt_out9 + 1;
    else
      cnt_out9 <= 16'h0;  
end

assign count[10] = &{cnt_out10};
always @( posedge clk_int )
begin
	if (cen_s2[10])
      cnt_out10 <= cnt_out10 + 1;
    else
      cnt_out10 <= 16'h0;  
end

assign count[11] = &{cnt_out11};
always @( posedge clk_int )
begin
	if (cen_s2[11])
      cnt_out11 <= cnt_out11 + 1;
    else
      cnt_out11 <= 16'h0;  
end

assign count[12] = &{cnt_out12};
always @( posedge clk_int )
begin
	if (cen_s2[12])
      cnt_out12 <= cnt_out12 + 1;
    else
      cnt_out12 <= 16'h0;  
end

assign count[13] = &{cnt_out13};
always @( posedge clk_int )
begin
	if (cen_s2[13])
      cnt_out13 <= cnt_out13 + 1;
    else
      cnt_out13 <= 16'h0;  
end

assign count[14] = &{cnt_out14};
always @( posedge clk_int )
begin
	if (cen_s2[14])
      cnt_out14 <= cnt_out14 + 1;
    else
      cnt_out14 <= 16'h0;  
end

assign count[15] = &{cnt_out15};
always @( posedge clk_int )
begin
	if (cen_s2[15])
      cnt_out15 <= cnt_out15 + 1;
    else
      cnt_out15 <= 16'h0;  
end

assign count[16] = &{cnt_out16};
always @( posedge clk_int )
begin
	if (cen_s2[16])
      cnt_out16 <= cnt_out16 + 1;
    else
      cnt_out16 <= 16'h0;  
end

assign count[17] = &{cnt_out17};
always @( posedge clk_int )
begin
	if (cen_s2[17])
      cnt_out17 <= cnt_out17 + 1;
    else
      cnt_out17 <= 16'h0;  
end

assign count[18] = &{cnt_out18};
always @( posedge clk_int )
begin
	if (cen_s2[18])
      cnt_out18 <= cnt_out18 + 1;
    else
      cnt_out18 <= 16'h0;  
end

assign count[19] = &{cnt_out19};
always @( posedge clk_int )
begin
	if (cen_s2[19])
      cnt_out19 <= cnt_out19 + 1;
    else
      cnt_out19 <= 16'h0;  
end

assign count[20] = &{cnt_out20};
always @( posedge clk_int )
begin
	if (cen_s2[20])
      cnt_out20 <= cnt_out20 + 1;
    else
      cnt_out20 <= 16'h0;  
end

assign count[21] = &{cnt_out21};
always @( posedge clk_int )
begin
	if (cen_s2[21])
      cnt_out21 <= cnt_out21 + 1;
    else
      cnt_out21 <= 16'h0;  
end

assign count[22] = &{cnt_out22};
always @( posedge clk_int )
begin
	if (cen_s2[22])
      cnt_out22 <= cnt_out22 + 1;
    else
      cnt_out22 <= 16'h0;  
end

assign count[23] = &{cnt_out23};
always @( posedge clk_int )
begin
	if (cen_s2[23])
      cnt_out23 <= cnt_out23 + 1;
    else
      cnt_out23 <= 16'h0;  
end

assign count[24] = &{cnt_out24};
always @( posedge clk_int )
begin
	if (cen_s2[24])
      cnt_out24 <= cnt_out24 + 1;
    else
      cnt_out24 <= 16'h0;  
end

assign count[25] = &{cnt_out25};
always @( posedge clk_int )
begin
	if (cen_s2[25])
      cnt_out25 <= cnt_out25 + 1;
    else
      cnt_out25 <= 16'h0;  
end

assign count[26] = &{cnt_out26};
always @( posedge clk_int )
begin
	if (cen_s2[26])
      cnt_out26 <= cnt_out26 + 1;
    else
      cnt_out26 <= 16'h0;  
end

assign count[27] = &{cnt_out27};
always @( posedge clk_int )
begin
	if (cen_s2[27])
      cnt_out27 <= cnt_out27 + 1;
    else
      cnt_out27 <= 16'h0;  
end

assign count[28] = &{cnt_out28};
always @( posedge clk_int )
begin
	if (cen_s2[28])
      cnt_out28 <= cnt_out28 + 1;
    else
      cnt_out28 <= 16'h0;  
end

assign count[29] = &{cnt_out29};
always @( posedge clk_int )
begin
	if (cen_s2[29])
      cnt_out29 <= cnt_out29 + 1;
    else
      cnt_out29 <= 16'h0;  
end

assign count[30] = &{cnt_out30};
always @( posedge clk_int )
begin
	if (cen_s2[30])
      cnt_out30 <= cnt_out30 + 1;
    else
      cnt_out30 <= 16'h0;  
end

assign count[31] = &{cnt_out31};
always @( posedge clk_int )
begin
	if (cen_s2[31])
      cnt_out31 <= cnt_out31 + 1;
    else
      cnt_out31 <= 16'h0;  
end

endmodule





