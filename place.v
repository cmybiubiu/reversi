module place ( 
			input clk,
			input resetn,
			input [2:0] x,
			inout [2:0] y,
			input place_enable,
			input [127:0] curr_board,
			input player_black,
			
			output reg [127:0] result_board
			);
		
		wire [6:0] index;
		assign index[6:1] = {y, x};
		assign index[0] = 1'b0;

		
		always @(posedge clk)
		begin
			if (resetn)
				result_board <= curr_board;
			else 
				begin 
					if (place_enable)
						begin
							if (player_black)
								result_board[index + : 2]  <= 2'b11;
							else 
								result_board[index + : 2]  <= 2'b10;
						end	
				end
		end



endmodule 