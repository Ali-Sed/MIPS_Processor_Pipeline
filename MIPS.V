// ============================================================================
// Copyright (c) 2012 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//
// Major Functions:	DE2 TOP LEVEL
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Chen       :| 05/08/19  :|      Initial Revision
//   V1.1 :| Johnny Chen       :| 05/11/16  :|      Added FLASH Address FL_ADDR[21:20]
//   V1.2 :| Johnny Chen       :| 05/11/16  :|		Fixed ISP1362 INT/DREQ Pin Direction.   
//   V1.3 :| Johnny Chen       :| 06/11/16  :|		Added the Dedicated TV Decoder Line-Locked-Clock Input
//													            for DE2 v2.X PCB.
//   V1.5 :| Eko    Yan        :| 12/01/30  :|      Update to version 11.1 sp1.
// ============================================================================



//module B2Seven ( Bin , Hex);
//	input [3:0] Bin;
//	output reg [7:0] Hex;
//	always @(*)
//	begin
//		case ( Bin)
//		4'd0: Hex = 7'b1000000;
//		4'd4: Hex = 7'b0011001;
//		4'd8: Hex = 7'b0000000;
//		4'd12: Hex = 7'b1000110;
//		endcase
//	end
//endmodule

module MIPS
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		//UART_TXD,						//	UART Transmitter
		//UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		//IRDA_TXD,						//	IRDA Transmitter
		//IRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask 
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 0
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask 
		SRAM_LB_N,						//	SRAM Low-byte Data Mask 
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_DATA,						//	ISP1362 Data bus 16 Bits
		OTG_ADDR,						//	ISP1362 Address 2 Bits
		OTG_CS_N,						//	ISP1362 Chip Select
		OTG_RD_N,						//	ISP1362 Write
		OTG_WR_N,						//	ISP1362 Read
		OTG_RST_N,						//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		OTG_INT0,						//	ISP1362 Interrupt 0
		OTG_INT1,						//	ISP1362 Interrupt 1
		OTG_DREQ0,						//	ISP1362 DMA Request 0
		OTG_DREQ1,						//	ISP1362 DMA Request 1
		OTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		OTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		//SD_DAT,							//	SD Card Data
		//SD_WP_N,						   //	SD Write protect 
		//SD_CMD,							//	SD Card Command Signal
		//SD_CLK,							//	SD Card Clock
		////////////////////	USB JTAG link	////////////////////
		TDI,  							// CPLD -> FPGA (data in)
		TCK,  							// CPLD -> FPGA (clk)
		TCS,  							// CPLD -> FPGA (CS)
	   TDO,  							// FPGA -> CPLD (data out)
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_DAT,						//	PS2 Data
		PS2_CLK,						//	PS2 Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_DATA,						//	DM9000A DATA bus 16Bits
		ENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		ENET_CS_N,						//	DM9000A Chip Select
		ENET_WR_N,						//	DM9000A Write
		ENET_RD_N,						//	DM9000A Read
		ENET_RST_N,						//	DM9000A Reset
		ENET_INT,						//	DM9000A Interrupt
		ENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,						//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		AUD_DACDAT,						//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		AUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		TD_DATA,    					//	TV Decoder Data bus 8 bits
		TD_HS,							//	TV Decoder H_SYNC
		TD_VS,							//	TV Decoder V_SYNC
		TD_RESET,						//	TV Decoder Reset
		TD_CLK27,                  //	TV Decoder 27MHz CLK
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0
		GPIO_1							//	GPIO Connection 1
	);

