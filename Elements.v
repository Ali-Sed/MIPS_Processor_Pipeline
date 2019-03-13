module  Inst_mem ( Address , Inst_mem_out );

	reg [31:0] Inst_mem_data [0:1023];
	input [31:0] Address ;
	output [31:0] Inst_mem_out;

	assign Inst_mem_out = Inst_mem_data[Address];

	

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
			end
		37:begin
			EXE_CMD = 4'b0000; // ST
			MEM_R = 1;
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


