module Register_file ( clk , rst , Src1 , Src2 , Dest , Write_Val , Write_EN , Reg1 , Reg2 );
	input clk , rst , Write_EN;
	input [4:0] Src1 , Src2 , Dest;
	input [31:0] Write_Val;
	output  [31:0] Reg1 , Reg2;

	reg [31:0] Reg_data [0:31];

	integer i;

	assign Reg1 = Reg_data[Src1];
	assign Reg2 = Reg_data[Src2];

	always @ (negedge clk)
	begin 
		if ( rst )
			begin
				for ( i=0 ; i < 32 ; i = i+1)
					Reg_data [i] <= i;
			end
		else 
			begin 
				if ( Write_EN)
					if (Dest != 5'b0)
						Reg_data[Dest] = Write_Val;
				
			end
	end

	
endmodule


