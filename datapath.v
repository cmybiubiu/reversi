`include "drawBoard.v"

module datapath(
			//should be input to most, if not all modules
			input clk,
			
			//resetn should be activated from control and should reset most, if not all modules.
			input resetn,
			input writeEn,
			input drawBoardEn,
			input drawInitialPiecesEn,
			input enterEn,
			input moveRightEn,
			input moveLeftEn,
			input moveUpEn,
			input moveDownEn,
			input moveHighlightEn,
			input checkIfValidMoveEn,
			input placeEn,
			input flipEn,
			input scoreManagerEn,
			input determineHasTurnEn,
			input determineOpponent,
			input determineCurrent,
			input TurnManagerEn,
			input removeHighlightEn,
			
			//bit coordinates sent to the VGA to be drawn
			output reg [7:0] datapath_out_x, 
			output reg [6:0] datapath_out_y,
			
			//datapath_out_colour depends on state (multiplexer)
			output reg [2:0] datapath_out_colour,
			
			//most modules will have an output go, which go signal is used depends on current_state (multiplexer)
			output reg go,
			output validMove,
			output hasTurn
			);
	//current coordinate location of the player on the screen		
	reg [2:0] x;
	reg [2:0] y;
	wire [2:0] nxtX, nxtY;
	
	always@(*)
	begin
		if (resetn)
		begin
			x = 3;
			y = 3;
		end
		else if (moveRightEn| moveLeftEn| moveUpEn|moveDownEn)
		begin
			x = nxtX;
			y = nxtY;
		end
	end
	
	//Could use ram for this?
	reg [127:0] board;
	
	//go wires
	wire resetDone, drawBoardDone, drawInitialPiecesDone, moveHighlightDone, checkIfValidMoveDone, placeDone;
	wire flipDone, ScoreManagerDone, determineHasTurnDone, TurnManagerDone, removeHighlightDone;
	
	//colour wires
	wire [2:0] drawBoardColour, drawInitialPiecesColour, moveHighlightColour, TurnManagerColour, removeHighlightColour;
	//x wires
	wire [7:0] drawBoardX, drawPieceX, moveHighlightX, removeHighlightX;
	//y wires
	wire [6:0] drawBoardY, drawPieceY, moveHighlightY, removeHighlightY;
	
	//x wires to drawPiece multiplexer
	wire [2:0] drawInitialPiecesX, flipX;
	//y wires to drawPiece multiplexer
	wire [2:0] drawInitialPiecesY, flipY;
	
	//wires from updateXYCoord to moveHighlight
	wire [2:0] oldXCoord, oldYCoord;
	
	//go selector
	always @(*) begin
		if (resetn)
			go = resetDone;
		else if (drawBoardEn)
			go = drawBoardDone;
		else if (drawInitialPiecesEn)
			go = drawInitialPiecesDone;
		else if (moveHighlightEn)
			go = moveHighlightDone;
		else if (checkIfValidMoveEn)
			go = checkIfValidMoveDone;
		else if (placeEn)
			go = placeDone;
		else if (flipEn)
			go = flipDone;
		else if (scoreManagerEn)
			go = ScoreManagerDone;
		else if (determineHasTurnEn)
			go = determineHasTurnDone;
		else if (TurnManagerEn)
			go = TurnManagerDone;
		else if (removeHighlightEn)
			go = removeHighlightDone;
		else
			go = 0;
	end
	
	//data_out_x, data_out_y, and data_out_colour selector
	always @(*) begin
		if (drawBoardEn) begin
			datapath_out_colour = drawBoardColour;
			datapath_out_x = drawBoardX;
			datapath_out_y = drawBoardY;
			end
		else if (drawInitialPiecesEn) begin
			datapath_out_colour = drawInitialPiecesColour;
			datapath_out_x = drawPieceX;
			datapath_out_y = drawPieceY;
			end
		else if (moveHighlightEn) begin
			datapath_out_colour = moveHighlightColour;
			datapath_out_x = moveHighlightX;
			datapath_out_y = moveHighlightY;
			end
		else if (placeEn | flipEn) begin
			datapath_out_colour = TurnManagerColour;
			datapath_out_x = drawPieceX;
			datapath_out_y = drawPieceY;
			end
		else if (removeHighlightEn) begin
			datapath_out_colour = removeHighlightColour;
			datapath_out_x = removeHighlightX;
			datapath_out_y = removeHighlightY;
			end
	end
	
	//wires to drawPiece
	reg [2:0] drawPieceInX, drawPieceInY;
	wire [2:0] drawPieceInXWire, drawPieceInYWire;
	assign drawPieceInXWire = drawPieceInX;
	assign drawPieceInYWire = drawPieceInY;
	//drawPieceInXY selector
	always @(*) begin
		if (drawInitialPiecesEn) begin
			drawPieceInX = drawInitialPiecesX;
			drawPieceInY = drawInitialPiecesY;
			end
		else if (placeEn) begin
			drawPieceInX = x; //current coords for x and y
			drawPieceInY = y;
			end
		else if (flipEn) begin
			drawPieceInX = flipX;
			drawPieceInY = flipY;
			end
	end
	
	wire [4:0] address;
	wire [3:0] data, q;
	wire wren;
	ram32x4 board(
					.address(address),
					.clock(clk),
					.data(data),
					.wren(wren),
					.q(q)
					);
	
	//draws and flips pieces. Need drawPieceEn and drawPieceDone signals
	//use as helper function?
	drawPiece dp0(
				.clk(clk),
            .resetn(resetn),
            .x(drawPieceInXWire),
            .y(drawPieceInYWire),
				.drawPieceEn(drawPieceEn),

            .drawPieceX(drawPieceX),
            .drawPieceY(drawPieceY),
				.drawPieceDone(drawPieceDone)
				);
	
	//inputs of moveRightEn, moveUpEn, etc. Updates x and y, outputs feed into moveHiglight
	updateXYCoord uxyc0(
					.currentXCoord(x),
					.currentYCoord(y),
					.clk(clk),
					.moveRightEn(moveRightEn),
					.moveLeftEn(moveLeftEn),
					.moveUpEn(moveUpEn),
					.moveDownEn(moveDownEn),
					.resetn(resetn),
					
					.oldXCoord(oldXCoord),
					.oldYCoord(oldYCoord),
					.nxtXCoord(nxtX),
					.nxtYCoord(nxtY)
					);

	//draws and erases current position highlight when player moves, and also changes colour of the highlight
	//outputs erase old position coordinates and feeds them into itself.
	moveHighlight mh0(
						.oldXCoord(oldXCoord),
						.oldYCoord(oldYCoord),
						.nxtXCoord(nxtX),
						.nxtYCoord(nxtY),
						.TurnManagerColour(TurnManagerColour),
						.resetn(resetn),
						.moveHighlightEn(moveHighlightEn),
						.clk(clk),
						
						.moveHighlightX(moveHighlightX),
						.moveHighlightY(moveHighlightY),
						.moveHighlightColour(moveHighlightColour),
						.moveHighlightDone(moveHighlightDone)
						);
	
	//When enter is pressed, checks if player can place a piece down. Also checks for all possible flips.
	//checkIfValidMove();
	
	//checks whose turn it is aka. controls datapath_out_colour, depending on mux
	TurnManager tm0(
				.TurnManagerEn(TurnManagerEn), 
				.clk(clk),
				.resetn(resetn),
				
				.TurnManagerColour(TurnManagerColour)
				);
	
	//draw the initial board
	drawBoard db0(
				.drawBoardEn(drawBoardEn),
				.clk(clk),
				.resetn(resetn),
				
				.drawBoardColour(drawBoardColour),
				.drawBoardX(drawBoardX), 
				.drawBoardY(drawBoardY),
				.drawBoardDone(drawBoardDone)
				);
	
	//draws the starting 4 pieces at the center of the board
	drawInitialPieces dip0(
					.clk(clk),
					.drawInitialPiecesEn(drawInitialPiecesEn),
					.resetn(resetn),
					
					.drawInitialPiecesX(drawInitialPiecesX),
					.drawInitialPiecesY(drawInitialPiecesY),
					.drawInitialPiecesColour(drawInitialPiecesColour),
					.drawInitialPiecesDone(drawInitialPiecesDone)
					);

	//updates the board when a piece is placed
	//place();
	placeSecond pl0( .x(x),
							.y(y),
							.placeEn(placeEn),
							.q(q),
							.resetn(resetn),
							.clk(clk),
							.player_black(blackWhite),
								
							.wren(wren),
							.address(address),
							.data(data),
							.placeeDone(placeDone)
							);
	
	//when a piece is placed, flips all possible pieces, Takes input from checkIfValidMove()
	//outputs an updated board and draws each flip 1 at a time
	//flip();          
	
	//Keeps track of the score
	//ScoreManager();
	
	//draws the score
	//drawScore();
	
	//Helper function used in drawInitialBoard and moveHighlight
	//drawHighlight();
	
	//endgame should remove the highlight of the current player position. Helper Function
	//removeHighlight();
	
	//No input, happens after Display_Winner_Wait
	//clearPieces();
	
	//determines whether or not a player has a turn. If determineOpponent is 1, determines the turn of opposite colour of
	//the output from TurnManager. If determineCurrent is 1, determines the turn of current colour from the output of TurnManager.
	//determineHasTurn();
	
	//Some reset processes may (not sure about this, might not need) take time, 
	//so this will take in the reset complete signals of those modules and output a general reset complete
	//determineResetComplete();
			
endmodule 