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
						 	 
                         C1_out_64,
                         C2_out_64
                         );


//------Port Parameters----------------
//

parameter            ADDRWIDTH                   =   7  ;   // Allow for up to 128 registers in the FPGA
parameter            DATAWIDTH                   =  32  ;   // Allow for up to 128 registers in the FPGA

parameter      			 FPGA_REG_ID_VALUE_ADR     	 =  7'h0; 
parameter      			 FPGA_REV_NUM_ADR          	 =  7'h1; 
parameter      			 FPGA_MULT_VALID_ADR  	     =  7'h2; 
parameter      			 FPGA_MULT1_A_IN_ADR       	 =  7'h4;
parameter      			 FPGA_MULT1_B_IN_ADR      	 =  7'h5; 
parameter      			 FPGA_MULT1_C_OUT_L_ADR    	 =  7'h6;
parameter      			 FPGA_MULT1_C_OUT_H_ADR      =  7'h7;
parameter      			 FPGA_MULT2_A_IN_ADR       	 =  7'h8;
parameter      			 FPGA_MULT2_B_IN_ADR      	 =  7'h9; 
parameter      			 FPGA_MULT2_C_OUT_L_ADR    	 =  7'ha;
parameter      			 FPGA_MULT2_C_OUT_H_ADR      =  7'hb;

parameter            AL4S3B_DEVICE_ID            = 16'h0;
parameter            AL4S3B_REV_LEVEL            = 32'h0;

parameter            AL4S3B_DEF_REG_VALUE        = 32'hFAB_DEF_AC;


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
output           [31:0]  Device_ID_o;

output                   C1_out_64;
output                   C2_out_64;


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
wire               [31:0]  Device_ID_o   ;
wire               [15:0]  Rev_No        ;


//------Define Parameters--------------
//

//
// None at this time
//

//------Internal Signals---------------
//
wire     FPGA_MULT_VALID_Dcd;
wire     FPGA_MULT1_A_IN_Dcd;
wire     FPGA_MULT1_B_IN_Dcd;
wire     FPGA_MULT2_A_IN_Dcd;
wire     FPGA_MULT2_B_IN_Dcd;

wire		 WBs_ACK_o_nxt;

reg        valid1;
reg        valid2;
reg [31:0] A1_in_r;
reg [31:0] B1_in_r;
reg [31:0] A2_in_r;
reg [31:0] B2_in_r;

wire [63:0] C1_out;
wire [63:0] C2_out;

//------Logic Operations---------------
//
assign C1_out_64 = C1_out[63];
assign C2_out_64 = C2_out[63];
// Define the FPGA's local register write enables
//
assign FPGA_MULT_VALID_Dcd = (WBs_ADR_i == FPGA_MULT_VALID_ADR) & WBs_CYC_i & WBs_STB_i & WBs_WE_i & (~WBs_ACK_o);
assign FPGA_MULT1_A_IN_Dcd = (WBs_ADR_i == FPGA_MULT1_A_IN_ADR) & WBs_CYC_i & WBs_STB_i & WBs_WE_i & (~WBs_ACK_o);
assign FPGA_MULT1_B_IN_Dcd = (WBs_ADR_i == FPGA_MULT1_B_IN_ADR) & WBs_CYC_i & WBs_STB_i & WBs_WE_i & (~WBs_ACK_o);
assign FPGA_MULT2_A_IN_Dcd = (WBs_ADR_i == FPGA_MULT2_A_IN_ADR) & WBs_CYC_i & WBs_STB_i & WBs_WE_i & (~WBs_ACK_o);
assign FPGA_MULT2_B_IN_Dcd = (WBs_ADR_i == FPGA_MULT2_B_IN_ADR) & WBs_CYC_i & WBs_STB_i & WBs_WE_i & (~WBs_ACK_o);

// Define the Acknowledge back to the host for registers
//
assign WBs_ACK_o_nxt  =   WBs_CYC_i & WBs_STB_i & (~WBs_ACK_o);

// Define the FPGA's Local Registers
//
always @( posedge WBs_CLK_i or posedge WBs_RST_i)
begin
    if (WBs_RST_i)
    begin
      valid1   <= 1'b0; 
      valid2   <= 1'b0;
      A1_in_r  <= 32'h0;
      A2_in_r  <= 32'h0;
      B1_in_r  <= 32'h0;
      B2_in_r  <= 32'h0;
    end  
    else
    begin
      if(FPGA_MULT_VALID_Dcd && WBs_BYTE_STB_i[0]) begin
        valid1 <= WBs_DAT_i[0];
        valid2 <= WBs_DAT_i[1];
      end
      
      if(FPGA_MULT1_A_IN_Dcd) 
        A1_in_r <= WBs_DAT_i[31:0];
        
      if(FPGA_MULT1_B_IN_Dcd) 
        B1_in_r <= WBs_DAT_i[31:0];
        
      if(FPGA_MULT2_A_IN_Dcd) 
        A2_in_r <= WBs_DAT_i[31:0];
        
      if(FPGA_MULT2_B_IN_Dcd) 
        B2_in_r <= WBs_DAT_i[31:0];
      
      WBs_ACK_o   <=  WBs_ACK_o_nxt  ;
    end  
end

qlal4s3_mult_32x32_cell mul0 (
        .Amult(A1_in_r),
        .Bmult(B1_in_r),
        .Valid_mult(valid1),
        .Cmult(C1_out)
    );
    
qlal4s3_mult_32x32_cell mul1 (
        .Amult(A2_in_r),
        .Bmult(B2_in_r),
        .Valid_mult(valid2),
        .Cmult(C2_out)
    );


// Define the how to read the local registers and memory
//
assign Device_ID_o = 32'h12343232;
assign Rev_No = 16'h100 ;
always @(
         WBs_ADR_i         or
         Device_ID_o       or
         Rev_No  		       or
         valid1            or
         valid2            or
         A1_in_r           or
		     B1_in_r           or
         C1_out            or
         A2_in_r           or
		     B2_in_r           or
         C2_out                            
 )
 begin
    case(WBs_ADR_i[ADDRWIDTH-1:0])
      FPGA_REG_ID_VALUE_ADR     : WBs_DAT_o <= Device_ID_o;
      FPGA_REV_NUM_ADR          : WBs_DAT_o <= { 16'h0, Rev_No };  
      FPGA_MULT_VALID_ADR       : WBs_DAT_o <= { 30'h0,valid2,valid1};
      FPGA_MULT1_A_IN_ADR       : WBs_DAT_o <= A1_in_r;
      FPGA_MULT1_B_IN_ADR       : WBs_DAT_o <= B1_in_r; 
      FPGA_MULT1_C_OUT_L_ADR    : WBs_DAT_o <= C1_out[31:0];
      FPGA_MULT1_C_OUT_H_ADR    : WBs_DAT_o <= C1_out[63:32];
      FPGA_MULT2_A_IN_ADR       : WBs_DAT_o <= A2_in_r;
      FPGA_MULT2_B_IN_ADR       : WBs_DAT_o <= B2_in_r; 
      FPGA_MULT2_C_OUT_L_ADR    : WBs_DAT_o <= C2_out[31:0];
      FPGA_MULT2_C_OUT_H_ADR    : WBs_DAT_o <= C2_out[63:32];
      default                   : WBs_DAT_o <= AL4S3B_DEF_REG_VALUE;
    endcase
end

endmodule
