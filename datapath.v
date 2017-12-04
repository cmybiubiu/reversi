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
	
	//Need 3D array of board. board is 8x8 node and stores a 2 bit value per node
	//Example: board[y][x][1:0] returns the 2 bit value at coord (x,y)
	reg [1:0] board[7:0][7:0];
	
	//add variables, regs, and wires here
	
	//add go multiplexer here
	
	//add writeEn multiplexer here
	
	//add datapath_out_colour multiplexer here
	
	
	//draws and flips pieces
	drawPiece();
	
	//draws and erases current position highlight when player moves, and also changes colour of the highlight
	//also updates x and y
	moveHiglight();
	
	//When enter is pressed, checks if player can place a piece down
	checkIfValidMove();
	
	//checks whose turn it is aka. controls datapath_out_colour, depending on mux
	TurnManager();
	
	//draw the initial board
	drawboard();
	
	//keeps track of where the Highlight is
	PlayerLocation();
	
	//updates the board when a piece is placed
	place();
	
	//when a piece is placed, flips all possible pieces, outputs an updated board and draws each flip 1 at a time
	flip();
	
	//Keeps track of the score
	ScoreManager();
	
	//draws the score
	drawScore();
	
	//endgame should remove the highlight of the current player position
	removeHighlight();
	
	//No input, happens after Display_Winner_Wait
	clearPieces();
	
			
endmodule 