module drawBoard(
				input drawBoardEn,
				input clk,
				input resetn,
				
				output [2:0] drawBoardColour,
				output reg [7:0] drawBoardX, drawBoardY,
				output reg drawBoardDone
				);
	//board width is 106 bits
	//line width is 2 bits
	reg [7:0] x;
	reg [6:0] y;
	reg [7:0] xAdd;
	reg [6:0] yAdd;
	assign drawBoardColour = 3'b101;
	reg secondHalfHori; //second half of line width
	reg vertical;
	reg secondHalfVert;
	
	always @(*) begin
		x = 27;
		y = 10; //coordinates for top left corner of board
		if (resetn) begin
			drawBoardX = x;
			drawBoardY = y;
			end
		else if (drawBoardEn) begin
			drawBoardX = x + xAdd;
			drawBoardY = y + yAdd;
		end
	end
			
	always @(posedge clk) begin
		if (resetn | drawBoardDone) begin
			xAdd <= 0;
			yAdd <= 0;
			secondHalfHori <= 0;
			vertical <= 0;
			secondHalfVert <= 0;
			drawBoardDone <= 0;
			end
		else if (!secondHalfHori & !vertical & !secondHalfVert) begin
			if (yAdd == 104 & xAdd == 105) begin
				yAdd <= 1;
				secondHalfHori <= 1;
				end
			else if (drawBoardEn) begin
				if (xAdd == 105) begin
					xAdd <= 0;
					yAdd <= yAdd + 13;
					end
				else 
					xAdd <= xAdd + 1;
				end
			end
		else if (!vertical & !secondHalfVert) begin
			if (yAdd == 105 & xAdd == 105) begin
				yAdd <= 0;
				vertical <= 1;
				end
			else if (drawBoardEn) begin
				if (xAdd == 105) begin
					xAdd <= 0;
					yAdd <= yAdd + 13;
					end
				else 
					xAdd <= xAdd + 1;
				end
			end
		else if (!secondHalfVert) begin
			if (xAdd == 105 & yAdd == 104) begin
				xAdd <= 1;
				secondHalfVert <= 1;
				end
			else if (drawBoardEn) begin
				if (xAdd == 105) begin
					yAdd <= 0;
					xAdd <= xAdd + 13;
					end
				else 
					yAdd <= yAdd + 1;
				end
			end
		else begin
			if (xAdd == 105 & yAdd == 105) begin
				xAdd <= 0;
				drawBoardDone <= 1;
				end
			else if (drawBoardEn) begin
				if (xAdd == 105) begin
					yAdd <= 0;
					xAdd <= xAdd + 13;
					end
				else 
					yAdd <= yAdd + 1;
				end
			end
	end
			
endmodule 