module drawInitialPieces(
					input clk,
					input drawInitialPiecesEn,
					input resetn,
					
					output reg [2:0] drawInitialPiecesX,
					output reg [2:0] drawInitialPiecesY,
					output reg [2:0] drawInitialPiecesColour,
					output reg drawInitialPiecesDone
					);
			wire [2:0] x;
			wire [2:0] y;
			assign x = 3;
			assign y = 3;
			reg xAdd;
			reg yAdd;

			always @(*)
			begin
				if (resetn)
				begin
					drawInitialPiecesX = x;
					drawInitialPiecesY = y;
				end
				if (drawInitialPiecesEn) 
				begin
					drawInitialPiecesX = x + xAdd;
					drawInitialPiecesY = y + yAdd;
				end
			end
			
			//white at top left square and bottom right square, black at top right square and bottom left square
			always @(posedge clk)
			begin
				if (resetn | drawInitialPiecesDone)
				begin
					drawInitialPiecesColour <= 3'b000;
					xAdd <= 0;
					yAdd <= 0;
					drawInitialPiecesDone <= 0;
				end
				else if (drawInitialPiecesEn)
				begin
					if (yAdd == 1 & xAdd == 1)
					begin
						drawInitialPiecesColour <= 3'b000;
						yAdd <= 0;
						xAdd <= 0;
						drawInitialPiecesDone <= 1;
					end
					else 
					begin
						if (xAdd == 1)
						begin
							drawInitialPiecesColour <= 3'b111;
							xAdd <= 0;
							yAdd <= yAdd + 1;
						end
						else
							drawInitialPiecesColour <= !drawInitialPiecesColour;
							xAdd <= xAdd;
					end
				end
			end
endmodule 