//interprets the output of the keyboard_press_driver.v file

module KeyBoardInterpreter(input valid,
									input makeBreak,
									input [7:0] outCode,
									input clk,
									
									output reg moveRightEn,
									output reg moveLeftEn,
									output reg moveUpEn,
									output reg moveDownEn
									);

	always @(posedge valid, posedge clk)
	begin: enable_signals
		moveRightEn <= 0;
		moveLeftEn <= 0;
		moveUpEn <= 0;
		moveDownEn <= 0;
		if (valid && makeBreak) begin
			case(outCode)
				8'h74: moveRightEn <= 1;
				8'h6B: moveLeftEn <= 1;
				8'h75: moveUpEn <= 1;
				8'h72: moveDownEn <= 1;
			endcase
		end
	end							
endmodule 