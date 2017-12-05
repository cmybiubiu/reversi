

module board(
			input clk,
			input resetn,
			input [2:0]x,
			input [2:0]y,
			input go,
			
			output reg [127:0] board,
			output reg player_black
			);

	//position on the board
	//wire [6:0] position = {y, x, 1'b0};

	// initial the board.   000 empty; 100 enable; 110 white; 111 black.
	//reg [127:0]  board, next_board;
	//reg  check_enable, place_enable, reverse_enable, draw_enable; 



	always @(posedge clk)
		begin
			if (resetn)  // initial the board.
				begin 
					board[15:0] <= 16'b0000000000000000;
					board[31:16] <= 16'b0000000000000000;
					board[47:32] <= 16'b0000000000000000;
					board[63:48] <= 16'b0000001110000000;
					board[79:64] <= 16'b0000001011000000;
					board[95:80] <= 16'b0000000000000000;
					board[111:96] <= 16'b0000000000000000;
					board[127:112] <= 16'b0000000000000000;
					player_black <= 1'b1; 
				end
				
			else
				board <= 0;
		end
			
endmodule


