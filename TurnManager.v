//The module that manages whose turn it is

module TurnManager(
				input TurnManagerEn, //make sure nextTurn signal only goes high when all pieces that need to be changed are changed.
				input clk,
				input resetn,
				
				output reg blackWhite
				output reg [2:0] TurnManagerColour
				);
	localparam 	black = 1'b1,
					white = 1'b0;
	
	always@(posedge clk)
	begin
		if (resetn)
			TurnManagerColour <= black; //start as black
		else if (TurnManagerEn)
			TurnManagerColour <= ~TurnManagerColour;
	end
	
	always @(*)
	begin
		if (blackWhite == black)
			TurnManagerColour = 3'b000;
		else
			TurnManagerColour = 3'b111l
	end

endmodule 

