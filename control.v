//Basic Outline, from Lab7 part2, needs to be changed

module control(
			input clk,
			input resetn,
			input go,
			
			//add inputs from KeyBoardInterpreter here
			
			output reg ld_colour, ld_x, ld_y,
			output reg writeEn
			output reg enterEn,
			output reg moveRightEn,
			output reg moveLeftEn,
			output reg moveUpEn,
			output reg moveDownEn
			);
			
			reg [2:0] current_state, next_state; 
    
			localparam  S_LOAD_X        	= 3'd0,
							S_LOAD_X_WAIT   	= 3'd1,
							S_LOAD_Y_COL      = 3'd2,
							S_LOAD_Y_COL_WAIT = 3'd3;
							
			// Next state logic aka our state table
			always @(*)
			begin: state_table
					case (current_state)
						S_LOAD_X: next_state = gox ? S_LOAD_X_WAIT : S_LOAD_X;
						S_LOAD_X_WAIT: next_state = gox ? S_LOAD_X_WAIT : S_LOAD_Y_COL;
						S_LOAD_Y_COL: next_state = go ? S_LOAD_Y_COL_WAIT : S_LOAD_Y_COL;
						S_LOAD_Y_COL_WAIT: next_state = go ? S_LOAD_Y_COL_WAIT : S_LOAD_X;
						default: next_state = S_LOAD_X;
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