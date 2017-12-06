module checkValidHelper (
        input clk,
        input resetn,
        input [2:0]x,
        input [2:0]y,
        input [2:0] direction,
        input [127:0] board,
        input player_black,

        output reg valid,
        output [5:0] end_point,
		  output reg checkDone
        );
    
    reg [2:0] curr_x, curr_y;
    reg [6:0] INDEX;
	 reg [1:0] curr_piece;
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
                curr_x <= x;
                curr_y <= y;
					 INDEX[6:1] <= {y, x};
					 INDEX[0] <= 1'b0;
					 curr_piece <= board[INDEX +: 2];
					 checkDone <= 0;
                case (direction)
                3'b000: begin  //vertically upper
									 checkDone <= 1;
                            if ((y > 1) && (curr_piece == 2'b00))
                                begin 
                                    curr_y <= curr_y - 1;
                                    INDEX <= INDEX - 16;
                                    if ( board[INDEX +: 2] == opposite_player)
			
                                        begin
														  oppo_around <= 1;
														  
                                            valid <= 0;
                                            while (curr_y > 0) 
                                                begin 
                                                    curr_y <=  curr_y -1;
                                                    INDEX <= INDEX - 16;
				
                                                    if (board[INDEX +: 2] == player)
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
									 checkDone <= 1;
                            if (y < 6)
                                begin 
                                    curr_y <= y + 1;
                                    INDEX <= INDEX + 16;
                                    if ( board[INDEX +: 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while (curr_y < 7) 
                                                begin 
                                                    curr_y <=  curr_y + 1;
                                                    INDEX <= INDEX + 16;
                                                    if (board[INDEX +: 2] == player)
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
									 checkDone <= 1;
                            if (x > 1)
                                begin 
                                    curr_x <= x -1;
                                    INDEX <= INDEX - 2;
                                    if ( board[INDEX +: 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while (curr_x > 0) 
                                                begin 
                                                    curr_x <=  curr_x -1;
                                                     INDEX <= INDEX - 2;
                                                    if (board[INDEX +: 2] == player)
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
									 checkDone <= 1;
                            if (x < 6)
                                begin 
                                    curr_x <= x + 1;
                                    INDEX <= INDEX + 2;
                                    if ( board[INDEX +: 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while (curr_x < 7) 
                                                begin 
                                                    curr_x <=  curr_x + 1;
                                                    INDEX <= INDEX + 2;
                                                    if (board[INDEX +: 2] == player)
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
									 checkDone <= 1;
                            if ((y > 1) && (x > 1))
                                begin 
                                    curr_x <= x - 1;
                                    curr_y <= y - 1;
                                    INDEX <= INDEX - 18;
                                    if ( board[INDEX +: 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while ((curr_x > 0) && (curr_y > 0))
                                                begin 
                                                    curr_x <=  curr_x -1;
                                                    curr_y <= curr_y -1;
                                                    INDEX <=  INDEX - 18;
                                                    if (board[INDEX +: 2] == player)
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
									 checkDone <= 1;
                            if ((y < 6) && (x > 1))
                                begin 
                                    curr_x <= x -1;
                                    curr_y <= y + 1;
                                    INDEX <= INDEX + 14;
                                    if ( board[INDEX +: 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while ((curr_x > 0) && (curr_y < 7))
                                                begin 
                                                    curr_x <=  curr_x - 1;
                                                    curr_y <= curr_y  + 1;
                                                    INDEX <= 8 * curr_y + curr_x;
                                                    if (board[INDEX +: 2] == player)
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
									 checkDone <= 1;
                            if ((y > 1) && (x < 6))
                                begin 
                                    curr_x <= x + 1;
                                    curr_y <= y - 1;
                                    INDEX <= INDEX - 14;
                                    if ( board[INDEX +: 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while ((curr_x < 7) && (curr_y > 0))
                                                begin 
                                                    curr_x <=  curr_x + 1;
                                                    curr_y <= curr_y - 1;
                                                    INDEX <= 8 * curr_y + curr_x;
                                                    if (board[INDEX +: 2] == player)
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
									 checkDone <= 1;
                            if ((y < 6) && (x < 6))
                                begin 
                                    curr_x <= x + 1;
                                    curr_y <= y + 1;
                                    INDEX <= INDEX + 18 ;
                                    if ( board[INDEX +: 2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while ((curr_x < 7) && (curr_y < 7))
                                                begin 
                                                    curr_x <=  curr_x +1;
                                                    curr_y <= curr_y +1;
                                                    INDEX <= 8 * curr_y + curr_x;
                                                    if (board[INDEX +: 2] == player)
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

    assign end_point = {curr_x, curr_y};
	 
endmodule