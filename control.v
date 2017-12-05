//Basic Outline, from Lab7 part2, needs to be changed

module control(
			input clk,
			input resetn,
			input go,
			input validMove,
			input hasTurn
			
			//add inputs from KeyBoardInterpreter here
			
			output reg ld_colour, ld_x, ld_y,
			output reg writeEn
			output reg enterEn,
			output reg moveRightEn,
			output reg moveLeftEn,
			output reg moveUpEn,
			output reg moveDownEn
			);
			
			reg [8:0] current_state, next_state; 
    
		localparam  	INITIALIZE        		= 9'b000000000,
							TO_INITIAL_RESET 			= 9'b001000001, //intermediate state
							INITIAL_RESET   			= 9'b000000001,
							INITIAL_DRAW_BOARD   	= 9'b000000011,
							INITIAL_DRAW_PIECES 		= 9'b000001011,
							WAIT_FOR_INPUT				= 9'b000011011,
							TO_MOVE_RIGHT 				= 9'b000111011, //intermediate state
							MOVE_RIGHT 					= 9'b000110011,
							TO_MOVE_LEFT 				= 9'b001011011, //intermediate state
							MOVE_LEFT 					= 9'b001010011, 
							TO_MOVE_UP 					= 9'b010011011, //intermediate state
							MOVE_UP 						= 9'b010010011, 
							TO_MOVE_DOWN 				= 9'b100011011, //intermediate state
							MOVE_DOWN 					= 9'b100010011,
							DRAW_MOVE 					= 9'b000010011,
							CHECK_IF_VALID_MOVE 		= 9'b000111011,
							AFTER_CHECK_IF_VALID		= 9'b000101011,
							TO_DISPLAY_INVALID_1 	= 9'b000101010, //intermediate state
							TO_DISPLAY_INVALID_2 	= 9'b000100010, //intermediate state
							DISPLAY_INVALID 			= 9'b000110010,
							DISPLAY_INVALID_WAIT 	= 9'b000111010,
							ERASE_INVALID 				= 9'b000011010,
							PLACE_AND_DRAW_PIECE 	= 9'b001101011,
							FLIP_AND_DRAW_PIECES 	= 9'b011101011,
							UPDATE_SCORE				= 9'b011100011,
							DRAW_SCORE 					= 9'b011100111,
							DETERMINE_OPPONENT_HAS_TURN = 9'b010100111,
							TO_OPPONENT_HAS_TURN 	= 9'b0010110111, //intermediate state
							OPPONENT_HAS_TURN 		= 9'b000110111,
							DETERMINE_CURRENT_HAS_TURN = 9'b000010111,
							CURRENT_HAS_TURN 			= 9'b000011111,
							TO_SWITCH_TURN_1			= 9'b000111111, //intermediate state
							TO_SWITCH_TURN_2 			= 9'b000111101, //intermediate state
							TO_SWITCH_TURN_3 			= 9'b000111001, //intermediate state
							SWITCH_TURN 				= 9'b000011001, 
							END_GAME 					= 9'b001011111,
							DISPLAY_WINNER 			= 9'b001001111,
							DISPLAY_WINNER_WAIT 		= 9'b001000111,
							CLEAR_PIECES 				= 9'b001000011;
							
							
							
			// Next state logic aka our state table
			always @(*)
			begin: state_table
					case (current_state)
						S_LOAD_X: next_state = gox ? S_LOAD_X_WAIT : S_LOAD_X;
						S_LOAD_X_WAIT: next_state = gox ? S_LOAD_X_WAIT : S_LOAD_Y_COL;
						S_LOAD_Y_COL: next_state = go ? S_LOAD_Y_COL_WAIT : S_LOAD_Y_COL;
						S_LOAD_Y_COL_WAIT: next_state = go ? S_LOAD_Y_COL_WAIT : S_LOAD_X;
						
						INITIALIZE:        		next_state = go ? INITIAL_RESET : INITIALIZE,
						TO_INITIAL_RESET: 		next_state = 9'b001000001, //intermediate state
						INITIAL_RESET:   			next_state = 9'b000000001,
						INITIAL_DRAW_BOARD:   	next_state = 9'b000000011,
						INITIAL_DRAW_PIECES: 	next_state = 9'b000001011,
						WAIT_FOR_INPUT: begin 	
														next_state = 9'b000011011;
														next_state = ;
											 end 
						TO_MOVE_RIGHT: 			next_state = 9'b000111011, //intermediate state
						MOVE_RIGHT: 				next_state = 9'b000110011,
						TO_MOVE_LEFT: 				next_state = 9'b001011011, //intermediate state
						MOVE_LEFT: 					next_state = 9'b001010011, 
						TO_MOVE_UP: 				next_state = 9'b010011011, //intermediate state
						MOVE_UP: 					next_state = 9'b010010011, 
						TO_MOVE_DOWN: 				next_state= 9'b100011011, //intermediate state
						MOVE_DOWN: 					next_state= 9'b100010011,
						DRAW_MOVE: 					next_state= 9'b000010011,
						CHECK_IF_VALID_MOVE: 	next_state	= 9'b000111011,
						AFTER_CHECK_IF_VALID:	next_state	= 9'b000101011,
						TO_DISPLAY_INVALID_1: 	next_state= 9'b000101010, //intermediate state
						TO_DISPLAY_INVALID_2: 	next_state= 9'b000100010, //intermediate state
						DISPLAY_INVALID: 			next_state= 9'b000110010,
						DISPLAY_INVALID_WAIT: 	next_state= 9'b000111010,
						ERASE_INVALID: 			next_state	= 9'b000011010,
						PLACE_AND_DRAW_PIECE: 	next_state= 9'b001101011,
						FLIP_AND_DRAW_PIECES: 	next_state= 9'b011101011,
						UPDATE_SCORE:				next_state= 9'b011100011,
						DRAW_SCORE: 				next_state	= 9'b011100111,
						DETERMINE_OPPONENT_HAS_TURN: next_state= 9'b010100111,
						TO_OPPONENT_HAS_TURN: 	next_state= 9'b0010110111, //intermediate state
						OPPONENT_HAS_TURN: 		next_state= 9'b000110111,
						DETERMINE_CURRENT_HAS_TURN: next_state= 9'b000010111,
						CURRENT_HAS_TURN: 		next_state	= 9'b000011111,
						TO_SWITCH_TURN_1:			next_state= 9'b000111111, //intermediate state
						TO_SWITCH_TURN_2: 		next_state	= 9'b000111101, //intermediate state
						TO_SWITCH_TURN_3: 		next_state	= 9'b000111001, //intermediate state
						SWITCH_TURN: 				next_state= 9'b000011001, 
						END_GAME: 					next_state= 9'b001011111,
						DISPLAY_WINNER: 			next_state= 9'b001001111,
						DISPLAY_WINNER_WAIT: 	next_state	= 9'b001000111,
						CLEAR_PIECES: 				next_state= 9'b001000011;
						default: next_state = INITIALIZE;
					endcase
			end
			
			// Output logic aka all of our datapath control signals
			always @(*)
			begin: enable_signals
				  // By default make all signals 0
				  ld_colour = 1'b0;
				  ld_x = 1'b0;
				  ld_y = 1'b0;
				  writeEn = 1'b0;
				  case (current_state)
						S_LOAD_X: begin
							 ld_x = 1'b1;
							 end
						S_LOAD_Y_COL: begin
							 ld_y = 1'b1;
							 ld_colour = 1'b1;
							 end
						S_LOAD_Y_COL_WAIT: begin
							 writeEn = 1'b1;
							 end
				  endcase
			end // enable_signals
			
			 // current_state registers
			always@(posedge clk)
			begin: state_FFs
				  if(!resetn)
						current_state <= S_LOAD_X;
				  else
						current_state <= next_state;
			end // state_FFS

endmodule 