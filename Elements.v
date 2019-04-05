module  Inst_mem ( Address , Inst_mem_out );

	reg [31:0] Inst_mem_data [0:1023];
	input [31:0] Address ;
	output [31:0] Inst_mem_out;

initial begin
Inst_mem_data [0]=32'b0;
Inst_mem_data [1]=32'b10000000000000010000011000001010;//-- Addi r1 ,r0 ,1546 //r1=1546
Inst_mem_data [2]=32'b0;// NOP
Inst_mem_data [3]=32'b0; //NOP
Inst_mem_data [4]=32'b00000100000000010001000000000000;//-- Add r2 ,r0 ,r1//r2=1546
Inst_mem_data [5]=32'b00001100000000010001100000000000;//-- sub r3 ,r0 ,r1//r3=-1546
Inst_mem_data [6]=32'b0; //NOP
Inst_mem_data [7]=32'b0; //NOP
Inst_mem_data [8]=32'b00010100010000110010000000000000; //--and r4,r2,r3 //r4=2
Inst_mem_data [9]=32'b10000100011001010001101000110100; //--subi r5,r3,//r5=-8254
Inst_mem_data [10]=32'b0; //NOP
Inst_mem_data [11]=32'b0; //NOP
Inst_mem_data [12]=32'b00011000011001000010100000000000; //--or r5,r3,r4 //r5=-1546
Inst_mem_data [13]=32'b0; //NOP
Inst_mem_data [14]=32'b0; //NOP
Inst_mem_data [15]=32'b00011100101000000011000000000000; //--nor r6,r5,r0//r6=1545
Inst_mem_data [16]=32'b00011100100000000101100000000000; //--nor r11,r4,r0//r11=-3
Inst_mem_data [17]=32'b00001100101001010010100000000000; //--sub r5,r5,r5//r5=0
Inst_mem_data [18]=32'b10000000000000010000010000000000; //--addi r1,r0,1024 //r1=1024
Inst_mem_data [19]=32'b0; //NOP
Inst_mem_data [20]=32'b0; //NOP
Inst_mem_data [21]=32'b10010100001000100000000000000000;//-- st r2 ,r1 ,0 //
Inst_mem_data [22]=32'b0; //NOP
Inst_mem_data [23]=32'b0; //NOP
Inst_mem_data [24]=32'b10010000001001010000000000000000;//-- ld r5 ,r1 ,0 //r5=1546
Inst_mem_data [25]=32'b0; //NOP
Inst_mem_data [26]=32'b0; //NOP
Inst_mem_data [27]=32'b10100000101000000000000000000001;//-- Bez r5 ,1//not taken
Inst_mem_data [28]=32'b0; //NOP
Inst_mem_data [29]=32'b0; //NOP
Inst_mem_data [30]=32'b00100000101000010011100000000000;//-- xor r7 ,r5 ,r1 //r7=522
Inst_mem_data [31]=32'b00100000101000010000000000000000;//-- xor r0 ,r5 ,r1 //r0=0
Inst_mem_data [32]=32'b00100100011001000011100000000000;//-- sla r7 ,r3 ,r4//r7=-6184
Inst_mem_data [33]=32'b00101000011001000100000000000000;//-- sll r8 ,r3 ,r4 //r8=-6184
Inst_mem_data [34]=32'b00101100011001000100100000000000;//-- sra r9 ,r3 ,r4 //r9=1073741437
Inst_mem_data [35]=32'b00110000011001000101000000000000;//-- srl r10 ,r3 ,r4//r10=-384
Inst_mem_data [36]=32'b10010100001000110000000000000100;//-- st r3 ,r1 ,4
Inst_mem_data [37]=32'b10010100001001000000000000001000;//-- st r4 ,r1 ,8
Inst_mem_data [38]=32'b10010100001001010000000000001100;//-- st r5 ,r1 ,12
Inst_mem_data [39]=32'b10010100001001100000000000010000;//-- st r6 ,r1 ,16
Inst_mem_data [40]=32'b10010000001010110000000000000100;//-- ld r11 ,r1 ,4//r11=-1456
Inst_mem_data [41]=32'b10010100001010010000000000011100;//-- st r9 ,r1 ,28
Inst_mem_data [42]=32'b10010100001010100000000000100000;//-- st r10 ,r1 ,32
Inst_mem_data [43]=32'b10010100001010000000000000100100;//-- st r8 ,r1 ,36
Inst_mem_data [44]=32'b10010100001001110000000000010100;//-- st r7 ,r1 ,20
Inst_mem_data [45]=32'b10010100001010110000000000011000;//-- st r11 ,r1 ,24
Inst_mem_data [46]=32'b10000000000000010000000000000011;//-- Addi r1 ,r0 ,3 //r1=3
Inst_mem_data [47]=32'b10000000000000110000000000000001;//-- Addi r3 ,r0 ,1 //r3=1
Inst_mem_data [48]=32'b10000000000010010000000000000010;//-- Addi r9 ,r0 ,2 //r9=2
Inst_mem_data [49]=32'b10000000000001000000010000000000;//-- Addi r4 ,r0 ,1024 //r4=1024
Inst_mem_data [50]=32'b10000000000000100000000000000000;//-- Addi r2 ,r0 ,0 //r2=0
Inst_mem_data [51]=32'b00101000011010010100000000000000;//-- sll r8 ,r3 ,r9 //r8=r3*4
Inst_mem_data [52]=32'b0; //NOP
Inst_mem_data [53]=32'b0; //NOP
Inst_mem_data [54]=32'b00000100100010000100000000000000;//-- Add r8 ,r4 ,r8 //r8=1024+r3*4
Inst_mem_data [55]=32'b0; //NOP
Inst_mem_data [56]=32'b0; //NOP
Inst_mem_data [57]=32'b10010001000001010000000000000000;//-- ld r5 ,r8 ,0 //
Inst_mem_data [58]=32'b10010001000001101111111111111100;//-- ld r6 ,r8 ,-4 //
Inst_mem_data [59]=32'b0; //NOP
Inst_mem_data [60]=32'b0; //NOP
Inst_mem_data [61]=32'b00001100101001100100100000000000;//-- sub r9 ,r5 ,r6
Inst_mem_data [62]=32'b10000000000010101000000000000000;//-- Addi r10 ,r0 ,0x8000
Inst_mem_data [63]=32'b10000000000010110000000000010000;//-- Addi r11 ,r0 ,16 //2
Inst_mem_data [64]=32'b0; //NOP
Inst_mem_data [65]=32'b0; //NOP
Inst_mem_data [66]=32'b00101001010010110101000000000000;//-- sll r10 ,r1 ,r11 //2
Inst_mem_data [67]=32'b0; //NOP
Inst_mem_data [68]=32'b0; //NOP
Inst_mem_data [69]=32'b00010101001010100100100000000000;//-- And r9 ,r9 ,r10 // if(r5>r6) r9=0 else r9=-2147483648
Inst_mem_data [70]=32'b0; //NOP
Inst_mem_data [71]=32'b0; //NOP
Inst_mem_data [72]=32'b10100001001000000000000000000010;//-- Bez r9 ,2
Inst_mem_data [73]=32'b0; //NOP
Inst_mem_data [74]=32'b0; //NOP
Inst_mem_data [75]=32'b10010101000001011111111111111100;//-- st r5 ,r8 ,-4
Inst_mem_data [76]=32'b10010101000001100000000000000000;//-- st r6 ,r8 ,0
Inst_mem_data [77]=32'b10000000011000110000000000000001;//-- Addi r3 ,r3 ,1 //2
Inst_mem_data [78]=32'b0; //NOP
Inst_mem_data [79]=32'b0; //NOP
Inst_mem_data [80]=32'b10100100001000111111111111110001;//-- BNE r1 ,r3 ,-15
Inst_mem_data [81]=32'b0; //NOP
Inst_mem_data [82]=32'b0; //NOP
Inst_mem_data [83]=32'b10000000010000100000000000000001;//-- Addi r2 ,r2 ,1 //2
Inst_mem_data [84]=32'b0; //NOP
Inst_mem_data [85]=32'b0; //NOP
Inst_mem_data [86]=32'b10100100001000101111111111101110;//-- BNE r1 ,r2 ,-18
Inst_mem_data [87]=32'b0; //NOP
Inst_mem_data [88]=32'b0; //NOP
Inst_mem_data [89]=32'b10000000000000010000010000000000;//-- Addi r1 ,r0 ,1024 //r1=1024
Inst_mem_data [90]=32'b0; //NOP
Inst_mem_data [91]=32'b0; //NOP
Inst_mem_data [92]=32'b10010000001000100000000000000000;//-- ld ,r2 ,r1 ,0 //r2=-1546
Inst_mem_data [93]=32'b10010000001000110000000000000100;//-- ld ,r3 ,r1 ,4 //r3=2
Inst_mem_data [94]=32'b10010000001001000000000000001000;//-- ld ,r4 ,r1 ,8 //r4=1546
Inst_mem_data [95]=32'b10010000001001000000001000001000;//-- ld ,r4 ,r1 ,520 // after SRAM r4=random number
Inst_mem_data [96]=32'b10010000001001000000010000001000;//-- ld ,r4 ,r1 ,1023 // after SRAM r4=random number
Inst_mem_data [97]=32'b10010000001001010000000000001100;//-- ld ,r5 ,r1 ,12 // r5=1546
Inst_mem_data [98]=32'b10010000001001100000000000010000;//-- ld ,r6 ,r1 ,16 //r6=1545
Inst_mem_data [99]=32'b10010000001001110000000000010100;//-- ld ,r7 ,r1 ,20 //r7=-6184
Inst_mem_data [100]=32'b10010000001010000000000000011000;//-- ld ,r8 ,r1 ,24 //r8=-1546
Inst_mem_data [101]=32'b10010000001010010000000000011100;//-- ld ,r9 ,r1 ,28 //r9=1073741437
Inst_mem_data [102]=32'b10010000001010100000000000100000;//-- ld ,r10,r1 ,32 //r10=-387
Inst_mem_data [103]=32'b10010000001010110000000000100100;//-- ld ,r11,r1 ,36 //r11=-6184
Inst_mem_data [104]=32'b10101000000000001111111111111111;//-- JMP -1*/
Inst_mem_data [105]=32'b0; //NOP
Inst_mem_data [106]=32'b0; //NOP



