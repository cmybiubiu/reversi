module checkIfValidMoveBobin(
								input [2:0] x,
								input [2:0] y,
								input checkIfValidMoveEn,
								input [3:0] q,
								input resetn,
								input clk,
								input blackWhite,
								
								output reg wren,
								output reg address,
								output reg [3:0] data,
								output reg validMove,
								output reg checkIfValidMoveDone,
								output reg [7:0] validDirs 
								);
			reg [2:0] direction;
			reg checkDirDone;
			reg xAdd, yAdd, xMinus, yMinus;
			reg [5:0] tempAddress;
			reg upperLower;
			
			localparam 	right =		3'b000,
							upRight =	3'b001,
							up =			3'b010,
							upLeft = 	3'b011,
							left = 		3'b100,
							downLeft = 	3'b101,
							down = 		3'b110,
							downRight = 3'b111;
							
			
			always @(*)
			begin
				if (resetn)
				begin
					tempAddress = x + y*8;
					upperLower = 0;
				end
				else if (checkIfValidMoveEn)
				begin
					tempAddress = x + xAdd - xMinus + (y + yAdd - yMinus)*8;
					if (tempAddress < 32)
					begin
						address <= tempAddress;
						upperLower = 0;
					end
					else 
					begin
						address <= tempAddress - 31;
						upperLower = 1;
					end
				end
			end
			
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
					xMinus <= 0;
					yMinus <= 0;
					tempAddress <= 0;
				end
				else if (checkIfValidMoveEn)
				begin
					if (direction == right)
					begin
						if (x < 7 & xAdd == 0)
							xAdd <= 1;
						else if (xAdd < (7-x) & upperLower == 0)
							if (q[upperLower*2 +: 2] == {1, ~blackWhite})
							begin
								xAdd <= xAdd + 1;
							end
							else if (q[upperLower*2 +: 2] == {1, blackWhite})
							begin 
								validDirs[direction] <= 1;
								direction <= direction + 1;
								xAdd <= 0;
							end
							else
							begin
								direction <= direction + 1;
								xAdd <= 0;
							end
						end	
					end
					else if (direction = upRight)
					begin
						if (x < 7 & y > 0 & xAdd == 0 & yMinus == 0)
							xAdd <= 1;
							yMinus <= 1;
						else if (xAdd < (7-x) & yMinus < y & upperLower == 0)
							if (q[upperLower*2 +: 2] == {1, ~blackWhite})
							begin
								xAdd <= xAdd + 1;
								yMinus <= yMinus + 1;
							end
							else if (q[upperLower*2 +: 2] == {1, blackWhite})
							begin 
								validDirs[direction] <= 1;
								direction <= direction + 1;
								xAdd <= 0;
								yMinus <= 0;
							end
							else
							begin
								direction <= direction + 1;
								xAdd <= 0;
								yMinus <= 0;
							end
						end
					end
					else if (direction = up)
					begin
						if (y > 0 & yMinus == 0)
							yMinus <= 1;
						else if (yMinus < y & upperLower == 0)
							if (q[upperLower*2 +: 2] == {1, ~blackWhite})
							begin
								yMinus <= yMinus + 1;
							end
							else if (q[upperLower*2 +: 2] == {1, blackWhite})
							begin 
								validDirs[direction] <= 1;
								direction <= direction + 1;
								yMinus <= 0;
							end
							else
							begin
								direction <= direction + 1;
								yMinus <= 0;
							end
						end
					end
					else if (direction = upLeft)
					begin
						if (x > 0 & y > 0 & xMinus == 0 & yMinus == 0)
							xMinus <= 1;
							yMinus <= 1;
						else if (xMinus < x & yMinus < y & upperLower == 0)
							if (q[upperLower*2 +: 2] == {1, ~blackWhite})
							begin
								xMinus <= xMinus + 1;
								yMinus <= yMinus + 1;
							end
							else if (q[upperLower*2 +: 2] == {1, blackWhite})
							begin 
								validDirs[direction] <= 1;
								direction <= direction + 1;
								xMinus <= 0;
								yMinus <= 0;
							end
							else
							begin
								direction <= direction + 1;
								xMinus <= 0;
								yMinus <= 0;
							end
						end
					end
					else if (direction = upLeft)
					begin
						if (x > 0 & xMinus == 0)
							xMinus <= 1;
						else if (xMinus < x & upperLower == 0)
							if (q[upperLower*2 +: 2] == {1, ~blackWhite})
							begin
								xMinus <= xMinus + 1;
							end
							else if (q[upperLower*2 +: 2] == {1, blackWhite})
							begin 
								validDirs[direction] <= 1;
								direction <= direction + 1;
								xMinus <= 0;
							end
							else
							begin
								direction <= direction + 1;
								xMinus <= 0;
							end
						end
					end
							
						
						
						
endmodule 