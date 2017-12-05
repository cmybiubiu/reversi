

module board(
			input clk,
			input resetn,
			input [2:0]x,
			input [2:0]y,
			input go,
			
			output reg [127:0] board_result,
			output reg player_black
			);

	//position on the board
	wire [6:0] position = {y, x, 1'b0};

	// initial the board.   000 empty; 100 enable; 110 white; 111 black.
	reg [191:0]  board, next_board;
	reg  check_enable, place_enable, reverse_enable, draw_enable; 

	always @(posedge clk)
		begin
			if (resetn)  // initial the board.
			
				begin 
				board <= 128b'0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
				
				{27{2'b00}, 2'b10, 2'b11, 6{2'b00}, 2'b11, 2'b10, 27{2'b00}};	
				player_black <= 1'b1; 
				end
				
			else
				board <= 0;
		end
			
endmodule


