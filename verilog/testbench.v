module testbench;


reg [15:0] x , y , z ;
wire [15:0] res1;
wire [15:0] res2; 
reg mode;
reg reset = 1;
reg start = 0; 
reg clk = 1'b0;
   
initial
begin
      forever
        #5 clk = !clk;
end


cordic c1( mode, x, y, z, clk, reset, res1, res2);

initial
begin
	reset = 0;
	#5;
	reset = 1;
	start = 1;
end


 
initial begin
	#5
	x <= 16'b1001_1001_1001_0100; 
	y <= 16'b1001_1110_1100_0001; 
	z <= 16'b0000_0001_1101_1111; 
	mode <= 1;
	#10
	x <= 16'b1001_1001_1001_0100; 
	y <= 16'b1001_1110_1100_0001; 
	z <= 16'b0000_0001_1101_1111; 
	mode <= 0;

end  

initial 
$monitor ( $time , " res1=%h res2=%h " , res1,res2);

 


endmodule
