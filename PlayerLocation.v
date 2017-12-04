module PlayerLocation(
							input clk,
							input moveEn,
							input moveRightEn,
							input moveLeftEn,
							input moveUpEn,
							input moveDownEn,
							input reset,
							
							output reg [2:0] currentX,
							output reg [2:0] currentY
							);
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			currentX <= 3'b100;
			currentY <= 3'b100;
		end else if (moveEn) begin
			if (moveRightEn && currentX < 3'b111) 
				currentX <= currentX + 1;
			else if (moveLeftEn && currentX > 3'b000)
				currentX <= currentX - 1;
			else if (moveUpEn && currentY > 3'b000)
				currentY <= currentY - 1;
			else if (moveDownEn && currentY < 3'b111)
				currentY <= currentY + 1;
		end
	end
			
endmodule 