//The module that manages whose turn it is

module TurnManager(
				input initialize,
				input nextTurn, //make sure nextTurn signal only goes high when all pieces that need to be changed are changed.
				input clk,
				input resetn
				
				output reg whiteOrBlack
				);
	localparam 	black = 1'b0,
					white = 1'b1;
	
	always@(posedge clk, posedge nextTurn)
	begin
		if (initialize)
			whiteOrBlack <= black; //start as black
		if (resetn)
			whiteOrBlack <= black;
		else if (nextTurn)
			whiteOrBlack <= ~whiteOrBlack;
	end

endmodule 

