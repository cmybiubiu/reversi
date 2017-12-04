module checkValidHelper (
        input clk;
        input resetn;
        input [2:0]x;
        input [2:0]y;
        input [2:0] direction;
        input [127:0] board;
        input player_black;

        output reg valid

);
    
    reg [2:0] index1, index2;
    localparam [1:0] player = {1'b1, player_black}; 
    localparam [1:0] opposite_player = {1'b1, ~player_black};

    always(posedge clk)
    begin
        if (resetn)
            valid <= 0;
        else
            begin
                case (direction)
                3'b000: begin  //vertically upper
                            if (y > 1)
                                begin 
                                    index1 <= y -1;
                                    if ( board[x][index1]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while (index1 != 0) 
                                                begin 
                                                    index1 <=  index1 -1;
                                                    if (board[x][index1] == player)
                                                        valid <= 1;
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
                                    index1 <= y + 1;
                                    if ( board[x][index1]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while (index1 != 7) 
                                                begin 
                                                    index1 <=  index1 + 1;
                                                    if (board[x][index1] == player)
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
                                    if ( board[index1][y]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while (index1 != 0) 
                                                begin 
                                                    index1 <=  index1 -1;
                                                    if (board[index1][y] == player)
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
                                    if ( board[index1][y]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while (index1 != 0) 
                                                begin 
                                                    index1 <=  index1 + 1;
                                                    if (board[index1][y] == player)
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
                                    if ( board[index1][index2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while ((index1 != 0) && (index2 != 0))
                                                begin 
                                                    index1 <=  index1 -1;
                                                    index2 <= index2 -1;
                                                    if (board[index1][index2] == player)
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
                                    if ( board[index1][index2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while ((index1 != 0) && (index2 != 7))
                                                begin 
                                                    index1 <=  index1 - 1;
                                                    index2 <= index2  + 1;
                                                    if (board[index1][index2] == player)
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
                                    if ( board[index1][index2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while ((index1 != 7) && (index2 != 0))
                                                begin 
                                                    index1 <=  index1 + 1;
                                                    index2 <= index2 - 1;
                                                    if (board[index1][index2] == player)
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
                                    if ( board[index1][index2]== opposite_player)
                                        begin
                                            valid <= 0;
                                            while ((index1 != 7) && (index2 != 7))
                                                begin 
                                                    index1 <=  index1 +1;
                                                    index2 <= index2 +1;
                                                    if (board[index1][index2] == player)
                                                        valid <= 1;
                                                end 
                                        end
                                    else 
                                        valid <= 0;
                                end

                            else 
                                valid <= 0; 
                        end



            end
        endcase
    end


endmodule