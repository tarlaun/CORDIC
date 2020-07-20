module cordic_stage    	#( parameter stage)
			(input [15:0] x,
			input [15:0] y,
			input [15:0]z,
			input mode,
			input reset,
			input clock,
			output reg [15:0] x_out,
			output reg [15:0] y_out,
			output reg [15:0] z_out,
			output reg mode_out);

		`define rotate 0
		`define phase_calc 1
		`define PI 16'b0_0000011_00100100
		`define PI15 15'b0000011_00100100
		reg [15:0] atan;
		always @(posedge clock or negedge reset)
		begin
			if (~reset)
			begin
				case (stage) 
					0 : atan <= 16'b0_0000000_11001001;
					1 : atan <= 16'b0_0000000_01110110;
					2 : atan <= 16'b0_0000000_00111110;
					3 : atan <= 16'b0_0000000_00011111;
					4 : atan <= 16'b0_0000000_00001111;
					5 : atan <= 16'b0_0000000_00000111;
					6 : atan <= 16'b0_0000000_00000011;
					7 : atan <= 16'b0_0000000_00000001;
					default : atan <= 0;
				endcase
				x_out <= 0;
				y_out <= 0;
				z_out <= 0;
				mode_out <= 0;
			end
			else
			begin
				mode_out <= mode;
				if (mode == `rotate)
				begin
					if (z[15] == 0)
					begin
						case (x[15]^y[15])
							1'b0 : x_out <= (x[14:0] > (y[14:0] >> stage) ) ? 
									{x[15], x[14:0] - (y[14:0] >> stage)} :
									{~x[15],(y[14:0] >> stage) - x[14:0]}; 
							1'b1 : x_out <= {x[15], x[14:0] + (y[14:0] >> stage)};
						endcase
						case (x[15]^y[15])
							1'b1 : y_out <= (y[14:0] > (x[14:0] >> stage) ) ? 
									{y[15], y[14:0] - (x[14:0] >> stage)} :
									{~y[15],(x[14:0] >> stage) - y[14:0]}; 
							1'b0 : y_out <= {y[15], y[14:0] + (x[14:0] >> stage)};
						endcase
					
						z_out <= (z[14:0] > atan[14:0]) ? z - atan : {~z[15],atan[14:0] - z[14:0]};
					end
					else
					begin
						case (x[15]^y[15])
							1'b1 : x_out <= (x[14:0] > (y[14:0] >> stage) ) ? 
									{x[15], x[14:0] - (y[14:0] >> stage)} :
									{~x[15],(y[14:0] >> stage) - x[14:0]};
							1'b0 : x_out <= {x[15], x[14:0] + (y[14:0] >> stage)};
						endcase
						case (x[15]^y[15])
							1'b0 : y_out <= (y[14:0] > (x[14:0] >> stage) ) ? 
									{y[15], y[14:0] - (x[14:0] >> stage)} :
									{~y[15],(x[14:0] >> stage) - y[14:0]};
							1'b1 : y_out <= {y[15], y[14:0] + (x[14:0] >> stage)};
						endcase
					
						z_out <= (z[14:0] > atan[14:0]) ? z - atan : {~z[15],atan[14:0] - z[14:0]};
				
					end
				end
				else
				begin
					if (y[15] == 1)
					begin
						case (x[15]^y[15])
							1'b0 : x_out <= (x[14:0] > (y[14:0] >> stage) ) ? 
									{x[15], x[14:0] - (y[14:0] >> stage)} :
									{~x[15],(y[14:0] >> stage) - x[14:0]};
							1'b1 : x_out <= {x[15], x[14:0] + (y[14:0] >> stage)};
						endcase
						case (x[15]^y[15])
							1'b1 : y_out <= (y[14:0] > (x[14:0] >> stage) ) ? 
									{y[15], y[14:0] - (x[14:0] >> stage)} :
									{~y[15],(x[14:0] >> stage) - y[14:0]}; 
							1'b0 : y_out <= {y[15], y[14:0] + (x[14:0] >> stage)};
						endcase
						case (z[15])
							1'b0 : z_out <= (z[14:0] > atan[14:0]) ? 
									{z[15], z[14:0] - atan[14:0]} :
									{~z[15],atan[14:0] - z[14:0]};
							1'b1 : z_out <= {z[15], z[14:0] + atan[14:0]};
						endcase
						//x_out <= x - (y >> stage);
						//y_out <= y + (x >> stage);
						//z_out <= z - atan;
					end
					else
					begin
						case (x[15]^y[15])
							1'b1 : x_out <= (x[14:0] > (y[14:0] >> stage) ) ? 
									{x[15], x[14:0] - (y[14:0] >> stage)} :
									{~x[15],(y[14:0] >> stage) - x[14:0]};
							1'b0 : x_out <= {x[15], x[14:0] + (y[14:0] >> stage)};
						endcase
						case (x[15]^y[15])
							1'b0 : y_out <= (y[14:0] > (x[14:0] >> stage) ) ? 
									{y[15], y[14:0] - (x[14:0] >> stage)} :
									{~y[15],(x[14:0] >> stage) - y[14:0]};
							1'b1 : y_out <= {y[15], y[14:0] + (x[14:0] >> stage)};
						endcase
						case (z[15])
							1'b1 : z_out <= (z[14:0] > atan[14:0]) ? 
									{z[15], z[14:0] - atan[14:0]} :
									{~z[15],atan[14:0] - z[14:0]}; 
							1'b0 : z_out <= {z[15], z[14:0] + atan[14:0]};
						endcase
						//x_out <= x + (y >> stage);
						//y_out <= y - (x >> stage);
						//z_out <= z + atan;
					end
				end
			end
		end
endmodule
					