end

	assign Inst_mem_out = Inst_mem_data[Address>>2];

endmodule



module PC_inc ( PC , PC_inc_out);
	input [31:0] PC;
	output [31:0] PC_inc_out;

	assign PC_inc_out = PC + 4;

endmodule	

module PC_reg (clk , rst , PC , PC_out);

	input clk ,rst;
	input [31:0] PC;
	output reg [31:0] PC_out;

	always @(posedge clk) begin
		if (rst)
			PC_out <=32'b0;
		else 
			PC_out <= PC;
	end
endmodule

module Mux2to1_5bit ( In1 , In2 , Sel , Out);
	//parameter DATA_WIDTH = 32;
	input [4:0] In1 , In2;
	input Sel;
	output [4:0] Out;

	assign Out = (Sel == 1'b0) ? In1 : (Sel == 1'b1)? In2 : 5'bZ;

endmodule

module Mux2to1_32bit ( In1 , In2 , Sel , Out);
	//parameter DATA_WIDTH = 32;
	input [31:0] In1 , In2;
	input Sel;
	output [31:0] Out;

	assign Out = (Sel == 1'b0) ? In1 : (Sel == 1'b1)? In2 : 31'bZ;

endmodule



module Sign_extend ( In , Out);
	
	input [15:0] In;
	output reg [31:0] Out;
	integer i;
	always @ (*)
	begin 
		for ( i=16 ; i<32 ; i = i+1 )
		begin 
			Out [i] = In[15];
			Out [i-16] = In[i-16];
		end
	end

