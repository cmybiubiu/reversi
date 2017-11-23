//the module that keeps track of the score

module ScoreManager(
					input initialize, //assign in FSM
					input [191:0] curr_board,
					input clk,
					input resetn,
					input nextTurn, //rename to enable signal?
							
					output reg [63:0] score_white,
					output reg [63:0] score_black,
					output reg count_done
					);
	reg count_enable; //enable signal for counting
	reg [63:0] counter_white;
	reg [63:0] counter_black;
	reg [191:0] counter;
	
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
		counter_white <= 0;
		counter_black <= 0;
		counter <= 0;
		count_done <= 0;
		if (resetn) begin
			counter_white <= 0;
			counter_black <= 0;
			count_enable <= 0;
			counter <= 0;
		end
		else if (counter == 191) begin
			counter_white <= 0;
			counter_black <= 0;
			count_done <= 1;
			counter <= 0;
			
		end
		else if (count_enable| counter != 0) begin
			counter <= counter + 3;
			if (curr_board[counter+:2] == 3'b110) //Using Verilog feature called "Variable Part Select." Syntax curr_board[x+:i] where x is the variable and i is the length of the binary number that you want.
				counter_white <= counter_white + 1;
			else if (curr_board[counter+:2] == 3'b111)
				counter_black <= counter_black+ 1;
		end
		else if (count_done) begin
			score_white <= counter_white;
			score_black <= counter_black;
		end
	end

endmodule 