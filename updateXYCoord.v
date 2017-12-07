module updateXYCoord(
						input [2:0] currentXCoord,
						input [2:0] currentYCoord,
						input clk,
						input moveRightEn,
						input moveLeftEn,
						input moveUpEn,
						input moveDownEn,
						
						
						output reg [2:0] nxtXCoord,
						output reg [2:0] nxtYCoord
						);
		always @(posedge clk)
		begin
			if (moveRightEn& (currentXCoord < 7))
			begin
				nxtXCoord <= currentXCoord + 1;
			end
			else if (moveLeftEn& (currentXCoord > 0))
			begin
				nxtXCoord <= currentXCoord - 1;
			end
			else if (moveUpEn & (currentYCoord > 0))
			begin
				nxtYCoord <= currentYCoord - 1;
			end
			else if (moveDownEn& (currentYCoord < 7))
			begin
				nxtYCoord <= currentYCoord + 1;
			end
		end
endmodule 