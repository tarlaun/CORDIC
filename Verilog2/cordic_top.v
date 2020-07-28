module cordic 	(input op_mode,
		input [15:0] x_coordinate,
		input [15:0] y_coordinate,
		input [15:0] rotate_amount,
		input clock,
		input reset,
		output reg [15:0] x_or_phase_out,
		output reg [15:0] y_or_size_out,
		output wire [127:0] stageX,
		output wire [127:0] stageY,
		output wire [127:0] stageZ
		);
		// Every number is in the fixed point format of {sign bit:7 integer bits:8 fractional bits}

		`define rotate 0
		`define phase_calc 1
		`define PI 16'b0_0000011_00100100
		`define PI15 15'b0000011_00100100
		`define size_adj 15'b00000001_10100101
		//op_mode is opertation mode, if zero the current input will be placed in the rotation pipeline, and if one
		//it will be placed in the phase calculation pipeline
		reg [15:0] x_in;
		reg [15:0] y_in;
		reg [15:0] z_in;
		reg mode_in;
		wire [15:0] connections_x [7:0];
		wire [15:0] connections_y [7:0];
		wire [15:0] connections_z [7:0];
		wire connections_mode [7:0];
		wire [2:0] connections_stage [7:0];
		wire [15:0] outx;
		wire [15:0] outy;
		wire [15:0] outz;
		wire [32:0] holderx;
		wire [14:0] divx;
		wire [14:0] divy;
		wire [32:0] holdery;
		
		assign stageX[15:0] = connections_x[0];
		assign stageX[31:16] = connections_x[1];
		assign stageX[47:32] = connections_x[2];
		assign stageX[63:48] = connections_x[3];
		assign stageX[79:64] = connections_x[4];
		assign stageX[95:80] = connections_x[5];
		assign stageX[111:96] = connections_x[6];
		assign stageX[127:112] = connections_x[7];
		assign stageY[15:0] = connections_y[0];
		assign stageY[31:16] = connections_y[1];
		assign stageY[47:32] = connections_y[2];
		assign stageY[63:48] = connections_y[3];
		assign stageY[79:64] = connections_y[4];
		assign stageY[95:80] = connections_y[5];
		assign stageY[111:96] = connections_y[6];
		assign stageY[127:112] = connections_y[7];
		assign stageZ[15:0] = connections_z[0];
		assign stageZ[31:16] = connections_z[1];
		assign stageZ[47:32] = connections_z[2];
		assign stageZ[63:48] = connections_z[3];
		assign stageZ[79:64] = connections_z[4];
		assign stageZ[95:80] = connections_z[5];
		assign stageZ[111:96] = connections_z[6];
		assign stageZ[127:112] = connections_z[7];
		
		
		assign outx = connections_x[7];
		assign outy = connections_y[7];
		assign outz = connections_z[7];
		assign holderx = outx[14:0];
		assign divx = (holderx << 8) / `size_adj;
		assign holdery = outy[14:0];
		assign divy = (holdery << 8) / `size_adj;
		always @(posedge clock or negedge reset)
		begin
			if (~reset)
			begin
				x_in <= 0;
				y_in <= 0;
				z_in <= 0;
				x_or_phase_out <= 0;
				y_or_size_out <= 0;
			end
			else
			begin
				mode_in <= op_mode;
				if (connections_mode[7] == 0)
				begin
					//output transfer
					x_or_phase_out <= {outx[15], divx};
					y_or_size_out <= {outy[15], divy};
				end
				else
				begin
					//output transfer
					y_or_size_out <= {outx[15], divx};
					x_or_phase_out <= outz;
				end
				if(op_mode == `rotate)
				begin
					//input transfer
					if (rotate_amount[14:0] <= (`PI15 >> 1))
					begin
						z_in <= rotate_amount;
						x_in <= x_coordinate;
						y_in <= y_coordinate;
					end
					else
					begin
						if (rotate_amount[15] == 1)
						begin
							x_in <= y_coordinate;
							y_in <= {~x_coordinate[15],x_coordinate[14:0]};
							z_in <= {rotate_amount[15],rotate_amount[14:0] - (`PI15 >> 1)};
						end
						else
						begin
							
							y_in <= x_coordinate;
							x_in <= {~y_coordinate[15],y_coordinate[14:0]};
							z_in <= rotate_amount - (`PI>>1);
						end
					end
					
				end
				else
				begin
					//input transfer
					if (x_coordinate[15] == 0)
					begin
						z_in <= 0;
						x_in <= x_coordinate;
						y_in <= y_coordinate;
					end
					else
					begin
						if (y_coordinate[15] == 0)
						begin
							x_in <= y_coordinate;
							y_in <= {~x_coordinate[15],x_coordinate[14:0]};
							z_in <= (`PI >> 1);
						end
						else
						begin
							
							y_in <= x_coordinate;
							x_in <= {~y_coordinate[15],y_coordinate[14:0]};
							z_in <= 16'b1_0000001_10010010; //-PI/2
						end
					end
				end
			end
		end
		wire [2:0] gnd;
		assign gnd = 0;
		cordic_stage s0 (x_in, y_in, z_in, mode_in, reset, clock, gnd,
				 connections_x[0], connections_y[0], connections_z[0], connections_mode[0], connections_stage[0]);
		genvar i;
		generate
			for (i = 1; i < 8; i = i + 1) begin : stages
				cordic_stage  s0 (connections_x[i - 1],
							connections_y[i - 1],
							connections_z[i - 1],
							connections_mode[i - 1],
							reset,
							clock,
							connections_stage[i - 1],
							connections_x[i], 
							connections_y[i],
							connections_z[i],
							connections_mode[i],
							connections_stage[i]);
			end
		endgenerate
		

				
endmodule