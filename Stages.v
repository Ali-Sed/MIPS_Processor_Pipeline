


module IF_Stage(clk, rst, PC, Instruction);
	input clk , rst; 
	output reg [31:0] PC;
	output  [31:0] Instruction;

	always @(posedge clk) begin
		if (rst) begin
			// reset
			PC = 32'b0;
		end
		else begin
			PC <= PC + 4;
		end
	end

	Inst_mem Instruction_mem ( .Address ( PC) , .Inst_mem_out(Instruction));



endmodule

module IF_Stage_reg(clk, rst, PC_in, Instruction_in, PC, Instruction);
	input clk , rst ;
	input [31:0] PC_in , Instruction_in ;
	output reg [31:0] PC , Instruction;

	always @(posedge clk) begin
		if (rst)
		begin
			PC <=32'b0;
			Instruction <= 32'b0;
			end
		else 
		begin
			PC <= PC_in;
			Instruction <= Instruction_in;
			end

	end


endmodule

module ID_Stage(clk, rst, PC_in, PC , Instruction , Dest , Val1 , Val2 , Reg2 , EXE_CMD , MEM_R_EN , MEM_W_EN , WB_EN);
	input clk , rst ; 
	input [31:0] Instruction;
	input [31:0] PC_in;
	input WB_Write_Enable;
	input [4:0] WB_Dest;
	input[31:0] WB_Data;

	output IF_flush;
	output Br_taken;

	output MEM_W_EN , MEM_R_EN , WB_EN;
	output [4:0] Dest;
	output [31:0] Val1 , Val2 , Reg2;
	output [3:0] EXE_CMD;
	output [31:0] PC;

	wire [4:0] Reg1 , Reg2_local;
	wire [31:0] Sign_extend_out ;
	wire IS_IMM;

	Sign_extend Sign_extend_IF (.In (Instruction[15:0]) , .Out (Sign_extend_out))

	Mux2to1_32bit Mux_1 ( .In1 (Reg2_local ) , .In2 (Sign_extend_out), .Sel(IS_IMM) , .Out(Val2));
	Mux2to1_5bit Mux_2 ( .In1(Instruction[15:11]) , .In2 (Instruction[20:16]) , .Sel(IS_IMM) , .Out(Dest));

	Register_file RF ( .clk(clk) , .rst(rst) , .Src1(Instruction[25:21]) , .Src2(Instruction[20:16]) , .Dest(WB_Dest) , 
						.Write_Val(WB_Data) , .Write_EN(WB_Write_Enable) , .Reg1 (Val1), .Reg2(Reg2_local) );
	assign Val1 = Reg1;
	assign Reg2= Reg2_local ;

	assign PC = PC_in;

	
endmodule

module ID_Stage_reg(clk, rst, PC_in, PC , Flush , Br_taken_in , MEM_R_EN_in , MEM_W_EN_in , WB_EN_in,
						EXE_CMD_in , Dest_in , Reg2_in , Val1_in , Val2_in,
						Dest , Val1 , Val2 , Reg2 , Br_taken , MEM_R_EN , 
						MEM_W_EN , EXE_CMD);
	input clk , rst ;

	input Flush;
	input Br_taken_in , MEM_R_EN_in , MEM_W_EN_in , WB_EN_in ;
	input [3:0] EXE_CMD_in; 
	input [4:0] Dest_in ; 
	input [31:0] Reg2_in , Val1_in , Val2_in ; 
	input [31:0] PC_in;

	output reg [31:0] PC;
	output reg [4:0] Dest;
	output reg [31:0] Val1 , Val2 , Reg2;
	output reg Br_taken;
	output reg MEM_R_EN;
	output reg MEM_W_EN;
	output reg [3:0] EXE_CMD;


	always @(posedge clk) begin
		if (rst)
			PC <=32'b0;
		else 
			PC <= PC_in ; 
	end
	
endmodule

module EXE_Stage(clk, rst, PC_in, PC);
	input clk , rst ;
	input [31:0] PC_in;
	output [31:0] PC;

	assign PC = PC_in;

endmodule

module EXE_Stage_reg(clk, rst, PC_in, PC);
	input clk , rst ;
	input [31:0] PC_in;	
	output reg [31:0] PC;

	always @(posedge clk) begin
		if (rst)
			PC <=32'b0;
		else 
			PC <= PC_in;
	end

endmodule

module MEM_Stage(clk, rst, PC_in, PC);
	input clk , rst ;
	input [31:0] PC_in;
	output [31:0] PC;

	assign PC = PC_in;

endmodule

module MEM_Stage_reg(clk, rst, PC_in, PC);
	input clk , rst ;
	input [31:0] PC_in;
	output reg [31:0] PC;

	always @(posedge clk) begin
		if (rst)
			PC <=32'b0;
		else 
			PC <= PC_in;
	end

endmodule

module WB_Stage(clk, rst, PC_in, PC);
	input clk , rst ;
	input [31:0] PC_in;
	output [31:0] PC;

	assign PC = PC_in;

endmodule


