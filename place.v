module place ( 
			input clk,
			input reseten,
			
			input place_enable,
			input [191:0] curr_board,
			input index,
			input player_black,
			
			output reg [191:0] result_board;
			output next_player_blace
			);

		always @(posedge clk)
		begin
			
			result_board <= curr_board;
			if (place_enable)
				begin
					next_player_black <= ~player_balck;
					if (player_balck)
						result_board[index + : 3]  <= 3'b111;
					else 
						result_board[index + : 3]  <= 3'b110;
				end
			else 
				next_player_balck <= player_black;
								
		end



endmodule 