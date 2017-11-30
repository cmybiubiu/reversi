

module reversi(
			input clk,
			input resetn,
			input [2:0]x,
			input [2:0]y,
			input go,
			
			output reg [191:0] board_result
			);

	//position on the board
	wire position = y*8 + x;
	wire index = position*3;
	
	// position on the screen , still need to calculate.
	wire [7:0]real_x;
	wire [6:0]real_y;
	wire [2:0]real_colour;
	wire writen; // allow to draw.

	// initial the board.   000 empty; 100 enable; 110 white; 111 black.
	reg [191:0]  board, next_board;
	reg  check_enable, put_enable, reverse_enable, draw_enable; 

	always@(posedge clk)
		begin: 
			if(resetn)  // initial the board.
				board <= {27{3'b000}, 3'b110, 3'b111, 6{3'b000}, 3'b111, 3'b110, 27{3'b000}};		
			else
				board <= next_board;
		end
		
	game_process g0 (.clk(clk),
					 .resetn(resetn),
					 .go(go),
					 .check_enable(),
					 .put_enable(),
					 .reverse_enable(),
					 .draw_enable()
					 );
					 
	
		
endmodule

//Determinate the state of this game (also the board)
module game_process (clk, resetn, go, check_enable, put_enable, reverse_enable, draw_enable);
	input clk;
	input resetn;
	input go;

	output reg  check_enable, put_enable, reverse_enable, draw_enable;

	reg [2:0] curr_state, next_state; 
	

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
	
	always@()
	begin
			check_enable <= 1'b0;
			put_enable <= 1'b0;
			reverse_enable <= 1'b0;
			draw_enable <= 1'b0;
		case (curr_state)
			CHECK_ENABLE: check_enable <= 1'b1;
			PUT_DOWN : put_enable <= 1'b1;
			REVERSE : reverse_enable <= 1'b1;
			FINSIH : draw_enable <= 1'b1;
		endcase
		
	end
	
	
	always @(*)
	begin
		if (!resten)
			curr_state <= next_state;
		else 
			curr_state <= ENABLE;
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
	
	localparam EMPTY = 3'b000,
				  ENABLE = 3'b100,
				  BLACK = 3'b111,
				  WHITE = 3'b110;

	
	// SET the next state of this node
	always @(*)
	begin: state_table
			case (curr)
				EMPTY: next_state = play ?  ENABLE : EMPTY;
				ENABLE: begin 
								if (play) 
									begin
										if (set_black)
											next_state = BLACK;
										else 
											next_state = WHITE;
									end
								else 
									next_state = ENABLE;
						  end
				BLACK : next_state = (reverse && play ) ? WHITE : BLACK;
				WHITE : next_state = (reverse && play ) ? BLACK : WHITE;
				default:next_state = EMPTY;
			endcase
	end 
endmodule  
