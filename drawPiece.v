//colour is handled by turnManager
module drawPiece(
            input clk,
            input resetn,
            input [2:0] x,
            input [2:0] y,
				input drawPieceEn,

            output reg [7:0] drawPieceX,
            output reg [6:0] drawPieceY,
				output reg drawPieceDone
            );
	 //draws square pieces starting at the top left corner drawing horizontal lines first and then moving down.
	 //the coordinate of the top left most starting pixel is x = 10 + 4, y = 27 + 4
    wire [7:0] xRef;
	 wire [6:0] yRef;
	 assign xRef = 14;
	 assign yRef = 31;
	 reg [7:0] xAdd;
	 reg [6:0] yAdd;
	 
	 always @(*) 
	 begin
		if (resetn) 
		begin
			drawPieceX = xRef;
			drawPieceY = yRef;
		end
		else if (drawPieceEn)
		begin
			drawPieceX = xRef + (13 * x) + xAdd;
			drawPieceY = yRef + (13 * y) + yAdd;
		end
	 end
	 
	 always @(posedge clk)
    begin
        if (resetn | drawPieceDone) 
            begin
                xAdd <= 0;
                yAdd<= 0;
                drawPieceDone <= 1'b0;
            end
        else if (drawPieceEn)
		  begin
			  if (xAdd == 6 & yAdd == 6)
					begin
						 xAdd <= 0;
						 yAdd <= 0;
						 drawPieceDone <= 1'b1;
					end
			  else 
					begin 
						if (xAdd == 6)
						begin
							xAdd <= 0;
							yAdd <= yAdd + 1;
						end
						else
							xAdd <= xAdd + 1;
					end 
		  end
    end

endmodule 