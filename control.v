//Basic Outline, from Lab7 part2, needs to be changed

module control(
			input clk,
			input resetn,
			input go,
			input validMove,
			input hasTurn
			input enter, moveRight, moveLeft, moveUp, moveDown,
			
			output reg writeEn,
			output reg drawBoardEn,
			output reg enterEn,
			output reg moveRightEn,
			output reg moveLeftEn,
			output reg moveUpEn,
			output reg moveDownEn,
			output reg moveHighlightEn,
			output reg checkIfValidMoveEn,
			output reg placeEn,
			output reg flipEn,
			output reg scoreManagerEn,
			output reg determineHasTurnEn,
			output reg determineOpponent,
			output reg determineCurrent,
			output reg TurnManagerEn,
			output reg removeHiglightEN,
			
			output reg [8:0] current_state
			);
			
			reg [8:0] next_state; 
    
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
							TO_DEtERMINE_OPPONENT	= 9'b010100111, //intermediate state
							DETERMINE_OPPONENT_HAS_TURN = 9'b010110111,
							OPPONENT_HAS_TURN 		= 9'b000110111,
							DETERMINE_CURRENT_HAS_TURN = 9'b000010111,
							CURRENT_HAS_TURN 			= 9'b000011111,
							TO_SWITCH_TURN_1			= 9'b000111111, //intermediate state
							TO_SWITCH_TURN_2 			= 9'b000111101, //intermediate state
							TO_SWITCH_TURN_3 			= 9'b000111001, //intermediate state
							SWITCH_TURN 				= 9'b000011001, 
							END_GAME 					= 9'b001011111, //Remove Highlight in this state
							DISPLAY_WINNER 			= 9'b001001111,
							DISPLAY_WINNER_WAIT 		= 9'b001000111,
							CLEAR_PIECES 				= 9'b001000011;
							
							
							
			// Next state logic aka our state table
			always @(*)
			begin: state_table
					case (current_state)	
						INITIALIZE:        		next_state = INITIAL_RESET;
						TO_INITIAL_RESET: 		next_state = INITIAL_RESET;
						INITIAL_RESET:   			next_state = go ? INITIAL_DRAW_BOARD : INITIAL_RESET; //can potenetially remove this go signal
						INITIAL_DRAW_BOARD:   	next_state = go ? INITIAL_DRAW_PIECES : INITIAL_DRAW_BOARD;
						INITIAL_DRAW_PIECES: 	next_state = go ? WAIT_FOR_INPUT : INITIAL_DRAW_PIECES;
						WAIT_FOR_INPUT: begin 	
														case({enter, moveRight, moveLeft, moveUp, moveDown})
															5'b00001: next_state = TO_MOVE_DOWN;
															5'b00010: next_state = TO_MOVE_UP:
															5'b00100: next_state = TO_MOVE_LEFT:
															5'b01000: next_state = TO_MOVE_RIGHT;
															5'b10000: next_state = CHECK_IF_VALID_MOVE;
															default: next_state = WAIT_FOR_INPUT;
														endcase
											 end 
						TO_MOVE_RIGHT: 			next_state = MOVE_RIGHT;
						MOVE_RIGHT: 				next_state = DRAW_MOVE;
						TO_MOVE_LEFT: 				next_state = MOVE_LEFT;
						MOVE_LEFT: 					next_state = DRAW_MOVE;
						TO_MOVE_UP: 				next_state = MOVE_UP;
						MOVE_UP: 					next_state = DRAW_MOVE;
						TO_MOVE_DOWN: 				next_state = MOVE_DOWN;
						MOVE_DOWN: 					next_state = DRAW_MOVE;
						DRAW_MOVE: 					next_state = go ? WAIT_FOR_INPUT : DRAW_MOVE;
						CHECK_IF_VALID_MOVE: 	next_state = go ? AFTER_CHECK_IF_VALID : CHECK_IF_VALID_MOVE;
						AFTER_CHECK_IF_VALID:	next_state = validMove ? PLACE_AND_DRAW_PIECE : TO_DISPLAY_INVALID_1;
						TO_DISPLAY_INVALID_1: 	next_state = TO_DISPLAY_INVALID_2;
						TO_DISPLAY_INVALID_2: 	next_state = DISPLAY_INVALID;
						DISPLAY_INVALID: 			next_state = go ? DISPLAY_INVALID_WAIT : DISPLAY_INVALID; //for now, make go = 1 always.
						DISPLAY_INVALID_WAIT: 	next_state = go ? ERASE_INVALID : DISPLAY_INVALID_WAIT; //for now, make go = 1 always.
						ERASE_INVALID: 			next_state = go ? WAIT_FOR_INPUT : ERASE_INVALID; //for now, make go = 1 always.
						PLACE_AND_DRAW_PIECE: 	next_state = go ? FLIP_AND_DRAW_PIECES : PLACE_AND_DRAW_PIECE;
						FLIP_AND_DRAW_PIECES: 	next_state = go ? UPDATE_SCORE : FLIP_AND_DRAW_PIECES;
						UPDATE_SCORE:				next_state = go ? DRAW_SCORE : UPDATE_SCORE;
						DRAW_SCORE: 				next_state = go ? TO_DETERMINE_OPPONENT_HAS_TURN : DRAW_SCORE; //for now, make go = 1 always.
						TO_DETERMINE_OPPONENT: 	next_state = DETERMINE_OPPONENT_HAS_TURN; 
						DETERMINE_OPPONENT_HAS_TURN: next_state = go ? OPPONENT_HAS_TURN : DETERMING_OPPONENT_HAS_TURN;
						OPPONENT_HAS_TURN: 		next_state = hasTurn ? TO_SWITCH_TURN_1 : DETERMINE_CURRENT_HAS_TURN;
						DETERMINE_CURRENT_HAS_TURN: next_state = go ? CURRENT_HAS_TURN : DETERMINE_CURRENT_HAS_TURN;
						CURRENT_HAS_TURN: 		next_state = hasTurn ? WAIT_FOR_INPUT : END_GAME;
						TO_SWITCH_TURN_1:			next_state = TO_SWITCH_TURN_2;
						TO_SWITCH_TURN_2: 		next_state = TO_SWITCH_TURN_3;
						TO_SWITCH_TURN_3: 		next_state = SWITCH_TURN;
						SWITCH_TURN: 				next_state = go ? WAIT_FOR_INPUT : SWITCH_TURN;
						END_GAME: 					next_state = go ? DISPLAY_WINNER : END_GAME;
						DISPLAY_WINNER: 			next_state = go ? DISPLAY_WINNER_WAIT : DISPLAY_WINNER; //for now, make go = 1 always.
						DISPLAY_WINNER_WAIT: 	next_state = enter ? CLEAR_PIECES : DISPLAY_WINNER_WAIT; //for now, make go = 1 always.
						CLEAR_PIECES: 				next_state = go ? INITIAL_RESET : CLEAR_PIECES;
						default: next_state = INITIALIZE;
					endcase
			end
			
			//datapath control signals
			always @(*)
			begin: enable_signals
				  // By default make all signals 0
				  writeEn = 1'b0;
				  drawBoardEn = 1'b0;
				  moveRightEn = 1'b0;
				  moveLeftEn = 1'b0;
				  moveUpEn = 1'b0;
				  moveDownEn = 1'b0;
				  moveHighlightEn = 1'b0;
				  checkIfValidMoveEn = 1'b0;
				  placeEn = 1'b0;
				  flipEn = 1'b0;
				  scoreManagerEn = 1'b0;
				  determineHasTurnEn = 1'b0;
				  determineOpponent = 1'b0;
				  determineCurrent = 1'b0;
				  TurnManagerEn = 1'b0;
				  removeHiglightEN = 1'b0;
				  
				  case (current_state)
						INITIALIZE: //let all enable signals start off at 0
						INITIAL_RESET: begin
								resetn = 1'b1;
								end
						INITIAL_DRAW_BOARD: begin
								drawBoardEn = 1'b1;
								writeEn = 1'b1;
								end
						INITIAL_DRAW_PIECES: begin
								drawInitalPiecesEn = 1'b1;
								writeEn = 1'b1;
								end
						MOVE_RIGHT: begin
								moveRightEn = 1'b1;
								end
						MOVE_LEFT: begin
								moveLeftEn = 1'b1;
								end
						MOVE_UP: begin
								moveUpEn = 1'b1;
								end
						MOVE_DOWN: begin
								moveDownEn = 1'b1;
								end
						DRAW_MOVE: begin
								moveHighlightEn = 1'b1;
								end
						CHECK_IF_VALID_MOVE: begin
								checkIfValidMoveEn = 1'b1;
								end
						DISPLAY_INVALID: //enables display invalid message, placeholder
						DISPLAY_INVALID_WAIT: //enables timer that lasts 1 second, placeholder
						ERASE_INVALID: //enables erase invalid message, placeholder
						PLACE_AND_DRAW_PIECE: begin
								placeEN = 1'b1;
								writeEn = 1'b1;
								end
						FLIP_AND_DRAW_PIECES: begin
								flipEn = 1'b1;
								writeEn = 1'b1;
								end
						UPDATE_SCORE: begin
								scoreManagerEn = 1'b1;
								end
						DRAW_SCORE: //enables score to be erased and then updated, placeholder
						DETERMINE_OPPONENT_HAS_TURN: begin
								determineOpponent = 1'b1;
								determineHasTurnEn = 1'b1;
								end
						DETERMINE_CURRENT_HAS_TURN: begin
								determineCurrent = 1'b1;
								determineHasTurnEN = 1'b1;
								end
						SWITCH_TURN: begin
								TurnManagerEn = 1'b1;
								end
						END_GAME: begin
								removeHiglightEn = 1'b1;
								writeEn = 1'b1;
								end
						DISPLAY_WINNER: //enables score to be erased and then updated, placeholder
						DISPLAY_WINNER_WAIT: //enables score to be erased and then updated, placeholder
						CLEAR_PIECES: begin
								clearPiecesEn = 1'b1;
								writeEn = 1'b1;
								end
				  endcase
			end // enable_signals
			
			 // current_state registers
			 //resetn is handled in the FSM
			always@(posedge clk)
			begin: state_FFs
				current_state <= next_state;
			end // state_FFS

endmodule 