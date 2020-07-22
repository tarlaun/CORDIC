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
	x <= 16'b1111_1001_1001_0100; //-121.578125  // fail //fail
	y <= 16'b0001_1110_1100_0001;  //30.75390625
	z <= 16'b0000_0010_0000_0000; //2
	mode <= 1;

end  

 


endmodule
