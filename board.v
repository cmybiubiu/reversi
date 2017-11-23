module reversi(clk, resetn, x, y, go, ... );
	input clk;
	input resetn;
	input x;
	input y;
	// 000 empty; 100 enable; 110 white; 111 black.

	// initial the board. 
	reg [191:0] board, next_board;

	always@(posedge clk)
		begin: 
			if(resetn)  // initial the board.
				board <= {27{3'b000}, 3'b110, 3'b111, 6{3'b000}, 3'b111, 3'b110, 27{3'b000}};		
			else
				board <= next_board;
		end // state_FFS
endmodule

module controll_node (clk, resetn, curr, play, set_black, next);


endmodule

module controll_node_state(clk, resetn, curr, play, reverse, set_black, next);
	input clk;
	inout resetn;
	input [8:0] curr;
	input play;
	input set_black;
	input reverse;
	output [8:0] next; 
	
	wire [5:0] position = curr[5:0];
	
	reg [2:0] curr_state, next_state;
	
	curr_state = curr;
	
	localparam EMPTY = 3'd0,
				  ENABLE = 3'd1,
				  BLACK = 3'd2,
				  WHITE = 3'd3;
	
	// SET the next state of this node
	always @(*)
	begin: state_table
			case (curr_state)
				EMPTY: next_state = play ?  ENABLE : EMPTY ;
				ENABLE: begin 
								if (play) 
									begin
										if (set_black)
											next_state = BALCK;
										else 
											next_state = white;
									end
								else 
									next_state = ENABLE;
						  end ;
				BLACK : next_state = reverse ? WHITE : BLACK;
				WHITE : next_state = reverse ? BLACK : WHITE;
						 
			endcase
	end
	               
	// current_state registers
	always@(posedge clk)
		begin: 
			  if(resetn)  // initial the node
					begin 
						if (position == 6'b011_011 || position == 6'b100_100)
							curr_state <= WHITE;
						else if (position == 6'b100_011|| position == 6'b011_100)
							curr_state <= BLACK;
						else 
							curr_state <= EMPTY;
					end 
					
			  else
					curr_state <= next_state;
		end // state_FFS
		
	assign next[8:6] = curr_state; 
	assign next[5:0] = position; 
endmodule  
