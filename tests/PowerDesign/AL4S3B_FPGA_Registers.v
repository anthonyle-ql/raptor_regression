`timescale 1ns / 10ps
module AL4S3B_FPGA_Registers ( 

                         // AHB-To_FPGA Bridge I/F
                         //
                         WBs_ADR_i,
                         WBs_CYC_i,
                         WBs_BYTE_STB_i,
                         WBs_WE_i,
                         WBs_STB_i,
                         WBs_DAT_i,
                         WBs_CLK_i,
                         WBs_RST_i,
                         WBs_DAT_o,
                         WBs_ACK_o,

                         Device_ID_o,
						 	 
                         scount
                         );


//------Port Parameters----------------
//

parameter            ADDRWIDTH                   =   7  ;   // Allow for up to 128 registers in the FPGA
parameter            DATAWIDTH                   =  32  ;   // Allow for up to 128 registers in the FPGA

parameter      	     FPGA_REG_ID_VALUE_ADR     	 =  7'h0; 
parameter      	     FPGA_CNT_EN_REG_ADR       	 =  7'h1;


//------Port Signals-------------------
//

// AHB-To_FPGA Bridge I/F
//
input   [ADDRWIDTH-1:0]  WBs_ADR_i     ;  // Address Bus                to   FPGA
input                    WBs_CYC_i     ;  // Cycle Chip Select          to   FPGA
input             [3:0]  WBs_BYTE_STB_i;  // Byte Select                to   FPGA
input                    WBs_WE_i      ;  // Write Enable               to   FPGA
input                    WBs_STB_i     ;  // Strobe Signal              to   FPGA
input   [DATAWIDTH-1:0]  WBs_DAT_i     ;  // Write Data Bus             to   FPGA
input                    WBs_CLK_i     ;  // FPGA Clock               from FPGA
input                    WBs_RST_i     ;  // FPGA Reset               to   FPGA
output  [DATAWIDTH-1:0]  WBs_DAT_o     ;  // Read Data Bus              from FPGA
output                   WBs_ACK_o     ;  // Transfer Cycle Acknowledge from FPGA

//
// Misc
//
output           [31:0]  Device_ID_o   ;

output           [31:0]  scount    ;
reg           [31:0]  scount    ;


// FPGA Global Signals
//
wire                     WBs_CLK_i     ;  // Wishbone FPGA Clock
wire                     WBs_RST_i     ;  // Wishbone FPGA Reset

// Wishbone Bus Signals
//
wire    [ADDRWIDTH-1:0]  WBs_ADR_i     ;  // Wishbone Address Bus
wire                     WBs_CYC_i     ;  // Wishbone Client Cycle  Strobe (i.e. Chip Select)
wire              [3:0]  WBs_BYTE_STB_i;  // Wishbone Byte   Enables
wire                     WBs_WE_i      ;  // Wishbone Write  Enable Strobe
wire                     WBs_STB_i     ;  // Wishbone Transfer      Strobe
wire    [DATAWIDTH-1:0]  WBs_DAT_i     ;  // Wishbone Write  Data Bus
 
reg     [DATAWIDTH-1:0]  WBs_DAT_o     ;  // Wishbone Read   Data Bus

reg                      WBs_ACK_o     ;  // Wishbone Client Acknowledge

// Misc
//
wire               [31:0] Device_ID_o   ;
wire               [31:0] count   ;
reg				   [31:0] count_enb, count_enbs;
reg			   [15:0] cnt_out0, cnt_out1, cnt_out2, cnt_out3, cnt_out4, cnt_out5, cnt_out6, cnt_out7;
reg			   [15:0] cnt_out8, cnt_out9, cnt_out10, cnt_out11, cnt_out12, cnt_out13, cnt_out14, cnt_out15;
reg			   [15:0] cnt_out16, cnt_out17, cnt_out18, cnt_out19, cnt_out20, cnt_out21, cnt_out22, cnt_out23;
reg			   [15:0] cnt_out24, cnt_out25, cnt_out26, cnt_out27, cnt_out28, cnt_out29, cnt_out30, cnt_out31;


//------Define Parameters--------------
//

//
// None at this time
//

//------Internal Signals---------------
//
wire     FPGA_CNT_SET_RST_Dcd    ;
wire     FPGA_CNT_EN_REG_Dcd ;

wire     WBs_ACK_o_nxt;

//------Logic Operations---------------
//
// Define the FPGA's local register write enables
//
assign FPGA_CNT_EN_REG_Dcd     = ( WBs_ADR_i == FPGA_CNT_EN_REG_ADR     ) & WBs_CYC_i & WBs_STB_i & WBs_WE_i   & (~WBs_ACK_o);

// Define the Acknowledge back to the host for registers
//
assign WBs_ACK_o_nxt  =   WBs_CYC_i & WBs_STB_i & (~WBs_ACK_o);


// Define the FPGA's Local Registers
//
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
    if (WBs_RST_i)
    begin
      count_enb        <= 32'b0;
	  count_enbs       <= 32'b0;
      WBs_ACK_o        <= 1'b0;
	  scount		   <= 32'h0;
    end  
    else
    begin
      if(FPGA_CNT_EN_REG_Dcd && WBs_BYTE_STB_i[0]) begin
        count_enb[7:0]          <= WBs_DAT_i[7:0]  ;
      end
	  if(FPGA_CNT_EN_REG_Dcd && WBs_BYTE_STB_i[1]) begin
        count_enb[15:8]          <= WBs_DAT_i[15:8]  ;
      end
	  if(FPGA_CNT_EN_REG_Dcd && WBs_BYTE_STB_i[2]) begin
        count_enb[23:16]          <= WBs_DAT_i[23:16]  ;
      end
	  if(FPGA_CNT_EN_REG_Dcd && WBs_BYTE_STB_i[3]) begin
        count_enb[31:24]          <= WBs_DAT_i[31:24]  ;
      end
      WBs_ACK_o   <=  WBs_ACK_o_nxt;
	  count_enbs  <=  count_enb;
	  scount      <=  count;
    end  
end

// Define the how to read the local registers and memory
//
assign Device_ID_o = 32'hfeed_1bee ;
always @(
         WBs_ADR_i         or
         Device_ID_o       or
         count_enb               
 )
 begin
    case(WBs_ADR_i[ADDRWIDTH-1:0])
		FPGA_REG_ID_VALUE_ADR     : WBs_DAT_o <= Device_ID_o;
		FPGA_CNT_EN_REG_ADR       : WBs_DAT_o <= count_enb;
		default                   : WBs_DAT_o <= 32'haa55_6699;
	endcase
end

// Counters in parallel
assign count[0] = &{cnt_out0};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out0  <= 16'h0     ;
  end  
  else begin
    if (count_enbs[0])
      cnt_out0 <= cnt_out0 + 1;
    else
      cnt_out0 <= 16'h0;
    end  
end

assign count[1] = &{cnt_out1};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out1 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[1])
      cnt_out1 <= cnt_out1+ 1;
    else
      cnt_out1 <= 16'h0;
    end  
end

assign count[2] = &{cnt_out2};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out2 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[2])
      cnt_out2 <= cnt_out2+ 1;
    else
      cnt_out2 <= 16'h0;
    end  
end

assign count[3] = &{cnt_out3};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out3 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[3])
      cnt_out3 <= cnt_out3+ 1;
    else
      cnt_out3 <= 16'h0;
    end  
end

assign count[4] = &{cnt_out4};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out4 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[4])
      cnt_out4 <= cnt_out4+ 1;
    else
      cnt_out4 <= 16'h0;
    end  
end

assign count[5] = &{cnt_out5};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out5 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[5])
      cnt_out5 <= cnt_out5+ 1;
    else
      cnt_out5 <= 16'h0;
    end  
end

assign count[6] = &{cnt_out6};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out6 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[6])
      cnt_out6 <= cnt_out6+ 1;
    else
      cnt_out6 <= 16'h0;
    end  
end

assign count[7] = &{cnt_out7};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out7 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[7])
      cnt_out7 <= cnt_out7+ 1;
    else
      cnt_out7 <= 16'h0;
    end  
end

assign count[8] = &{cnt_out8};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out8 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[8])
      cnt_out8 <= cnt_out8+ 1;
    else
      cnt_out8 <= 16'h0;
    end  
end

assign count[9] = &{cnt_out9};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out9 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[9])
      cnt_out9 <= cnt_out9+ 1;
    else
      cnt_out9 <= 16'h0;
    end  
end

assign count[10] = &{cnt_out10};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out10 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[10])
      cnt_out10 <= cnt_out10+ 1;
    else
      cnt_out10 <= 16'h0;
    end  
end

assign count[11] = &{cnt_out11};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out11 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[11])
      cnt_out11 <= cnt_out11+ 1;
    else
      cnt_out11 <= 16'h0;
    end  
end

assign count[12] = &{cnt_out12};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out12 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[12])
      cnt_out12 <= cnt_out12+ 1;
    else
      cnt_out12 <= 16'h0;
    end  
end

assign count[13] = &{cnt_out13};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out13 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[13])
      cnt_out13 <= cnt_out13+ 1;
    else
      cnt_out13 <= 16'h0;
    end  
end

assign count[14] = &{cnt_out14};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out14 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[14])
      cnt_out14 <= cnt_out14+ 1;
    else
      cnt_out14 <= 16'h0;
    end  
end

assign count[15] = &{cnt_out15};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out15 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[15])
      cnt_out15 <= cnt_out15+ 1;
    else
      cnt_out15 <= 16'h0;
    end  
end

assign count[15] = &{cnt_out15};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out15 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[15])
      cnt_out15 <= cnt_out15+ 1;
    else
      cnt_out15 <= 16'h0;
    end  
end

assign count[17] = &{cnt_out17};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out17 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[17])
      cnt_out17 <= cnt_out17+ 1;
    else
      cnt_out17 <= 16'h0;
    end  
end

assign count[18] = &{cnt_out18};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out18 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[18])
      cnt_out18 <= cnt_out18+ 1;
    else
      cnt_out18 <= 16'h0;
    end  
end

assign count[19] = &{cnt_out19};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out19 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[19])
      cnt_out19 <= cnt_out19+ 1;
    else
      cnt_out19 <= 16'h0;
    end  
end

assign count[20] = &{cnt_out20};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out20 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[20])
      cnt_out20 <= cnt_out20+ 1;
    else
      cnt_out20 <= 16'h0;
    end  
end

assign count[21] = &{cnt_out21};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out21 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[21])
      cnt_out21 <= cnt_out21+ 1;
    else
      cnt_out21 <= 16'h0;
    end  
end

assign count[22] = &{cnt_out22};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out22 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[22])
      cnt_out22 <= cnt_out22+ 1;
    else
      cnt_out22 <= 16'h0;
    end  
end

assign count[23] = &{cnt_out23};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out23 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[23])
      cnt_out23 <= cnt_out23+ 1;
    else
      cnt_out23 <= 16'h0;
    end  
end

assign count[24] = &{cnt_out24};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out24 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[24])
      cnt_out24 <= cnt_out24+ 1;
    else
      cnt_out24 <= 16'h0;
    end  
end

assign count[25] = &{cnt_out25};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out25 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[25])
      cnt_out25 <= cnt_out25+ 1;
    else
      cnt_out25 <= 16'h0;
    end  
end

assign count[26] = &{cnt_out26};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out26 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[26])
      cnt_out26 <= cnt_out26+ 1;
    else
      cnt_out26 <= 16'h0;
    end  
end

assign count[27] = &{cnt_out27};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out27 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[27])
      cnt_out27 <= cnt_out27+ 1;
    else
      cnt_out27 <= 16'h0;
    end  
end

assign count[28] = &{cnt_out28};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out28 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[28])
      cnt_out28 <= cnt_out28+ 1;
    else
      cnt_out28 <= 16'h0;
    end  
end

assign count[29] = &{cnt_out29};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out29 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[29])
      cnt_out29 <= cnt_out29+ 1;
    else
      cnt_out29 <= 16'h0;
    end  
end

assign count[30] = &{cnt_out30};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out30 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[30])
      cnt_out30 <= cnt_out30+ 1;
    else
      cnt_out30 <= 16'h0;
    end  
end

assign count[31] = &{cnt_out31};
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out31 <= 16'h0     ;
  end  
  else begin
    if (count_enbs[31])
      cnt_out31 <= cnt_out31+ 1;
    else
      cnt_out31 <= 16'h0;
    end  
end

endmodule





