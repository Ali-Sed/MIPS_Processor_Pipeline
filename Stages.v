


module IF_Stage(clk, rst, Br_taken, Br_Addr, PC, Instruction , Freeze);
	input clk , rst , Freeze; 
	input Br_taken;
	input [31:0] Br_Addr;
	output [31:0] PC;
	output  [31:0] Instruction;
	
	reg [31:0] Mux2PC, PCtemp;

	always @(posedge clk, posedge rst) begin
		if (rst) begin
			// reset
			PCtemp <= 32'b0;
			//PC <= 32'b0;
		end
		else if (Freeze)
			PCtemp <= PCtemp;
		else begin
			PCtemp <= Mux2PC;
			//PC <= PC + 4;
		end
	end
	
	always @(*) begin
	  
	  Mux2PC = Br_taken?Br_Addr:PCtemp + 4; 
	  //PC = PCtemp + 1;
	  //Mux2PC = Br_taken?Br_Addr:PCtemp + 1; 
	
	end
	
	assign PC = PCtemp + 4;
	
	Inst_mem Instruction_mem ( .Address ( PCtemp) , .Inst_mem_out(Instruction)); 
  
endmodule


module IF_Stage_reg(clk, rst, PC_in, Flush, Instruction_in, PC, Instruction , Freeze);
	input clk , rst, Flush, Freeze;
	input [31:0] PC_in , Instruction_in ;
	output reg [31:0] PC , Instruction;

	always @(posedge clk) begin
		if (rst | Flush)
		begin
			PC <=32'b0;
			Instruction <= 32'b0;
			end
		else if(Freeze)
		begin
			PC <= PC;
			Instruction <= Instruction;
		end
		else 
		begin
			PC <= PC_in;
			Instruction <= Instruction_in;
			end

	end


endmodule

module ID_Stage(clk, rst, PC_in, PC , WB_Dest ,WB_Write_Enable , WB_Data, Instruction , Dest , Val1 , Val2 , Reg2 , 
				EXE_CMD , MEM_R_EN , MEM_W_EN , WB_EN , Br_type , Forward_Dest_EN
				, IS_IMM_H);
	input clk , rst ; 
	input [31:0] Instruction;
	input [31:0] PC_in;
	input WB_Write_Enable;
	input [4:0] WB_Dest;
	input[31:0] WB_Data;

	
	output Forward_Dest_EN;
	output MEM_W_EN , MEM_R_EN , WB_EN;
	output [4:0] Dest;
	output [31:0] Val1 , Val2 , Reg2;
	output [3:0] EXE_CMD;
	output [31:0] PC;
	output [1:0] Br_type;
	output IS_IMM_H;

	wire [31:0] Reg1 , Reg2_local;
	wire [31:0] Sign_extend_out ;
	wire IS_IMM;

	Sign_extend Sign_extend_IF (.In (Instruction[15:0]) , .Out (Sign_extend_out));

	Mux2to1_32bit Mux_1 ( .In1 (Reg2_local ) , .In2 (Sign_extend_out), .Sel(IS_IMM) , .Out(Val2));
	Mux2to1_5bit Mux_2 ( .In1(Instruction[15:11]) , .In2 (Instruction[20:16]) , .Sel(IS_IMM) , .Out(Dest));

	Register_file RF ( .clk(clk) , .rst(rst) , .Src1(Instruction[25:21]) , .Src2(Instruction[20:16]) , .Dest(WB_Dest) , 
						.Write_Val(WB_Data) , .Write_EN(WB_Write_Enable) , .Reg1 (Val1), .Reg2(Reg2_local) );
	
	Control_unit CU (.Opcode (Instruction[31:26]) , .IS_IMM (IS_IMM ) , .WB_EN(WB_EN) , .MEM_R (MEM_R_EN) , .MEM_W(MEM_W_EN), .EXE_CMD (EXE_CMD) , .BR_type(Br_type) , .Forward_Dest_EN(Forward_Dest_EN));
	
	assign Reg2= Reg2_local ;
	assign  IS_IMM_H = IS_IMM ;
	assign PC = PC_in;

	
