module testbench2;


reg [15:0] x , y , z , counter , writeCounter;
wire [15:0] res1;
wire [15:0] res2;
 

integer status, fd ,  fw;


reg mode;
reg reset = 1;
reg clk = 0;


cordic c(mode , x, y , z , clk , reset , res1 , res2);

initial
	forever
	#5 clk = ~clk;

initial begin
   fd = $fopen("test_read.dat", "r");
   if (!fd) $error("could not read file");
end

initial begin
	reset = 0;
	#7;
	reset <= 1;
	counter <= 0;
	writeCounter <= 0;
end

 initial begin
  fw = $fopen("test_write.txt","w");
end


initial 
$monitor($time, " res1 = %b res2 = %b",  res1 , res2); 

reg temp = 0;

always @(posedge clk)
begin 
	if(reset)
	begin
		if(counter < 300)
		begin
			counter <= counter + 1;
			
			$fscanf(fd , "%b", mode);
			$fscanf(fd , "%b" , x);
			$fscanf(fd , "%b" , y);
			$fscanf(fd , "%b" , z);
			if(counter > 10)
			begin
			$fwrite(fw , "%b %b\n", res1 ,res2);
			end
			
		end
		
	end
end	







endmodule
