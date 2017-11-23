// WE need a module to draw the updated  board with nodes.

module reversi(
			input clk,
			input resetn,
			input x,
			input y,
			input go,	
			);

	//position 
	integer position = y*8 + x;
	integer index = position*3;

	// initial the board.   000 empty; 100 enable; 110 white; 111 black.
	reg [191:0] board, 
				next_board = {27{3'b000}, 3'b110, 3'b111, 6{3'b000}, 3'b111, 3'b110, 27{3'b000}};

	always@(posedge clk)
		begin: 
			if(resetn)  // initial the board.
				board <= {27{3'b000}, 3'b110, 3'b111, 6{3'b000}, 3'b111, 3'b110, 27{3'b000}};		
			else
				// USE the module game_process.
		end 
endmodule

//Determinate the state of this game (also the board)
module game_process (clk, resetn, curr_board, go, index, set_black, next_board);
	input clk;
	inout resetn;
	input [191:0] curr_board;
	input go;
	input index;
	input set_black; //which player.

	output reg [191:0] next_board;

	reg [2:0] curr_state, next_state; 
	wire [2:0] node = curr_board[index + 2: index];

	localparam  CHECK_ENABLE = 3'd0,
				PUT_DWON = 3'd1,
				REVERSE = 3'd2,
				FINISH = 3'd3;
	
	always @(*)
	begin
		case(curr_state)
			CHECK_ENABLE : next_state = enable ? PUT_DWON : FINISH;
			PUT_DWON : next_state =  go ? REVERSE : PUT_DWON;
			REVERSE : next_state = go ? FINISH : REVERSE;
			FINISH : next_state = go ? CHECK_ENABLE :FINISH;
			default : next_state = FINISH;
		endcase
	end

	always @(*)
	begin
		if (curr_state == CHECK_ENABLE)
			// Create a module to check if there are enable steps.
		else if (curr_state == PUT_DWON)
			// Change the state of node which the player choose. 
			controll_node_state c1(.clk(clk), .resetn(resetn), .curr(node), .play(go), .reverse(), .set_black(set_black),  .next_state(curr_board[index + 2: index]));
		else if (curr_state == REVERSE)
			// Create module to reverse all possible nodes.
		else if (curr_state == FINISH)
			next_board <= curr_board;
	end
endmodule

// Set the state of a single node.
module controll_node_state(clk, resetn, curr, play, reverse, set_black, next_state);
	input clk;
	input resetn;
	input [2:0] curr;
	input play;
	input set_black;
	input reverse;
	output reg [2:0] next_state; 
	
	reg [2:0] curr_state = curr, next_state;
	
	
	localparam EMPTY = 3'b000,
				  ENABLE = 3'b100,
				  BLACK = 3'b111,
				  WHITE = 3'b110;

	
	// SET the next state of this node
	always @(*)
	begin: state_table
			case (curr_state)
				EMPTY: next_state = play ?  ENABLE : EMPTY;
				ENABLE: begin 
								if (play) 
									begin
										if (set_black)
											next_state = BLACK;
										else 
											next_state = white;
									end
								else 
									next_state = ENABLE;
						  end ;
				BLACK : next_state = reverse ? WHITE : BLACK;
				WHITE : next_state = reverse ? BLACK : WHITE;
				default:next_state = EMPTY;
			endcase
	end 
endmodule  