endmodule

module ID_Stage_reg(clk, rst, PC_in, PC , Flush , MEM_R_EN_in , MEM_W_EN_in , WB_EN_in,
						EXE_CMD_in , Dest_in , Reg2_in , Val1_in , Val2_in,
						Dest , Val1 , Val2 , Reg2 , MEM_R_EN , 
						MEM_W_EN , EXE_CMD , WB_EN , Br_type_in , Br_type,
						Src1_ID, Src2_ID, Src1_EXE, Src2_EXE, IS_IMM_H);
	input clk , rst ;

	input Flush;
	input   MEM_R_EN_in , MEM_W_EN_in , WB_EN_in ;
	input [3:0] EXE_CMD_in; 
	input [4:0] Dest_in ; 
	input [31:0] Reg2_in , Val1_in , Val2_in ; 
	input [31:0] PC_in;
	input [1:0] Br_type_in ; 
	//hazard
	input [4:0] Src1_ID, Src2_ID;
	input IS_IMM_H;
	//hazard

	output reg [31:0] PC;
	output reg [4:0] Dest;
	output reg [31:0] Val1 , Val2 , Reg2;
	
	output reg WB_EN;
	output reg MEM_R_EN;
	output reg MEM_W_EN;
	output reg [3:0] EXE_CMD;
	output reg [1:0] Br_type ;
	//hazard
	output reg [4:0] Src1_EXE, Src2_EXE;
	//hazard


	always @(posedge clk) begin
		if (rst | Flush)
		begin
			
		
			PC <=32'b0;
			Dest <= 5'b0;
			Val1 <= 32'b0;
			Val2 <= 32'b0;
			Reg2 <= 32'b0;
			WB_EN <= 1'b0;
			MEM_W_EN <= 1'b0;
			MEM_R_EN <= 1'b0;
			EXE_CMD <= 4'b0;
			Br_type <= 2'b00;
			//hazard
			Src1_EXE <= 5'b0;
		  	Src2_EXE <= 5'b0;
		  	//hazard
		end
		else 
		begin
			PC <= PC_in ; 
			Dest <= Dest_in;
			Val1 <= Val1_in;
			Val2 <= Val2_in;
			Reg2 <= Reg2_in;
			WB_EN <= WB_EN_in;
			MEM_W_EN <= MEM_W_EN_in;
			MEM_R_EN <= MEM_R_EN_in;
			EXE_CMD <= EXE_CMD_in;
			Br_type <= Br_type_in;
			//hazard
			Src1_EXE <= Src1_ID;
		    Src2_EXE <= (IS_IMM_H) ? 5'b0 : Src2_ID;
		    //hazard
		end
	end
	
endmodule