endmodule


module Control_unit (Opcode , IS_IMM , EXE_CMD , WB_EN , MEM_R , MEM_W, BR_type);

	input [5:0] Opcode;
	output reg IS_IMM, WB_EN , MEM_R , MEM_W;
	output reg [1:0] BR_type ;
	output reg [3:0] EXE_CMD;

	always @ (*)
	begin 
		{WB_EN , MEM_R , MEM_W , IS_IMM} = 4'b0000;
		BR_type = 2'b0;
		EXE_CMD = 4'b0000;
		case (Opcode)
		0: begin 
			EXE_CMD = 4'bXXXX; //DC
			end

		1: begin 
			EXE_CMD = 4'b0000; // ADD
			WB_EN = 1;
			end
		3: begin
			EXE_CMD = 4'b0010; // SUB
			WB_EN = 1;
			
			end		 
		5:begin 

			EXE_CMD = 4'b0100; // AND
			WB_EN = 1;
			end
		6: begin 
			EXE_CMD = 4'b0101; // OR
			WB_EN = 1;
			end
		7: begin

			
			EXE_CMD = 4'b0110; //NOR
			WB_EN = 1;
			end

		8: begin
			EXE_CMD = 4'b0111; // Xor
			WB_EN = 1;
			end

		9:begin
			
			EXE_CMD = 4'b1000; //SLA
		 	WB_EN = 1;
			end

		10:begin 
			EXE_CMD = 4'b1000; //SLL
			WB_EN = 1;
			end

		11: begin
			EXE_CMD = 4'b1001; //SRA
			WB_EN = 1;
			end
		12:begin
			
			EXE_CMD = 4'b1010; // SRL
			WB_EN = 1;
			end

		32:begin
			EXE_CMD = 4'b0000; //ADDI
			WB_EN = 1;
			IS_IMM = 1;
			end
		33:begin 
			EXE_CMD = 4'b0010; //SUBI
			WB_EN = 1;
			IS_IMM = 1;
			end
		36:begin 
			EXE_CMD = 4'b0000; // LD
			MEM_R = 1;
			IS_IMM =1 ;
			WB_EN =1;
			end
		37:begin
			EXE_CMD = 4'b0000; // ST
			MEM_W = 1;
			IS_IMM = 1;
			end

		40:begin 
			EXE_CMD = 4'bXXXX;
			IS_IMM = 1;
			BR_type =2'b01;
			end
		41:begin
			EXE_CMD = 4'bXXXX;
			IS_IMM = 1;
			BR_type = 2'b10;
		end

		42:begin
			EXE_CMD = 4'bXXXX;
			IS_IMM = 1 ;
			BR_type = 2'b11;
		end
		endcase
	end
endmodule


module ALU(Val1, Val2, EXE_CMD, ALU_result);
  
  input [31:0] Val1, Val2;
  input [3:0] EXE_CMD;
  output reg [31:0]ALU_result;
  
  always @(*) begin
		ALU_result = 32'b0;
		case (EXE_CMD)
		4'b0000: begin 
			ALU_result = Val1 + Val2;//ADD
			end

		4'b0010: begin 
			ALU_result = Val1 - Val2; // SUB
			
			end
		4'b0100: begin
			ALU_result = Val1 & Val2; 
			
			end		 
		4'b0101:begin 

			ALU_result = Val1 | Val2;
			end
		4'b0110: begin 
			ALU_result = ~(Val1 | Val2);
			end
		4'b0111: begin

			ALU_result = Val1 ^ Val2;
			end

		4'b1000: begin
			ALU_result = Val1 << Val2;
			end

		4'b1001:begin
			
			ALU_result = Val1 >>> Val2;
			end

		4'b1010:begin 
			ALU_result = Val1 >> Val2;
			end


		endcase
	end
    
endmodule

