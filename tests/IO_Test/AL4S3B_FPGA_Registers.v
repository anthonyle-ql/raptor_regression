// -----------------------------------------------------------------------------
// title          : AL4S3B Example FPGA Register Module
// project        : Tamar2 Device
// -----------------------------------------------------------------------------
// file           : AL4S3B_FPGA_Registers.v
// author         : SSG
// company        : QuickLogic Corp
// created        : 2016/02/03	
// last update    : 2016/02/03
// platform       : ArcticLink 4 S3B
// standard       : Verilog 2001
// -----------------------------------------------------------------------------
// description: The FPGA example IP design contains the essential logic for
//              interfacing the ASSP of the AL4S3B to registers and memory 
//              located in the programmable FPGA.
// -----------------------------------------------------------------------------
// copyright (c) 2016
// -----------------------------------------------------------------------------
// revisions  :
// date            version    author         description
// 2016/02/03      1.0        Rakesh M     Initial Release
//
// -----------------------------------------------------------------------------
// Comments: This solution is specifically for use with the QuickLogic
//           AL4S3B device. 
// -----------------------------------------------------------------------------
//
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

                         //
                         // Misc
                         //
                         CLK_4M_CNTL_o,
                         CLK_1M_CNTL_o,
                         Device_ID_o,
					 
                         GPIO_IN_i,
				                 GPIO_OUT_o,
				                 GPIO_OE_o
                         );


//------Port Parameters----------------
//

parameter                ADDRWIDTH                   =   7  ;   // Allow for up to 128 registers in the FPGA
parameter                DATAWIDTH                   =  32  ;   // Allow for up to 128 registers in the FPGA

parameter                FPGA_REG_ID_VALUE_ADR       =  7'h0; 
parameter                FPGA_MODE_SEL_ADR           =  7'h1; 
parameter                FPGA_GPIO_IN_REG_ADR1       =  7'h2; 
parameter                FPGA_GPIO_IN_REG_ADR2       =  7'h3;
parameter                FPGA_GPIO_OUT_REG_ADR1      =  7'h4; 
parameter                FPGA_GPIO_OUT_REG_ADR2      =  7'h5; 
parameter                FPGA_GPIO_OE_REG_ADR1       =  7'h6; 
parameter                FPGA_GPIO_OE_REG_ADR2       =  7'h7;

parameter                AL4S3B_DEVICE_ID            = 16'h0;
parameter                AL4S3B_REV_LEVEL            = 32'h0;
parameter                AL4S3B_GPIO_REG             = 46'h0;
parameter                AL4S3B_GPIO_OE_REG          = 46'h0;

parameter                AL4S3B_DEF_REG_VALUE        = 32'hFAB_DEF_AC;


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

output 					         CLK_4M_CNTL_o;
output 					         CLK_1M_CNTL_o;

// GPIO
//
input            [45:0]  GPIO_IN_i     ;
output           [45:0]  GPIO_OUT_o    ;
output           [45:0]  GPIO_OE_o     ;

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
wire              [31:0]  Device_ID_o   ;

// GPIO
//
wire             [45:0]  GPIO_IN_i;
reg              [45:0]  GPIO_OUT_o;
reg              [45:0]  GPIO_OE_o;

reg               [3:0]  Mode_Sel_o;

//------Define Parameters--------------
//

//
// None at this time
//

//------Internal Signals---------------
//
wire                     FB_Mode_Sel_Wr_Dcd;
wire                     FB_GPIO_Reg_Wr_Dcd1;
wire                     FB_GPIO_Reg_Wr_Dcd2;
wire                     FB_GPIO_OE_Reg_Wr_Dcd1;
wire                     FB_GPIO_OE_Reg_Wr_Dcd2;

wire					           WBs_ACK_o_nxt;


//------Logic Operations---------------
//
assign CLK_4M_CNTL_o = 1'b0 ;
assign CLK_1M_CNTL_o = 1'b0 ;

// Define the FPGA's local register write enables
//
assign FB_Mode_Sel_Wr_Dcd     = ( WBs_ADR_i == FPGA_MODE_SEL_ADR ) & WBs_CYC_i & WBs_STB_i & WBs_WE_i & (~WBs_ACK_o);
assign FB_GPIO_Reg_Wr_Dcd1    = ( WBs_ADR_i == FPGA_GPIO_OUT_REG_ADR1 ) & WBs_CYC_i & WBs_STB_i & WBs_WE_i & (~WBs_ACK_o);
assign FB_GPIO_Reg_Wr_Dcd2    = ( WBs_ADR_i == FPGA_GPIO_OUT_REG_ADR2 ) & WBs_CYC_i & WBs_STB_i & WBs_WE_i & (~WBs_ACK_o);
assign FB_GPIO_OE_Reg_Wr_Dcd1 = ( WBs_ADR_i == FPGA_GPIO_OE_REG_ADR1 ) & WBs_CYC_i & WBs_STB_i & WBs_WE_i & (~WBs_ACK_o);
assign FB_GPIO_OE_Reg_Wr_Dcd2 = ( WBs_ADR_i == FPGA_GPIO_OE_REG_ADR2 ) & WBs_CYC_i & WBs_STB_i & WBs_WE_i & (~WBs_ACK_o);

