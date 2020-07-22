module testbench2;


reg [15:0] x , y , z , counter , writeCounter;
wire [15:0] res1;
wire [15:0] res2; 

integer status, fd , fd2 , status2 , fw;


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
   fd2 = $fopen("test_read_mode.dat", "r");
   if (!fd2) $error("could not read second file");
  
end

initial begin
	reset = 0;
	#5;
	reset <= 1;
	counter <= 0;
	writeCounter <= 0;
end



always @(negedge clk)
begin 
	if(reset)
	begin
		if(counter < 100)
		begin
			if(!$feof(fd2))
			begin
				status2 = $fscanf(fd2 , "%b", mode);
				if(!$feof(fd))
					status = $fscanf(fd , "%b" , x);
				if(!$feof(fd))
					status = $fscanf(fd , "%b" , y);
				if( mode == 0 && !$feof(fd))
					status = $fscanf(fd , "%b" , z);
			end
		end
	end
	if(reset)
	begin
		$fwrite(fw , "%b %b\n", res1 ,res2);
	end
end

 initial begin
  fw = $fopen("test_write.txt","w");
end


initial begin
  #200
  $fclose(fw);  
end


initial 
$monitor($time, " res1 = %b res2 = %b",  res1 , res2); 

endmodule
