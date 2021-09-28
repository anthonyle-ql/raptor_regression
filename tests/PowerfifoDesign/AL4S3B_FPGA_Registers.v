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
parameter       	 FPGA_CNT_SET_RST_REG_ADR    =  7'h2; 
parameter      	     FPGA_CNT_EN_REG_ADR       	 =  7'h3;


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
reg			   	   [31:0] cnt_out0, scnt_out0;


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
wire [3:0] PUSH_FLAG1, POP_FLAG1;
wire [3:0] PUSH_FLAG2, POP_FLAG2;
wire [3:0] PUSH_FLAG3, POP_FLAG3;
wire [3:0] PUSH_FLAG4, POP_FLAG4;
wire [3:0] PUSH_FLAG5, POP_FLAG5;
wire [3:0] PUSH_FLAG6, POP_FLAG6;
wire [3:0] PUSH_FLAG7, POP_FLAG7;
wire [3:0] PUSH_FLAG8, POP_FLAG8;
wire Almost_Full1, Almost_Empty1;
wire Almost_Full2, Almost_Empty2;
wire Almost_Full3, Almost_Empty3;
wire Almost_Full4, Almost_Empty4;
wire Almost_Full5, Almost_Empty5;
wire Almost_Full6, Almost_Empty6;
wire Almost_Full7, Almost_Empty7;
wire Almost_Full8, Almost_Empty8;
reg pop1, pop2, pop3, pop4, pop5, pop6, pop7, pop8;
wire [15:0] FIFO1_DOUT, FIFO2_DOUT, FIFO3_DOUT, FIFO4_DOUT;
reg [15:0] SFIFO1_DOUT, SFIFO2_DOUT, SFIFO3_DOUT, SFIFO4_DOUT;
wire [15:0] FIFO5_DOUT, FIFO6_DOUT, FIFO7_DOUT, FIFO8_DOUT;
reg [15:0] SFIFO5_DOUT, SFIFO6_DOUT, SFIFO7_DOUT, SFIFO8_DOUT;
reg cntr_ena;

//------Logic Operations---------------
//
// Define the FPGA's local register write enables
//
assign FPGA_CNT_EN_REG_Dcd     = ( WBs_ADR_i == FPGA_CNT_EN_REG_ADR     ) & WBs_CYC_i & WBs_STB_i & WBs_WE_i   & (~WBs_ACK_o);
assign FPGA_CNT_SET_RST_Dcd    = ( WBs_ADR_i == FPGA_CNT_SET_RST_REG_ADR     ) & WBs_CYC_i & WBs_STB_i & WBs_WE_i   & (~WBs_ACK_o);

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
	  scnt_out0 	   <= 32'h0;
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
	  scnt_out0   <= cnt_out0;
    end  
end

always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
    if (WBs_RST_i)
    begin
      cntr_ena        <= 1'b0;
    end  
    else
    begin
      if(FPGA_CNT_SET_RST_Dcd && WBs_BYTE_STB_i[0])
        cntr_ena          <= WBs_DAT_i[0]  ;
	  else
	    cntr_ena          <= cntr_ena  ;
    end  
end

// Define the how to read the local registers and memory
//
assign Device_ID_o = 32'hfeed_2bee ;
always @(
         WBs_ADR_i         or
         Device_ID_o       or
         count_enb         or
		 cntr_ena
 )
 begin
    case(WBs_ADR_i[ADDRWIDTH-1:0])
		FPGA_REG_ID_VALUE_ADR     : WBs_DAT_o <= Device_ID_o;
		FPGA_CNT_EN_REG_ADR       : WBs_DAT_o <= count_enb;
		FPGA_CNT_SET_RST_REG_ADR  : WBs_DAT_o <= {31'h0, cntr_ena};
		default                   : WBs_DAT_o <= 32'haa55_6699;
	endcase
end

// Counters in parallel
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    cnt_out0  <= 32'h0     ;
  end  
  else begin
    if (cntr_ena)
      cnt_out0 <= cnt_out0 + 1;
    else
      cnt_out0 <= 32'h0;
    end  
end

// FIFO pops
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) 
  begin
    pop1 <= 1'b0;
	pop2 <= 1'b0;
	pop3 <= 1'b0;
	pop4 <= 1'b0;
	pop5 <= 1'b0;
	pop6 <= 1'b0;
	pop7 <= 1'b0;
	pop8 <= 1'b0;
	SFIFO1_DOUT <= 16'h0;
	SFIFO2_DOUT <= 16'h0;
	SFIFO3_DOUT <= 16'h0;
	SFIFO4_DOUT <= 16'h0;
	SFIFO5_DOUT <= 16'h0;
	SFIFO6_DOUT <= 16'h0;
	SFIFO7_DOUT <= 16'h0;
	SFIFO8_DOUT <= 16'h0;
  end  
  else 
  begin
    pop1 <= count_enbs[3];
	pop2 <= count_enbs[7];
	pop3 <= count_enbs[11];
	pop4 <= count_enbs[15];
	pop5 <= count_enbs[19];
	pop6 <= count_enbs[23];
	pop7 <= count_enbs[27];
	pop8 <= count_enbs[31];
	SFIFO1_DOUT <= FIFO1_DOUT;
	SFIFO2_DOUT <= FIFO2_DOUT;
	SFIFO3_DOUT <= FIFO3_DOUT;
	SFIFO4_DOUT <= FIFO4_DOUT;
	SFIFO5_DOUT <= FIFO5_DOUT;
	SFIFO6_DOUT <= FIFO6_DOUT;
	SFIFO7_DOUT <= FIFO7_DOUT;
	SFIFO8_DOUT <= FIFO8_DOUT;
  end  
