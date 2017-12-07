module placeSecond(
								input [2:0] x,
								input [2:0] y,
								input placeEn,
								input [3:0] q,
								input resetn,
								input clk,
								input player_black,
								
								output reg wren,
								output reg [4:0] address,
								output reg [3:0] data,
								output reg placeeDone
								);
								
		wire [5:0] position;
		wire [1:0] piece;
		assign position = 8*y + x;
		assign piece = {1'b1, player_black};
		
		always @(posedge clk)
		begin
			if (resetn) 
				begin 
					wren <= 0;
					address <= 0;
					data <= 0;
					placeDone <= 0;
				end 
				
			else 
				begin
					if (placeEn) 
						begin
							if (placeDone)
							begin
								placeDone <= 0;
								wren <= 0;
								address <= 0;
								data <= 0;
								
							end 
							
							else
							begin 
								
								if(positin[0] == 1'b0)
								begin 
									wren <= 1;
									address <= position[5:1];
									data[1:0] <= piece;
									data[3:2] <= q[3:2];
									placeDone <= 1;
								end
								
								else 
								begin
									wren <= 1;
									address <= position[5:1];
									data[1:0] <= q[1:0];
									data[3:2] <= piece;
									placeDone <= 1;
								end 
							
							end 
						end 
				end 
		end 
endmodule 