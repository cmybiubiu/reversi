module flip(
        input clk,
        input resetn,
        input [7:0] valid_directions,
        input [47:0] end_points,
        input [127:0] board,
        input player_black,

        output reg [127:0] new_board
);
    wire  [127: 0] wire0, wire1, wire2, wire3, wire4, wire5, wire6;

    always (posedge clk)
    begin 
        if (resetn) 
            new_board <= board;
        else 
    end 

    flipHelper fh0 (
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .end_point(end_points[5:0]),
        .direction(3'b000),
        .board(board),
        .player_black(player_black),
        .reverse_enable(valid_directions[0]),

        .result_board(wire0)
    );

    flipHelper fh1 (
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .end_point(end_points[11:6]),
        .direction(3'b001),
        .board(wire0),
        .player_black(player_black),
        .reverse_enable(valid_directions[1]),

        .result_board(wire1)
    );

    flipHelper fh2 (
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .end_point(end_points[17:12]),
        .direction(3'b010),
        .board(wire1),
        .player_black(player_black),
        .reverse_enable(valid_directions[2]),

        .result_board(wire2)
    );

    flipHelper fh3 (
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .end_point(end_points[23:18]),
        .direction(3'b011),
        .board(wire2),
        .player_black(player_black),
        .reverse_enable(valid_directions[3]),

        .result_board(wire3)
    );

     flipHelper fh4 (
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .end_point(end_points[29:24]),
        .direction(3'b100),
        .board(wire3),
        .player_black(player_black),
        .reverse_enable(valid_directions[4]),

        .result_board(wire4)
    );

    flipHelper fh5 (
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .end_point(end_points[35:30]),
        .direction(3'b101),
        .board(wire4),
        .player_black(player_black),
        .reverse_enable(valid_directions[5]),

        .result_board(wire5)
    );

    flipHelper fh6 (
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .end_point(end_points[41:36]),
        .direction(3'b110),
        .board(wire5),
        .player_black(player_black),
        .reverse_enable(valid_directions[6]),

        .result_board(wire6)
    );

    flipHelper fh7 (
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .end_point(end_points[47:42]),
        .direction(3'b111),
        .board(wire6),
        .player_black(player_black),
        .reverse_enable(valid_directions[7]),

        .result_board(new_board)
    );

endmodule