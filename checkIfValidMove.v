module checkIfValidMove (
            input clk;
            input resetn;
            input [2:0]x;
            input [2:0]y;
            input player_black;
            input [127:0] board;

            output reg [7:0] valids
);
    checkValidHelper c0(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b000),
        .board(board),
        .player_black(player_black),

        .valid(valids[0])
        );

    checkValidHelper c1(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b001),
        .board(board),
        .player_black(player_black),

        .valid(valids[1])
        );
    
    checkValidHelper c2(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b010),
        .board(board),
        .player_black(player_black),

        .valid(valids[2])
        );

    checkValidHelper c3(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b011),
        .board(board),
        .player_black(player_black),

        .valid(valids[3])
        );
    
    checkValidHelper c4(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b100),
        .board(board),
        .player_black(player_black),

        .valid(valids[4])
        );
    
    checkValidHelper c5(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b101),
        .board(board),
        .player_black(player_black),

        .valid(valids[5])
        );
    
    checkValidHelper c6(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b110),
        .board(board),
        .player_black(player_black),

        .valid(valids[6])
        );

    checkValidHelper c7(
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .direction(3'b111),
        .board(board),
        .player_black(player_black),

        .valid(valids[1])
        );
endmodule