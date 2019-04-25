`timescale 1ns/1ns
module TB();


reg CLOCK_50=0;
reg	  [17:0]	SW=18'b0;			

MIPS T1(.CLOCK_50(CLOCK_50), .SW(SW));


initial repeat(5000) 
begin 
  CLOCK_50 = ~CLOCK_50;  
  #20; 
 end
 
 initial begin
   SW[17] =0;
   SW[3] = 1;
   #10;
   SW[17] =  1;
   #100;
   SW[17] = 0;

   
 end

endmodule