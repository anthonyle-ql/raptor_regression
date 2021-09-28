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
reg			   	   [8:0] ram_adr, sram_adr;
reg			   	   [15:0] ram_data, sram_data;


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
wire [15:0] RAM1_DOUT, RAM2_DOUT, RAM3_DOUT, RAM4_DOUT;
reg [15:0] SRAM1_DOUT, SRAM2_DOUT, SRAM3_DOUT, SRAM4_DOUT;
wire [15:0] RAM5_DOUT, RAM6_DOUT, RAM7_DOUT, RAM8_DOUT;
reg [15:0] SRAM5_DOUT, SRAM6_DOUT, SRAM7_DOUT, SRAM8_DOUT;
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

// Counters
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) begin
    ram_adr  <= 9'h0;
	ram_data <= 16'h0;
	sram_adr <= 9'h0;
	sram_data <= 16'h0;
  end  
  else begin
    sram_adr <= ram_adr;
	sram_data <= ram_data;
    if (cntr_ena) begin
      ram_adr <= ram_adr + 1;
	  ram_data <= ram_data + 1;
	end
    else begin
      ram_adr <= 9'h0;
	  ram_data <= 16'h0;
    end  
  end
end

// FIFO pops
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
  if (WBs_RST_i) 
  begin
	SRAM1_DOUT <= 16'h0;
	SRAM2_DOUT <= 16'h0;
	SRAM3_DOUT <= 16'h0;
	SRAM4_DOUT <= 16'h0;
	SRAM5_DOUT <= 16'h0;
	SRAM6_DOUT <= 16'h0;
	SRAM7_DOUT <= 16'h0;
	SRAM8_DOUT <= 16'h0;
  end  
  else 
  begin
	SRAM1_DOUT <= RAM1_DOUT;
	SRAM2_DOUT <= RAM2_DOUT;
	SRAM3_DOUT <= RAM3_DOUT;
	SRAM4_DOUT <= RAM4_DOUT;
	SRAM5_DOUT <= RAM5_DOUT;
	SRAM6_DOUT <= RAM6_DOUT;
	SRAM7_DOUT <= RAM7_DOUT;
	SRAM8_DOUT <= RAM8_DOUT;
  end  
end

assign count[0] = & {SRAM1_DOUT};
assign count[1] = & {SRAM2_DOUT};
assign count[2] = & {SRAM3_DOUT};
assign count[3] = & {SRAM4_DOUT};
assign count[4] = & {SRAM5_DOUT};
assign count[5] = & {SRAM6_DOUT};
assign count[6] = & {SRAM7_DOUT};
assign count[7] = & {SRAM8_DOUT};

// RAM Instances
r512x16_512x16 RAM1_INST (	
			.WA(sram_adr[8:0]),
			.RA(sram_adr[8:0]),
			.WD(sram_data[15:0]),
			.WClk(WBs_CLK_i),
			.RClk(WBs_CLK_i),
			.WClk_En(count_enbs[2]),
			.RClk_En(count_enbs[3]),
			.WEN({count_enbs[1],count_enbs[0]}),
			.RD(RAM1_DOUT)
			);
			
r512x16_512x16 RAM2_INST (	
			.WA(sram_adr[8:0]),
			.RA(sram_adr[8:0]),
			.WD(sram_data[15:0]),
			.WClk(WBs_CLK_i),
			.RClk(WBs_CLK_i),
			.WClk_En(count_enbs[6]),
			.RClk_En(count_enbs[7]),
			.WEN({count_enbs[5],count_enbs[4]}),
			.RD(RAM2_DOUT)
			);

r512x16_512x16 RAM3_INST (	
			.WA(sram_adr[8:0]),
			.RA(sram_adr[8:0]),
			.WD(sram_data[15:0]),
			.WClk(WBs_CLK_i),
			.RClk(WBs_CLK_i),
			.WClk_En(count_enbs[10]),
			.RClk_En(count_enbs[11]),
			.WEN({count_enbs[9],count_enbs[8]}),
			.RD(RAM3_DOUT)
			);

r512x16_512x16 RAM4_INST (	
			.WA(sram_adr[8:0]),
			.RA(sram_adr[8:0]),
			.WD(sram_data[15:0]),
			.WClk(WBs_CLK_i),
			.RClk(WBs_CLK_i),
			.WClk_En(count_enbs[14]),
			.RClk_En(count_enbs[15]),
			.WEN({count_enbs[13],count_enbs[12]}),
			.RD(RAM4_DOUT)
			);

r512x16_512x16 RAM5_INST (	
			.WA(sram_adr[8:0]),
			.RA(sram_adr[8:0]),
			.WD(sram_data[15:0]),
			.WClk(WBs_CLK_i),
			.RClk(WBs_CLK_i),
			.WClk_En(count_enbs[18]),
			.RClk_En(count_enbs[19]),
			.WEN({count_enbs[17],count_enbs[16]}),
			.RD(RAM5_DOUT)
			);

r512x16_512x16 RAM6_INST (	
			.WA(sram_adr[8:0]),
			.RA(sram_adr[8:0]),
			.WD(sram_data[15:0]),
			.WClk(WBs_CLK_i),
			.RClk(WBs_CLK_i),
			.WClk_En(count_enbs[22]),
			.RClk_En(count_enbs[23]),
			.WEN({count_enbs[21],count_enbs[20]}),
			.RD(RAM6_DOUT)
			);

r512x16_512x16 RAM7_INST (	
			.WA(sram_adr[8:0]),
			.RA(sram_adr[8:0]),
			.WD(sram_data[15:0]),
			.WClk(WBs_CLK_i),
			.RClk(WBs_CLK_i),
			.WClk_En(count_enbs[26]),
			.RClk_En(count_enbs[27]),
			.WEN({count_enbs[25],count_enbs[24]}),
			.RD(RAM7_DOUT)
			);

r512x16_512x16 RAM8_INST (	
			.WA(sram_adr[8:0]),
			.RA(sram_adr[8:0]),
			.WD(sram_data[15:0]),
			.WClk(WBs_CLK_i),
			.RClk(WBs_CLK_i),
			.WClk_En(count_enbs[30]),
			.RClk_En(count_enbs[31]),
			.WEN({count_enbs[29],count_enbs[28]}),
			.RD(RAM8_DOUT)
			);
			
endmodule