end

assign count[0] = & {SFIFO1_DOUT};
assign count[1] = & {SFIFO2_DOUT};
assign count[2] = & {SFIFO3_DOUT};
assign count[3] = & {SFIFO4_DOUT};
assign count[4] = & {SFIFO5_DOUT};
assign count[5] = & {SFIFO6_DOUT};
assign count[6] = & {SFIFO7_DOUT};
assign count[7] = & {SFIFO8_DOUT};

// RAM Instances
af512x16_512x16 FIFO1_INST (
                          .DIN(scnt_out0[15:0]),
                          .PUSH(count_enbs[3]),
                          .POP(pop1),
                          .Fifo_Push_Flush(count_enbs[0]),
                          .Fifo_Pop_Flush(count_enbs[0]),
                          .Push_Clk(WBs_CLK_i),
                          .Pop_Clk(WBs_CLK_i),
                          .PUSH_FLAG(PUSH_FLAG1),
                          .POP_FLAG(POP_FLAG1),
                          .Push_Clk_En(count_enbs[1]),
                          .Pop_Clk_En(count_enbs[2]),
                          .Fifo_Dir(1'b0),
                          .Async_Flush(count_enbs[0]),
                          .Almost_Full(Almost_Full1),
                          .Almost_Empty(Almost_Empty1),
                          .DOUT(FIFO1_DOUT)
                          );

af512x16_512x16 FIFO2_INST (
                          .DIN(scnt_out0[15:0]),
                          .PUSH(count_enbs[7]),
                          .POP(pop2),
                          .Fifo_Push_Flush(count_enbs[4]),
                          .Fifo_Pop_Flush(count_enbs[4]),
                          .Push_Clk(WBs_CLK_i),
                          .Pop_Clk(WBs_CLK_i),
                          .PUSH_FLAG(PUSH_FLAG2),
                          .POP_FLAG(POP_FLAG2),
                          .Push_Clk_En(count_enbs[5]),
                          .Pop_Clk_En(count_enbs[6]),
                          .Fifo_Dir(1'b0),
                          .Async_Flush(count_enbs[4]),
                          .Almost_Full(Almost_Full2),
                          .Almost_Empty(Almost_Empty2),
                          .DOUT(FIFO2_DOUT)
                          );						  

af512x16_512x16 FIFO3_INST (
                          .DIN(scnt_out0[15:0]),
                          .PUSH(count_enbs[11]),
                          .POP(pop3),
                          .Fifo_Push_Flush(count_enbs[8]),
                          .Fifo_Pop_Flush(count_enbs[8]),
                          .Push_Clk(WBs_CLK_i),
                          .Pop_Clk(WBs_CLK_i),
                          .PUSH_FLAG(PUSH_FLAG3),
                          .POP_FLAG(POP_FLAG3),
                          .Push_Clk_En(count_enbs[9]),
                          .Pop_Clk_En(count_enbs[10]),
                          .Fifo_Dir(1'b0),
                          .Async_Flush(count_enbs[8]),
                          .Almost_Full(Almost_Full3),
                          .Almost_Empty(Almost_Empty3),
                          .DOUT(FIFO3_DOUT)
                          );
						  
af512x16_512x16 FIFO4_INST (
                          .DIN(scnt_out0[15:0]),
                          .PUSH(count_enbs[15]),
                          .POP(pop4),
                          .Fifo_Push_Flush(count_enbs[12]),
                          .Fifo_Pop_Flush(count_enbs[12]),
                          .Push_Clk(WBs_CLK_i),
                          .Pop_Clk(WBs_CLK_i),
                          .PUSH_FLAG(PUSH_FLAG4),
                          .POP_FLAG(POP_FLAG4),
                          .Push_Clk_En(count_enbs[13]),
                          .Pop_Clk_En(count_enbs[14]),
                          .Fifo_Dir(1'b0),
                          .Async_Flush(count_enbs[12]),
                          .Almost_Full(Almost_Full4),
                          .Almost_Empty(Almost_Empty4),
                          .DOUT(FIFO4_DOUT)
                          );

af512x16_512x16 FIFO5_INST (
                          .DIN(scnt_out0[15:0]),
                          .PUSH(count_enbs[19]),
                          .POP(pop5),
                          .Fifo_Push_Flush(count_enbs[16]),
                          .Fifo_Pop_Flush(count_enbs[16]),
                          .Push_Clk(WBs_CLK_i),
                          .Pop_Clk(WBs_CLK_i),
                          .PUSH_FLAG(PUSH_FLAG5),
                          .POP_FLAG(POP_FLAG5),
                          .Push_Clk_En(count_enbs[17]),
                          .Pop_Clk_En(count_enbs[18]),
                          .Fifo_Dir(1'b0),
                          .Async_Flush(count_enbs[16]),
                          .Almost_Full(Almost_Full5),
                          .Almost_Empty(Almost_Empty5),
                          .DOUT(FIFO5_DOUT)
                          );
						  
af512x16_512x16 FIFO6_INST (
                          .DIN(scnt_out0[15:0]),
                          .PUSH(count_enbs[23]),
                          .POP(pop6),
                          .Fifo_Push_Flush(count_enbs[20]),
                          .Fifo_Pop_Flush(count_enbs[20]),
                          .Push_Clk(WBs_CLK_i),
                          .Pop_Clk(WBs_CLK_i),
                          .PUSH_FLAG(PUSH_FLAG6),
                          .POP_FLAG(POP_FLAG6),
                          .Push_Clk_En(count_enbs[21]),
                          .Pop_Clk_En(count_enbs[22]),
                          .Fifo_Dir(1'b0),
                          .Async_Flush(count_enbs[20]),
                          .Almost_Full(Almost_Full6),
                          .Almost_Empty(Almost_Empty6),
                          .DOUT(FIFO6_DOUT)
                          );

af512x16_512x16 FIFO7_INST (
                          .DIN(scnt_out0[15:0]),
                          .PUSH(count_enbs[27]),
                          .POP(pop7),
                          .Fifo_Push_Flush(count_enbs[24]),
                          .Fifo_Pop_Flush(count_enbs[24]),
                          .Push_Clk(WBs_CLK_i),
                          .Pop_Clk(WBs_CLK_i),
                          .PUSH_FLAG(PUSH_FLAG7),
                          .POP_FLAG(POP_FLAG7),
                          .Push_Clk_En(count_enbs[25]),
                          .Pop_Clk_En(count_enbs[26]),
                          .Fifo_Dir(1'b0),
                          .Async_Flush(count_enbs[24]),
                          .Almost_Full(Almost_Full7),
                          .Almost_Empty(Almost_Empty7),
                          .DOUT(FIFO7_DOUT)
                          );
						  
af512x16_512x16 FIFO8_INST (
                          .DIN(scnt_out0[15:0]),
                          .PUSH(count_enbs[31]),
                          .POP(pop8),
                          .Fifo_Push_Flush(count_enbs[28]),
                          .Fifo_Pop_Flush(count_enbs[28]),
                          .Push_Clk(WBs_CLK_i),
                          .Pop_Clk(WBs_CLK_i),
                          .PUSH_FLAG(PUSH_FLAG8),
                          .POP_FLAG(POP_FLAG8),
                          .Push_Clk_En(count_enbs[29]),
                          .Pop_Clk_En(count_enbs[30]),
                          .Fifo_Dir(1'b0),
                          .Async_Flush(count_enbs[28]),
                          .Almost_Full(Almost_Full8),
                          .Almost_Empty(Almost_Empty8),
                          .DOUT(FIFO8_DOUT)
                          );
						  
endmodule





