module Forwarding_Unit(Dest_MEM, Dest_EXE , Forward_Dest_EN, Dest_WB, WB_EN_MEM, WB_EN_WB, Src1_EXE, Src2_EXE, Forward_Val1, Forward_Val2, EN);

input [4:0] Dest_EXE;
input Forward_Dest_EN;
input [4:0]Dest_MEM, Dest_WB;
input WB_EN_MEM, WB_EN_WB;
input [4:0] Src1_EXE, Src2_EXE;
input EN;
output [1:0]Forward_Val1, Forward_Val2;

wire [4:0]in2;

assign in2 = (Forward_Dest_EN == 1'b1 ) ? Dest_EXE : Src2_EXE;


assign Forward_Val1= (EN == 0) ? 2'b0 :
					           (WB_EN_MEM && (Dest_MEM == Src1_EXE)) ? 2'b10 : 
                     (WB_EN_WB  && (Dest_WB  == Src1_EXE)) ? 2'b01 :  2'b0;
                    
assign Forward_Val2= (EN == 0) ? 2'b0 :
					           (WB_EN_MEM && (Dest_MEM == in2)) ? 2'b10 : 
                     (WB_EN_WB && (Dest_WB == in2)) ? 2'b01 : 2'b0;                


endmodule

module Forwarding_MUX(input [31:0]Val,Result_WB,ALU_result_MEM,input [1:0]Forward_Val,output [31:0]O);
  assign O=(Forward_Val==0)?Val:((Forward_Val==1)?Result_WB:((Forward_Val==2)?ALU_result_MEM:32'bz));

endmodule

module IMM_MUX(input [31:0]Val2_Forwarded, Val2, input IS_IMM,output [31:0]O);
  assign O=(IS_IMM==0)?Val2_Forwarded:Val2;

endmodule

module Hazard_Detector ( Src1 , Src2 , EXE_Dest , EXE_WB_EN , MEM_Dest , MEM_WB_EN , Freeze , Hazard_Detected_Sig, MEM_R_EN, EN);
input [4:0] Src1 , Src2;
input [4:0] EXE_Dest, MEM_Dest;
input EXE_WB_EN , MEM_WB_EN;
input MEM_R_EN;
input EN;
output Freeze;
output reg Hazard_Detected_Sig;

always @(*)
begin
	if  (EN == 1'b1)
	  begin
		  if ( ( MEM_R_EN == 1'b1 && ( (Src1 == EXE_Dest) || (Src2 == EXE_Dest) )) == 1'b1)
		  	Hazard_Detected_Sig = 1'b1;
		  else 
		  	Hazard_Detected_Sig = 1'b0;
		end
	else 
	  begin
		  if ((( EXE_WB_EN == 1'b1 && ( (Src1 == EXE_Dest) || (Src2 == EXE_Dest) )) || ( MEM_WB_EN == 1'b1 && ( (Src1 == MEM_Dest) || (Src2 == MEM_Dest) ))) == 1'b1)
			 Hazard_Detected_Sig = 1'b1;
		  else 
			 Hazard_Detected_Sig = 1'b0;
	  end

end
assign Freeze = Hazard_Detected_Sig;
endmodule



module Hazard_MUX ( in1,in2,in3,in4,in5 , Sel , WB_EN , MEM_R , MEM_W , BR_type , EXE_CMD );

input [3:0] in5;
input [1:0] in4;
input in1,in2,in3;
input Sel;
output  WB_EN , MEM_R , MEM_W;
output  [1:0] BR_type ;
output  [3:0] EXE_CMD;

assign WB_EN = (Sel == 1'b1) ? 1'b0: in1;
assign MEM_R = (Sel == 1'b1) ? 1'b0: in2;
assign MEM_W = (Sel == 1'b1) ? 1'b0: in3;
assign BR_type = (Sel == 1'b1) ? 2'b0 : in4;
assign EXE_CMD = (Sel == 1'b1) ? 4'b0 : in5;

endmodule






