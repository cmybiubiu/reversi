module place ( 
			input clk,
			input resetn,
			
			input place_enable,
			input [191:0] curr_board,
<<<<<<< HEAD
			input [4:0] index,
=======
			input [6:0] index,
>>>>>>> 700eff26935be12bc5709d508be00a6cc8d6f4da
			input player_black,
			
			output reg [191:0] result_board
			);

		always @(posedge clk)
		begin
					result_board <= curr_board;
					if (place_enable)
						begin
							if (player_black)
								result_board[index + : 3]  <= 3'b111;
							else 
								result_board[index + : 3]  <= 3'b110;
					end								
		end



endmodule 