// Define the Acknowledge back to the host for registers
//
assign WBs_ACK_o_nxt          =   WBs_CYC_i & WBs_STB_i & (~WBs_ACK_o);


// Define the FPGA's Local Registers
//
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
    if (WBs_RST_i) begin
		  Mode_Sel_o  <= 4'h0;    
      GPIO_OUT_o  <= AL4S3B_GPIO_REG;
      GPIO_OE_o   <= AL4S3B_GPIO_OE_REG;
      WBs_ACK_o   <= 1'b0;
    end  
    else begin	
      if(FB_Mode_Sel_Wr_Dcd && WBs_BYTE_STB_i[0])
        Mode_Sel_o[3:0] <= WBs_DAT_i[3:0]  ;

      // Define the GPIO Register 
      //
      if (FB_GPIO_Reg_Wr_Dcd1 && WBs_BYTE_STB_i[0]) 
        GPIO_OUT_o[7:0] <= WBs_DAT_i[7:0]  ;

      if (FB_GPIO_Reg_Wr_Dcd1 && WBs_BYTE_STB_i[1])
        GPIO_OUT_o[15:8] <= WBs_DAT_i[15:8] ;

      if (FB_GPIO_Reg_Wr_Dcd1 && WBs_BYTE_STB_i[2])
        GPIO_OUT_o[23:16] <= WBs_DAT_i[23:16];
			
      if (FB_GPIO_Reg_Wr_Dcd1 && WBs_BYTE_STB_i[3])
        GPIO_OUT_o[31:24] <= WBs_DAT_i[31:24];
			
      if (FB_GPIO_Reg_Wr_Dcd2 && WBs_BYTE_STB_i[0]) 
        GPIO_OUT_o[39:32] <= WBs_DAT_i[7:0]  ;
			
      if (FB_GPIO_Reg_Wr_Dcd2 && WBs_BYTE_STB_i[1]) 
        GPIO_OUT_o[45:40] <= WBs_DAT_i[13:8]  ;

      // Define the GPIO Control Register 
      //
      if(FB_GPIO_OE_Reg_Wr_Dcd1 && WBs_BYTE_STB_i[0])
        GPIO_OE_o[7:0] <= WBs_DAT_i[7:0]  ;

      if(FB_GPIO_OE_Reg_Wr_Dcd1 && WBs_BYTE_STB_i[1])
        GPIO_OE_o[15:8] <= WBs_DAT_i[15:8] ;

      if(FB_GPIO_OE_Reg_Wr_Dcd1 && WBs_BYTE_STB_i[2])
        GPIO_OE_o[23:16] <= WBs_DAT_i[23:16];
			
      if(FB_GPIO_OE_Reg_Wr_Dcd1 && WBs_BYTE_STB_i[3])
        GPIO_OE_o[31:24] <= WBs_DAT_i[31:24];
		
	    if(FB_GPIO_OE_Reg_Wr_Dcd2 && WBs_BYTE_STB_i[0]) 
        GPIO_OE_o[39:32] <= WBs_DAT_i[7:0]  ;
			
      if(FB_GPIO_OE_Reg_Wr_Dcd2 && WBs_BYTE_STB_i[1]) 
        GPIO_OE_o[45:40] <= WBs_DAT_i[13:8]  ;

      WBs_ACK_o <= WBs_ACK_o_nxt;
    end  
end

assign Device_ID_o	=  32'hce1a0001;
// Define the how to read the local registers and memory
//
always @(
         WBs_ADR_i         or
         Device_ID_o       or
         Mode_Sel_o		     or
         GPIO_IN_i         or
         GPIO_OUT_o        or
         GPIO_OE_o                
        )
 begin
    case(WBs_ADR_i[ADDRWIDTH-1:0])
      FPGA_REG_ID_VALUE_ADR     : WBs_DAT_o <= Device_ID_o;
      FPGA_MODE_SEL_ADR         : WBs_DAT_o <= {28'h0, Mode_Sel_o};  
      FPGA_GPIO_IN_REG_ADR1     : WBs_DAT_o <= GPIO_IN_i[31:0]; 
      FPGA_GPIO_IN_REG_ADR2     : WBs_DAT_o <= {18'h0, GPIO_IN_i[45:32]};
      FPGA_GPIO_OUT_REG_ADR1    : WBs_DAT_o <= GPIO_OUT_o[31:0];
      FPGA_GPIO_OUT_REG_ADR2    : WBs_DAT_o <= {18'h0, GPIO_OUT_o[45:32]};
      FPGA_GPIO_OE_REG_ADR1     : WBs_DAT_o <= GPIO_OE_o[31:0];
      FPGA_GPIO_OE_REG_ADR2     : WBs_DAT_o <= {18'h0, GPIO_OE_o[45:32]};
      default                   : WBs_DAT_o <= AL4S3B_DEF_REG_VALUE;
    endcase
end

endmodule
