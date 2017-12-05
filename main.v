`include "KeyBoardInterpreter.v"
`include "control.v"
`include "datapath.v"
//Top Level Module

module main (  // draw single node (square)
		input			CLOCK_50;				//	50 MHz
		input   [9:0]   SW;
		input   [3:0]   KEY;
		
		//inputs for keyboard_press_driver
		input    PS2_DAT, // PS2 data line
		input    PS2_CLK, // PS2 clock line

	// Declare your inputs and outputs here
	// Do not change the following outputs
		output			VGA_CLK;   				//	VGA Clock
		output			VGA_HS;					//	VGA H_SYNC
		output			VGA_VS;					//	VGA V_SYNC
		output			VGA_BLANK_N;				//	VGA BLANK
		output			VGA_SYNC_N;				//	VGA SYNC
		output	[9:0]	VGA_R;   				//	VGA Red[9:0]
		output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
		output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
		);

	

	wire resetn;

	//wires from keyboard press diver to KeyBoardInterpreter
	wire valid, makeBreak;
	wire [7:0] outCode;
	
	//wires from KeyBoardInterpreter to Controller
	wire enter, moveRight, moveLeft, moveUp, moveDown;
	
	// wires from datapath to vga_adapter excluding resetn
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	
	//wires from datapath to control
	wire go;
	wire validMove;
	wire hasTurn;
	
	//wires from control to datapath
	wire resetn, writeEn, drawBoardEn, drawInitialPiecesEn, enterEn, moveRightEn, moveLeftEn, moveUpEn, moveDownEn;
	wire moveHighlightEn, checkIfValidMoveEn, placeEn, flipEn, scoreManagerEn, determineHasTurnEn;
	wire determineOpponent, determineCurrent, TurnManagerEn, removeHiglightEN,
	wire [8:0] current_state

	// Create an Instance of a VGA controller - there can be only one!
	// Define th    // Next state logic aka our state table number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(!resetn), //vga adapter has active low reset, while rest of code has active active high reset
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "green.mif";

	keyboard_press_driver kpd(
							//input
							.CLOCK_50(CLOCK_50), 
							
							//output
							.valid(valid), 
							.makeBreak(makeBreak),
							.outCode(outCode),
							
							//input
							.PS2_DAT(PS2_DAT),
							.PS2_CLK(PS2_CLK),
							.reset(resetn)
							);
	
	//connect outputs of kpd to kbi
	//output ofs kbi goes to both c0 and d0
	KeyBoardInterpreter kbi(
							//input
							.valid(valid),
							.makeBreak(makeBreak),
							.outCode(outCode),
							.clk(CLOCK_50),
							
							//output
							.enter(enter),
							.moveRight(moveRight),
							.moveLeft(moveLeft),
							.moveUp(moveUp),
							.moveDown(moveDown)
							);
	
	control c0(
			//input
			.clk(CLOCK_50),
			.go(go),
			.validMove(validMove),
			.hasTurn(hasTurn),
			.enter(enter), 
			.moveRight(moveRight), 
			.moveLeft(moveLeft), 
			.moveUp(moveUp), 
			.moveDown(moveDown),
			
			//output
			.resetn(resetn),
			.writeEn(writeEn),
			.drawBoardEn(drawBoardEn),
			.drawInitialPiecesEn(drawInitialPiecesEn),
			.enterEn(enterEn),
			.moveRightEn(moveRightEn),
			.moveLeftEn(moveLeftEn),
			.moveUpEn(moveUpEn),
			.moveDownEn(moveDownEn),
			.moveHighlightEn(moveHighlightEn),
			.checkIfValidMoveEn(checkIfValidMoveEn),
			.placeEn(placeEn),
			.flipEn(flipEn),
			.scoreManagerEn(scoreManagerEn),
			.determineHasTurnEn(determineHasTurnEn),
			.determineOpponent(determineOpponent),
			.determineCurrent(determineCurrent),
			.TurnManagerEn(TurnManagerEn),
			.removeHiglightEn(removeHiglightEn),
			);
	
	datapath d0(
			//input
			.clk(CLOCK_50),

			.resetn(resetn),
			.writeEn(writeEn),
			.drawBoardEn(drawBoardEn),
			.drawInitialPiecesEn(drawInitialPiecesEn),
			.enterEn(enterEn),
			.moveRightEn(moveRightEn),
			.moveLeftEn(moveLeftEn),
			.moveUpEn(moveUpEn),
			.moveDownEn(moveDownEn),
			.moveHighlightEn(moveHighlightEn),
			.checkIfValidMoveEn(checkIfValidMoveEn),
			.placeEn(placeEn),
			.flipEn(flipEn),
			.scoreManagerEn(scoreManagerEn),
			.determineHasTurnEn(determineHasTurnEn),
			.determineOpponent(determineOpponent),
			.determineCurrent(determineCurrent),
			.TurnManagerEn(TurnManagerEn),
			.removeHiglightEn(removeHiglightEn),
			
			//output
			.datapath_out_x(x), 
			.datapath_out_y(y),
			
			.datapath_out_colour(colour),
			
			.go(go),
			.validMove(validMove),
			.hasTurn(hasTurn)
			);

endmodule 