module testbench;


reg [15:0] x , y , z , counter , cData;
wire [15:0] res1;
wire [15:0] res2; 
reg mode;
reg reset = 1;
reg start = 0; 
reg clk = 1'b0;
   
initial
begin
      forever
        #10 clk = !clk;
end


cordic c1( mode, x, y, z, clk, reset, res1, res2);

initial
begin
	reset = 0;
	#10;
	reset = 1;
	start = 1;
end


 
initial begin
	x <= 16'b0001_1010_0110_0000; //26.375
	y <= 16'b0000_1110_0000_0000; //14
	z <= 16'b0000_0010_0000_0000; //2
	mode <= 0;

end  

 


endmodule
