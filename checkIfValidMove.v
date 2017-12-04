module checkIfValidMove (
            input clk;
            input resetn;
            input [2:0]x;
            input [2:0]y;
            input player_black;
            input [127:0] board;

            output [7:0] valids;
            output [47:0] end_points
);
    checkValidHelper c0(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b000),
        .board(board),
        .player_black(player_black),

        .valid(valids[0]),
        .end_point(end_points[5:0])

        );

    checkValidHelper c1(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b001),
        .board(board),
        .player_black(player_black),

        .valid(valids[1]),
        .end_point(end_points[11:6])
        );
    
    checkValidHelper c2(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b010),
        .board(board),
        .player_black(player_black),

        .valid(valids[2]),
        .end_point(end_points[17:12])
        );

    checkValidHelper c3(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b011),
        .board(board),
        .player_black(player_black),

        .valid(valids[3]),
        .end_point(end_points[23:18])
        );
    
    checkValidHelper c4(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b100),
        .board(board),
        .player_black(player_black),

        .valid(valids[4]),
        .end_point(end_points[29:24])
        );
    
    checkValidHelper c5(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b101),
        .board(board),
        .player_black(player_black),

        .valid(valids[5]),
        .end_point(end_points[35:30])
        );
    
    checkValidHelper c6(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b110),
        .board(board),
        .player_black(player_black),

        .valid(valids[6]),
        .end_point(end_points[41:36])
        );

    checkValidHelper c7(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b111),
        .board(board),
        .player_black(player_black),

        .valid(valids[7]),
        .end_point(end_points[47:42])
        );
endmodule