module EXE_Stage(clk, rst, PC , EXE_CMD , Val1 ,Val2 , Val_src2 , Br_type , ALU_result , Br_Addr , Br_taken);
	input clk , rst ;
	input [31:0] PC;
	input [3:0] EXE_CMD;
	input [31:0] Val1;
	input [31:0] Val2;
	input [31:0] Val_src2;
	input [1:0] Br_type;

	output [31:0] ALU_result;
	output [31:0] Br_Addr;
	output reg Br_taken;

	assign Br_Addr = PC + (Val2<<2);
	
	always @(*) 
	begin 
		if (Br_type == 2'b01 && Val1 == 0 )
			Br_taken = 1'b1;
		else if (Br_type == 2'b10 && Val1 != Val_src2 )
			Br_taken = 1'b1;
		else if (Br_type == 2'b11 ) 
			Br_taken = 1'b1;
		else 
			Br_taken = 1'b0;
	end      

 ALU I1(.Val1(Val1), .Val2(Val2), .EXE_CMD(EXE_CMD), .ALU_result(ALU_result));
 

endmodule

module EXE_Stage_reg(clk, rst, PC_in, WB_EN_in , MEM_R_EN_in , MEM_W_EN_in , ALU_result_in , ST_val_in , Dest_in , WB_EN , MEM_R_EN , MEM_W_EN , PC , ALU_result , ST_val ,  Dest);

	input clk , rst ;
	input WB_EN_in;
	input MEM_R_EN_in;
	input MEM_W_EN_in;

	input [31:0] PC_in;
	input [31:0] ALU_result_in;
	input [31:0] ST_val_in;
	input [31:0] Dest_in;


	output reg WB_EN;
	output reg MEM_R_EN;
	output reg MEM_W_EN;
	output reg [31:0] PC;
	output reg [31:0] ALU_result;
	output reg [31:0] ST_val;
	output reg [4:0] Dest;
	


	always @(posedge clk) begin
		if (rst)
		begin
			//PC <=32'b0;
			Dest <= 5'b0;
			ST_val <= 32'b0;
			WB_EN <= 1'b0;
			MEM_W_EN <= 1'b0;
			MEM_R_EN <= 1'b0;
			ALU_result <= 32'b0;
		end

		else 
		begin
			
			//PC <= PC_in ; 
			Dest <= Dest_in;
			ALU_result <= ALU_result_in;
			ST_val <= ST_val_in;
			WB_EN <= WB_EN_in;
			MEM_W_EN <= MEM_W_EN_in;
			MEM_R_EN <= MEM_R_EN_in;
		end


	end

endmodule

module MEM_Stage(clk, rst, PC_in, PC , MEM_W_EN_in , MEM_R_EN_in ,
				 ALU_result_in , ST_val , MEM_read_value);

	input clk , rst ;
	input [31:0] PC_in;
	input MEM_R_EN_in , MEM_W_EN_in;
	input [31:0] ALU_result_in , ST_val;


	output [31:0] PC;
	output [31:0] MEM_read_value;
	
	wire [31:0] Address;

	assign Address =  ALU_result_in - 1024;
	Data_Memory Memory( .clk(clk) , .ST_val(ST_val) , .MEM_W_EN(MEM_W_EN_in) , .MEM_R_EN(MEM_R_EN_in) , .Address (Address) , .Mem_read_value(MEM_read_value));
	
	

endmodule

module MEM_Stage_reg(clk, rst, PC_in, PC , WB_EN_in , MEM_R_EN_in , ALU_result_in , MEM_read_value_in, Dest_in , WB_EN , MEM_R_EN ,
					 ALU_result , MEM_read_value , Dest );
	input clk , rst ;
	input WB_EN_in , MEM_R_EN_in;
	input [31:0] ALU_result_in , MEM_read_value_in;
	input [4:0] Dest_in ;

	input [31:0] PC_in;


	output reg [31:0] PC;
	output reg WB_EN , MEM_R_EN;
	output reg [31:0] ALU_result , MEM_read_value;
	output reg [4:0] Dest ; 

	always @(posedge clk) begin
		if (rst)
		begin

			PC <=32'b0;
			WB_EN <= 1'b0;
			MEM_R_EN <= 1'b0;
			ALU_result <= 31'b0;
			MEM_read_value <= 31'b0;
			Dest <= 5'b0;
		end

		else 

		begin
			WB_EN <= WB_EN_in;
			MEM_R_EN <= MEM_R_EN_in;
			ALU_result <= ALU_result_in;
			MEM_read_value <= MEM_read_value_in;
			Dest <= Dest_in;
			PC <= PC_in;
			Dest <= Dest_in;
		end

	end

endmodule

module WB_Stage(clk, rst, PC_in, PC , WB_EN_in , MEM_R_EN , ALU_result , MEM_read_value , Dest_in , Write_value , Dest , WB_EN);
	input clk , rst ;
	input [31:0] PC_in;
	input WB_EN_in , MEM_R_EN;
	input [31:0] ALU_result , MEM_read_value;
	input [4:0] Dest_in;
	
	output WB_EN;
	output [31:0] Write_value;
	output [4:0] Dest ;
	output [31:0] PC;

	assign PC = PC_in;
	assign Dest = Dest_in ; 
	assign WB_EN = WB_EN_in;
	
	assign Write_value = (~MEM_R_EN)? ALU_result : MEM_read_value;

endmodule

