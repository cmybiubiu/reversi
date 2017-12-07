module checkIfValidMoveBobin(
								input [2:0] x,
								input [2:0] y,
								input checkIfValidMoveEn,
								input [3:0] q,
								input resetn,
								input clk,
								
								output reg wren,
								output reg address,
								output reg [3:0] data,
								output reg validMove,
								output reg checkIfValidMoveDone,
								output reg [7:0] validDirs 
								);
			reg [2:0] direction;
			reg checkDirDone;
			reg xAdd, yAdd;
			localparam 	right =		3'b000,
							upRight =	3'b001,
							up =			3'b010,
							upLeft = 	3'b011,
							left = 		3'b100,
							downLeft = 	3'b101,
							down = 		3'b110,
							downRight = 3'b111;
							
			
			always @(posedge clk)
			begin
				if (resetn) 
				begin
					wren <= 0;
					address <= 0;
					data <= 0;
					validMove <= 0;
					checkIfValidMoveDone <= 0;
					validDirs <= 0;
					direction <= 0;
					checkDirDone <= 0;
					xAdd <= 0;
					yAdd <= 0;
				end
				else if (checkIfValidMoveEn)
				begin
					if (!checkDirDone)
					begin
						case (direction)
						right:		begin
											if (xAdd == (7 - x) )
											begin
												
						upRight:		3'b001,
						up:			3'b010,
						upLeft: 		3'b011,
						left:			3'b100,
						downLeft:	3'b101,
						down:			3'b110,
						downRight:	3'b111;
							
						
						
						
endmodule 