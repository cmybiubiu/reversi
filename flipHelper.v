module flipHelper (
        input clk,
        input resetn,
        input [2:0]x,
        input [2:0]y,
        input [5:0] end_point,
        input [2:0] direction,
        input [127:0] board,
        input player_black,
        input reverse_enable,

        output reg [127:0] result_board
    );

    reg [2:0] curr_x, curr_y;
    reg [6:0] index;
    wire [2:0] end_x, end_y;
    assign end_x = end_point[2:0];
    assign end_y = end_point[5:3];
    wire [1:0] player = {1'b1, player_black};

    always @(posedge clk)
    begin 
        if (resetn)
            result_board <= board;
        else 
            begin 
                curr_x <= x;
                curr_y <= y;
                index[6:1] <= {y,x};
					 index[0] <= 1'b0;
                case (direction)
                3'b000: begin //vertically upper 
                            if (reverse_enable)
                                begin
                                    while (curr_y > end_y)
                                        begin 
                                            curr_y <= curr_y - 1;
                                            index <= index - 16;
                                            result_board[index + : 2] <= player;
                                        end 
                                end 
                            else 
                                result_board <= board;
                        end 

                3'b001:begin //vertically down
                            if (reverse_enable)
                                begin
                                    while (curr_y < end_y)
                                        begin 
                                            curr_y <= curr_y + 1;
                                            index <= index + 16;
                                            result_board[index + : 2] <= player;
                                        end 
                                end 
                            else 
                                result_board <= board;
                        end
                3'b010: begin // horizontally left
                            if (reverse_enable)
                                begin
                                    while (curr_x > end_x)
                                        begin 
                                            curr_x <= curr_x - 1;
                                            index <= index - 2;
                                            result_board[index + : 2] <= player;
                                        end 
                                end 
                            else 
                                result_board <= board;
                        end
                3'b011:begin // horizontally right
                            if (reverse_enable)
                                begin
                                    while (curr_x < end_x)
                                        begin 
                                            curr_x <= curr_x + 1;
                                            index <= index + 2;
                                            result_board[index + : 2] <= player;
                                        end 
                                end 
                            else 
                                result_board <= board;
                        end
                3'b100:begin // left top
                            if (reverse_enable)
                                begin
                                    while((curr_x > end_x) && (curr_y > end_y))
                                        begin 
                                            curr_x <= curr_x - 1;
                                            curr_y <= curr_y - 1;
                                            index <= index - 18;
                                            result_board[index + : 2] <= player;
                                        end 
                                end 
                            else 
                                result_board <= board;
                        end
                3'b101:begin // left bottom
                            if (reverse_enable)
                                begin
                                    while((curr_x > end_x) && (curr_y < end_y))
                                        begin 
                                            curr_x <= curr_x - 1;
                                            curr_y <= curr_y + 1;
                                            index <= index + 14;
                                            result_board[index + : 2] <= player;
                                        end 
                                end 
                            else 
                                result_board <= board;
                        end
                3'b110:begin // right top
                            if (reverse_enable)
                                begin
                                    while((curr_x < end_x) && (curr_y > end_y))
                                        begin 
                                            curr_x <= curr_x + 1;
                                            curr_y <= curr_y - 1;
                                            index <= index - 14;
                                           result_board[index + : 2] <= player;
                                        end 
                                end 
                            else 
                                result_board <= board;
                        end
                3'b111:begin // right bottom
                            if (reverse_enable)
                                begin
                                    while((curr_x < end_x) && (curr_y < end_y))
                                        begin 
                                            curr_x <= curr_x + 1;
                                            curr_y <= curr_y + 1;
                                            index <= index + 18;
                                            result_board[index + : 2] <= player;
                                        end 
                                end 
                            else 
                                result_board <= board;
                        end
                endcase

            end 
    end

endmodule