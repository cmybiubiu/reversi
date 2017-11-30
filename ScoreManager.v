//the module that keeps track of the score

module ScoreManager(
					input initialize, //assign in FSM
					input [191:0] curr_board,
					input clk,
					input resetn,
					input nextTurn, //rename to enable signal?
							
					output reg [5:0] score_white,
					output reg [5:0] score_black,
					output reg count_done
					);
	reg count_enable; //enable signal for counting
	reg [5:0] counter_white;
	reg [5:0] counter_black;
	reg [7:0] counter; //191 in binary is 10111111
	
	always @(posedge clk)
	begin
		count_enable <= 0;
		if (resetn|initialize) begin
			score_white <= 2;
			score_black <= 2;
		end
		else if (nextTurn)
			count_enable <= 1;
	end
			
	always @(posedge clk)
	begin
		if (resetn|initialize) begin
			counter_white <= 0;
			counter_black <= 0;
			count_enable <= 0;
			counter <= 0;
			count_done <= 0;
		end
		else if (counter == 192) begin //supposed to be 192 since the counter and counter_white/counter_black are iterated at the same time
			count_done <= 1;				//Thus counter_black/white is using the old counter value. ie when counter = 192, counter_black/white = old_counter_b/w + (192/3 - 1)
			counter <= 0;
			
		end
		else if (count_enable | counter != 0) begin
			counter <= counter + 3;
			if (curr_board[counter+:3] == 3'b110) //Using Verilog feature called "Variable Part Select." Syntax curr_board[x+:i] where x is the variable and i is the length of the binary number that you want.
				counter_white <= counter_white + 1;
			else if (curr_board[counter+:3] == 3'b111)
				counter_black <= counter_black+ 1;
		end
		else if (count_done) begin
			score_white <= counter_white;
			score_black <= counter_black;
			counter_white <= 0;
			counter_black <= 0;
			count_done <= 0;
		end
	end

endmodule 