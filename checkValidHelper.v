module checkValidHelper (
        input clk,
        input resetn,
        input [2:0]x,
        input [2:0]y,
        input [2:0] direction,
        input [127:0] board,
        input player_black,

        output reg valid,
        output [5:0] end_point
        );
    
    reg [2:0] index1, index2;
    reg [6:0] index;
    wire [1:0] player = {1'b1, player_black}; 
    wire [1:0] opposite_player = {1'b1, ~player_black};
	 reg oppo_around = 0;
	 reg has_same = 0;

    always @ (posedge clk)
    begin
        if (resetn)
            valid <= 0;

        else
            begin            
                index1 <= x;
                index2 <= y;
					 index <= {y, x};
                case (direction)
                3'b000: begin  //vertically upper
                            if (y > 1)
                                begin 
                                    index2 <= y -1;
                                    index <= index - 16;
						
                                    if ( board[index + : 2] == opposite_player)
			
                                        begin
														  oppo_around <= 1;
														  
                                            valid <= 0;
                                            while (index2 != 0) 
                                                begin 
                                                    index2 <=  index2 -1;
                                                    index <= index - 16;
				
                                                    if (board[index + : 2] == player)
                                                        valid <= 1;
																		  has_same <= 1;
                                                end 
                                        end
                                    else 
                                        valid <= 0;
                                end

                            else 
                                valid <= 0; 
                        end

                3'b001: begin //vertically down
                            if (y < 6)
                                begin 
                                    index2 <= y + 1;
                                    index <= 8 * index2 + index1;
                                    if ( board[index + : 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while (index2 != 7) 
                                                begin 
                                                    index2 <=  index2 + 1;
                                                    index <= 8 * index2 + index1;
                                                    if (board[index + : 2] == player)
                                                        valid <= 1;
                                                end 
                                        end
                                    else 
                                        valid <= 0;
                                end

                            else 
                                valid <= 0; 
                        end
                
                3'b010: begin //horizontally left
                            if (x > 1)
                                begin 
                                    index1 <= x -1;
                                    index <= 8 * index2 + index1;
                                    if ( board[index + : 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while (index1 != 0) 
                                                begin 
                                                    index1 <=  index1 -1;
                                                     index <= 8 * index2 + index1;
                                                    if (board[index + : 2] == player)
                                                        valid <= 1;
                                                end 
                                        end
                                    else 
                                        valid <= 0;
                                end

                            else 
                                valid <= 0; 
                        end

                3'b011: begin // horizontally right 
                            if (x < 6)
                                begin 
                                    index1 <= x + 1;
                                    index <= 8 * index2 + index1;
                                    if ( board[index + : 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while (index1 != 0) 
                                                begin 
                                                    index1 <=  index1 + 1;
                                                    index <= 8 * index2 + index1;
                                                    if (board[index + : 2] == player)
                                                        valid <= 1;
                                                end 
                                        end
                                    else 
                                        valid <= 0;
                                end

                            else 
                                valid <= 0; 
                        end

                3'b100: begin  // left top
                            if ((y > 1) && (x > 1))
                                begin 
                                    index1 <= x -1;
                                    index2 <= y - 1;
                                    index <= 8 * index2 + index1;
                                    if ( board[index + : 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while ((index1 != 0) && (index2 != 0))
                                                begin 
                                                    index1 <=  index1 -1;
                                                    index2 <= index2 -1;
                                                    index <= 8 * index2 + index1;
                                                    if (board[index + : 2] == player)
                                                        valid <= 1;
                                                end 
                                        end
                                    else 
                                        valid <= 0;
                                end

                            else 
                                valid <= 0; 
                        end

                3'b101: begin // left bottom 
                            if ((y < 6) && (x > 1))
                                begin 
                                    index1 <= x -1;
                                    index2 <= y + 1;
                                    index <= 8 * index2 + index1;
                                    if ( board[index + : 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while ((index1 != 0) && (index2 != 7))
                                                begin 
                                                    index1 <=  index1 - 1;
                                                    index2 <= index2  + 1;
                                                    index <= 8 * index2 + index1;
                                                    if (board[index + : 2] == player)
                                                        valid <= 1;
                                                end 
                                        end
                                    else 
                                        valid <= 0;
                                end

                            else 
                                valid <= 0; 
                        end

                3'b110:begin // right top
                            if ((y > 1) && (x < 6))
                                begin 
                                    index1 <= x + 1;
                                    index2 <= y - 1;
                                    index <= 8 * index2 + index1;
                                    if ( board[index + : 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while ((index1 != 7) && (index2 != 0))
                                                begin 
                                                    index1 <=  index1 + 1;
                                                    index2 <= index2 - 1;
                                                    index <= 8 * index2 + index1;
                                                    if (board[index + : 2] == player)
                                                        valid <= 1;
                                                end 
                                        end
                                    else 
                                        valid <= 0;
                                end

                            else 
                                valid <= 0; 
                        end

                3'b111:begin //right bottom
                            if ((y < 6) && (x < 6))
                                begin 
                                    index1 <= x + 1;
                                    index2 <= y + 1;
                                    index <= 8 * index2 + index1;
                                    if ( board[index + : 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while ((index1 != 7) && (index2 != 7))
                                                begin 
                                                    index1 <=  index1 +1;
                                                    index2 <= index2 +1;
                                                    index <= 8 * index2 + index1;
                                                    if (board[index + : 2] == player)
                                                        valid <= 1;
                                                end 
                                        end
                                    else 
                                        valid <= 0;
                                end

                            else 
                                valid <= 0; 
                        end


                endcase
            end
    end

    assign end_point = {index1, index2};
	 
endmodule