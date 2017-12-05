module datapath(
			//should be input to most, if not all modules
			input clk,
			//resetn should be activated from control and should reset most, if not all modules.
			input resetn,
			
			input ld_colour, ld_x, ld_y,
			input writeEn,
			input [7:0] current_state,
			
			//these feed into moveHiglight
			input enterEn,
			input moveRightEn,
			input moveLeftEn,
			input moveUpEn,
			input moveDownEn
			
			//bit coordinates sent to the VGA to be drawn
			output reg [7:0] datapath_out_x, datapath_out_y,
			
			//datapath_out_colour depends on state (multiplexer)
			output reg [2:0] datapath_out_colour
			
			//most modules will have an output go, which go signal is used depends on current_state (multiplexer)
			output reg go;
			);
	//current coordinate location of the player on the screen		
	reg [7:0] x;
	reg [6:0] y;
	
	//Could use ram for this?
	reg [127:0] board;
	
	//add variables, regs, and wires here
	
	//add go multiplexer here
	
	//add datapath_out_colour multiplexer here
	
	//data_path_out_ coords multiplexer here
	
	
	
	//draws and flips pieces
	drawPiece();
	
	//inputs of moveRightEn, moveUpEn, etc. Updates x and y, outputs feed into moveHiglight
	updateXYCoord();
	
	//draws and erases current position highlight when player moves, and also changes colour of the highlight
	//outputs erase old position coordinates and feeds them into itself.
	moveHiglight();
	
	moveXYCoord();
	
	//When enter is pressed, checks if player can place a piece down. Also checks for all possible flips.
	checkIfValidMove();
	
	//checks whose turn it is aka. controls datapath_out_colour, depending on mux
	TurnManager();
	
	//draw the initial board
	drawBoard();
	
	//draws the starting 4 pieces at the center of the board
	drawInitialPieces();
	
	//keeps track of where the Highlight is
	PlayerLocation();
	
	//updates the board when a piece is placed
	place();
	
	//when a piece is placed, flips all possible pieces, Takes input from checkIfValidMove()
	//outputs an updated board and draws each flip 1 at a time
	flip();          
	
	//Keeps track of the score
	ScoreManager();
	
	//draws the score
	drawScore();
	
	//endgame should remove the highlight of the current player position
	removeHighlight();
	
	//No input, happens after Display_Winner_Wait
	clearPieces();
	
	//determines whether or not a player has a turn. If determineOpponent is 1, determines the turn of opposite colour of
	//the output from TurnManager. If determineCurrent is 1, determines the turn of current colour from the output of TurnManager.
	determineHasTurn();
	
	//Some reset processes may (not sure about this) take time, 
	//so this will take in the reset complete signals of those modules and output a general reset complete
	determineResetComplete();
			
endmodule 