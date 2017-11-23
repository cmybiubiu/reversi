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
