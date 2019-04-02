
module Data_Memory ( clk , ST_val , MEM_W_EN , MEM_R_EN , Address , Mem_read_value);


  input [31:0] Address;
  input clk;
  input [31:0] ST_val;
  input MEM_R_EN , MEM_W_EN;
  output reg [31:0] Mem_read_value;

  reg [31:0] MEM_data [0:63];

/*initial begin 
  MEM_data[33] = 4;
end*/



  always @(*) begin
   if(MEM_R_EN)
      Mem_read_value = MEM_data[Address];
    else
      Mem_read_value = Mem_read_value;
  
  end

  always @(posedge clk) begin

    if(MEM_W_EN)
     MEM_data[Address] <= ST_val;
    else
     MEM_data[Address] <= MEM_data[Address];

  end

endmodule