////////////////////////	Clock Input	 	////////////////////////
input		   	CLOCK_27;				//	27 MHz
input		   	CLOCK_50;				//	50 MHz
input			   EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	   [3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	  [17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output  [17:0]	LEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
//output			UART_TXD;				//	UART Transmitter
//input			   UART_RXD;				//	UART Receiver
////////////////////////////	IRDA	////////////////////////////
//output			IRDA_TXD;				//	IRDA Transmitter
//input			   IRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	  [15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output  [11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask 
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 0
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	  [7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
output [21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	 [15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
output [17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
output			SRAM_UB_N;				//	SRAM High-byte Data Mask 
output			SRAM_LB_N;				//	SRAM Low-byte Data Mask 
output			SRAM_WE_N;				//	SRAM Write Enable
output			SRAM_CE_N;				//	SRAM Chip Enable
output			SRAM_OE_N;				//	SRAM Output Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	 [15:0]	OTG_DATA;				//	ISP1362 Data bus 16 Bits
output  [1:0]	OTG_ADDR;				//	ISP1362 Address 2 Bits
output			OTG_CS_N;				//	ISP1362 Chip Select
output			OTG_RD_N;				//	ISP1362 Write
output			OTG_WR_N;				//	ISP1362 Read
output			OTG_RST_N;				//	ISP1362 Reset
output			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
output			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			   OTG_INT0;				//	ISP1362 Interrupt 0
input			   OTG_INT1;				//	ISP1362 Interrupt 1
input			   OTG_DREQ0;				//	ISP1362 DMA Request 0
input			   OTG_DREQ1;				//	ISP1362 DMA Request 1
output			OTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			OTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	  [7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
//inout	 [3:0]	SD_DAT;					//	SD Card Data
//input			   SD_WP_N;				   //	SD write protect
//inout			   SD_CMD;					//	SD Card Command Signal
//output			SD_CLK;					//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			   I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
input		 	   PS2_DAT;				//	PS2 Data
input			   PS2_CLK;				//	PS2 Clock
////////////////////	USB JTAG link	////////////////////////////
input  			TDI;					// CPLD -> FPGA (data in)
input  			TCK;					// CPLD -> FPGA (clk)
input  			TCS;					// CPLD -> FPGA (CS)
output 			TDO;					// FPGA -> CPLD (data out)
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_DATA;				//	DM9000A DATA bus 16Bits
output			ENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			ENET_CS_N;				//	DM9000A Chip Select
output			ENET_WR_N;				//	DM9000A Write
output			ENET_RD_N;				//	DM9000A Read
output			ENET_RST_N;				//	DM9000A Reset
input			   ENET_INT;				//	DM9000A Interrupt
output			ENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			   AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			   AUD_ADCDAT;				//	Audio CODEC ADC Data
inout			   AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			AUD_DACDAT;				//	Audio CODEC DAC Data
inout			   AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			AUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input	 [7:0]	TD_DATA;    			//	TV Decoder Data bus 8 bits
input			   TD_HS;					//	TV Decoder H_SYNC
input			   TD_VS;					//	TV Decoder V_SYNC
output			TD_RESET;				//	TV Decoder Reset
input          TD_CLK27;            //	TV Decoder 27MHz CLK
////////////////////////	GPIO	////////////////////////////////
inout	[35:0]	GPIO_0;					//	GPIO Connection 0
inout	[35:0]	GPIO_1;					//	GPIO Connection 1

wire [31:0] PC_IF , PC_ID , PC_EXE , PC_MEM , PC_WB;
wire [31:0] Inst_IF , Inst_ID;
wire [4:0] Dest_ID  , Dest_EXE , Dest_WB , Dest_MEM;
wire [4:0] WB_DEST;

wire[31:0] PC_IFF , PC_IDD , PC_EXEE , PC_MEMM , PC_WBB;
wire [31:0] Val1_ID , Val2_ID , Reg2_ID ;
wire [3:0] EXE_CMD_ID;
wire MEM_R_EN_ID , MEM_W_EN_ID , WB_EN_ID ;

wire[31:0] Val1_EXE , Val2_EXE, Write_value;

wire [31:0] Reg2_EXE, ALU_result, Br_address, ALU_result_MEM, ST_value, MEM_read , ALU_result_WB, MEM_read_WB;

wire [3:0] EXE_CMD_EXE;
wire Flush_ID , Flush_EXE , Br_taken;
wire [1:0]Br_type_ID , Br_type_EXE;
wire WB_EN_WB, MEM_R_EN_WB;


//hazard
wire [4:0] Src2_EXE, Src1_EXE;
wire [1:0] Forward_Val1, Forward_Val2;
wire [31:0] Val1_EXE_Forwarded,Val2_EXE_Forwarded, Reg2_EXE_Forwarded, Val2_EXE_Forwarded2;
wire Hazard_Detected_Sig, WB_EN_ID_H , MEM_R_EN_ID_H , MEM_W_EN_ID_H;
wire [3:0] EXE_CMD_ID_H ;
wire [1:0] Br_type_ID_H;
wire Freeze;
wire Forward_Dest_EN_ID, Forward_Dest_EN_EXE;
wire IS_IMM_H, IS_IMM_EXE;

//hazard
wire MEM_R_EN_EXE , MEM_W_EN_EXE , WB_EN_EXE ;  


IF_Stage IF_1 (.clk (CLOCK_50) , .rst(SW[17]) , .Br_taken(Br_taken), .Br_Addr(Br_address), .PC(PC_IFF) , .Instruction(Inst_IF) , .Freeze(Freeze));
IF_Stage_reg IF_reg_1 (.clk(CLOCK_50), .rst(SW[17]), .PC_in(PC_IFF), .Flush(Br_taken), .Instruction_in(Inst_IF), .PC(PC_ID), .Instruction(Inst_ID) , .Freeze(Freeze));

// WB_DATA and WB_Write_EN are not connected
ID_Stage ID_1 (.clk (CLOCK_50) , .rst(SW[17]), .PC_in(PC_ID), .PC(PC_IDD) , .Instruction(Inst_ID ) ,.WB_Write_Enable(WB_EN), .WB_Data(Write_value), .Dest (Dest_ID) , .Val1 (Val1_ID) , .Val2 (Val2_ID) , .Reg2(Reg2_ID)  , .WB_Dest(WB_DEST)  
	, .EXE_CMD (EXE_CMD_ID), .MEM_W_EN(MEM_W_EN_ID) , .MEM_R_EN( MEM_R_EN_ID) , .WB_EN(WB_EN_ID), .Br_type(Br_type_ID) , .Forward_Dest_EN(Forward_Dest_EN_ID) , .IS_IMM_H(IS_IMM_H));

ID_Stage_reg ID_reg_1 (.clk (CLOCK_50) , .rst(SW[17]), .PC_in(PC_IDD), .PC(PC_EXE) , .Flush(Br_taken)  , .MEM_R_EN_in(MEM_R_EN_ID_H) , .MEM_W_EN_in(MEM_W_EN_ID_H) , .WB_EN_in(WB_EN_ID_H),
						.EXE_CMD_in(EXE_CMD_ID_H) , .Dest_in(Dest_ID) , .Reg2_in(Reg2_ID) , .Val1_in(Val1_ID) , .Val2_in(Val2_ID),
						.Dest(Dest_EXE) , .Val1(Val1_EXE) , .Val2(Val2_EXE) , .Reg2(Reg2_EXE) , .MEM_R_EN(MEM_R_EN_EXE) , 
						.MEM_W_EN(MEM_W_EN_EXE) , .EXE_CMD(EXE_CMD_EXE) , .WB_EN(WB_EN_EXE), .Br_type(Br_type_EXE) , .Br_type_in (Br_type_ID_H),
						.Src1_ID(Inst_ID[25:21]), .Src2_ID(Inst_ID[20:16]), .Src1_EXE(Src1_EXE), .Src2_EXE(Src2_EXE), .IS_IMM_H(IS_IMM_H),
						.Forward_Dest_EN_in(Forward_Dest_EN_ID), .Forward_Dest_EN(Forward_Dest_EN_EXE), .IS_IMM_EXE(IS_IMM_EXE));



EXE_Stage EXE_1 (.clk (CLOCK_50) , .rst(SW[17]), .PC(PC_EXE),  .EXE_CMD(EXE_CMD_EXE) , .Val1(Val1_EXE_Forwarded) , .Val2(Val2_EXE_Forwarded2),  .Val2_IMM(Val2_EXE) , .Val_src2(Reg2_EXE_Forwarded) , .Br_type(Br_type_EXE) , .ALU_result(ALU_result) , .Br_Addr(Br_address) , .Br_taken(Br_taken) );
EXE_Stage_reg EXE_reg_1(.clk (CLOCK_50) , .rst(SW[17]), .PC_in(PC_EXEE), .PC(PC_MEM) ,  .Dest_in(Dest_EXE), .Dest(Dest_MEM), .WB_EN_in(WB_EN_EXE) , .MEM_R_EN_in(MEM_R_EN_EXE) , .MEM_W_EN_in(MEM_W_EN_EXE) , .ALU_result_in(ALU_result) , .ST_val_in(Reg2_EXE_Forwarded) , .WB_EN(WB_EN_MEM) , .MEM_R_EN(MEM_R_EN_MEM) , .MEM_W_EN(MEM_W_EN_MEM) , .ALU_result(ALU_result_MEM) , .ST_val(ST_value)  );


MEM_Stage MEM_1 (.clk (CLOCK_50) , .rst(SW[17]), .PC_in(PC_MEM), .PC(PC_MEMM),.MEM_W_EN_in(MEM_W_EN_MEM) , .MEM_R_EN_in(MEM_R_EN_MEM), .ALU_result_in(ALU_result_MEM) , .ST_val(ST_value) , .MEM_read_value(MEM_read));
MEM_Stage_reg MEM_reg_1(.clk (CLOCK_50) , .rst(SW[17]), .PC_in(PC_MEMM), .PC(PC_WB) , .Dest_in(Dest_MEM), .Dest(WB_DEST), .WB_EN_in(WB_EN_MEM) , .MEM_R_EN_in(MEM_R_EN_MEM) , .ALU_result_in(ALU_result_MEM) , .MEM_read_value_in(MEM_read) , .WB_EN(WB_EN_WB) , .MEM_R_EN(MEM_R_EN_WB) ,
					 .ALU_result(ALU_result_WB) , .MEM_read_value(MEM_read_WB) );

WB_Stage WB_1 (.clk (CLOCK_50) , .rst(SW[17]), .PC_in(PC_WB), .PC(PC_WBB), .WB_EN_in(WB_EN_WB) , .MEM_R_EN(MEM_R_EN_WB) , .ALU_result(ALU_result_WB) , .MEM_read_value(MEM_read_WB) , .Dest_in(WB_DEST) , .Write_value(Write_value) , .Dest(WB_dest) , .WB_EN(WB_EN));

//hazard
 
Forwarding_MUX  Forwarding_Val1(.Val(Val1_EXE),.Result_WB(Write_value),.ALU_result_MEM(ALU_result_MEM),.Forward_Val(Forward_Val1),.O(Val1_EXE_Forwarded));
Forwarding_MUX  Forwarding_Val2(.Val(Val2_EXE),.Result_WB(Write_value),.ALU_result_MEM(ALU_result_MEM),.Forward_Val(Forward_Val2),.O(Val2_EXE_Forwarded));
Forwarding_MUX  Forwarding_Val3(.Val(Reg2_EXE),.Result_WB(Write_value),.ALU_result_MEM(ALU_result_MEM),.Forward_Val(Forward_Val2),.O(Reg2_EXE_Forwarded));

IMM_MUX IMM(.Val2_Forwarded(Val2_EXE_Forwarded), .Val2(Val2_EXE), .IS_IMM(IS_IMM_EXE),.O(Val2_EXE_Forwarded2));
 
Forwarding_Unit FU_1(.Dest_MEM(Dest_MEM), .Dest_EXE(Dest_EXE), .Forward_Dest_EN(Forward_Dest_EN_EXE), .Dest_WB(WB_DEST), .WB_EN_MEM(WB_EN_MEM), .WB_EN_WB(WB_EN_WB), .Src1_EXE(Src1_EXE), .Src2_EXE(Src2_EXE), .Forward_Val1(Forward_Val1), .Forward_Val2(Forward_Val2) , .EN(SW[3]));
Hazard_Detector HD1(.Src1(Inst_ID[25:21]) , .Src2(Inst_ID[20:16]) , .EXE_Dest(Dest_EXE) , .EXE_WB_EN(WB_EN_EXE) , .MEM_Dest(Dest_MEM) , .MEM_WB_EN(WB_EN_MEM) , .Freeze(Freeze) , .Hazard_Detected_Sig(Hazard_Detected_Sig) ,.MEM_R_EN(MEM_R_EN_EXE), .EN(SW[3]));

Hazard_MUX    	HM1(.in1(WB_EN_ID) , .in2(MEM_R_EN_ID) , .in3(MEM_W_EN_ID) , .in4(Br_type_ID) , .in5(EXE_CMD_ID) , .Sel(Hazard_Detected_Sig) , .WB_EN(WB_EN_ID_H) , .MEM_R(MEM_R_EN_ID_H) , .MEM_W(MEM_W_EN_ID_H) , .BR_type(Br_type_ID_H) , .EXE_CMD(EXE_CMD_ID_H) );

//end of hazard



//B2Seven A1(PC_ID[3:0] , HEX0 );
//B2Seven A2(PC_EXE[3:0] , HEX1);
//B2Seven A3(PC_MEM[3:0] , HEX2 );
//B2Seven A4(PC_WB[3:0] , HEX3 );
// (PC_IF[3:0] , HEX0 );

	
endmodule
