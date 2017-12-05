//interprets the output of the keyboard_press_driver.v file

module KeyBoardInterpreter(input valid,
									input makeBreak,
									input [7:0] outCode,
									input clk,
									
									output reg enter,
									output reg moveRight,
									output reg moveLeft,
									output reg moveUp,
									output reg moveDown
									);

	always @(posedge valid, posedge clk)
	begin: enable_signals
		enter <= 0;
		moveRight <= 0;
		moveLeft <= 0;
		moveUp <= 0;
		moveDown <= 0;
		if (valid && makeBreak) begin
			case(outCode)
				8'h5A: enter <= 1;
				8'h74: moveRight <= 1;
				8'h6B: moveLeft <= 1;
				8'h75: moveUp <= 1;
				8'h72: moveDown <= 1;
			endcase
		end
	end							
endmodule 