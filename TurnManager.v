//The module that manages whose turn it is

module TurnManager(
				input TurnManagerEn, //make sure nextTurn signal only goes high when all pieces that need to be changed are changed.
				input clk,
				input resetn,
				
				output reg TurnManagerColour
				);
	localparam 	black = 1'b0,
					white = 1'b1;
	
	always@(posedge clk)
	begin
		if (resetn)
			TurnManagerColour <= black; //start as black
		else if (TurnManagerEn)
			TurnManagerColour <= ~TurnManagerColour;
	end

endmodule 

