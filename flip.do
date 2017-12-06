vlib reversi

vlog -timescale 1ns/1ns flipHelper.v

vsim flipHelper


log {/*}

add wave {/*}

force {clk} 1 0, 0 10 -r 20

force {resetn} 1 0, 0 20 

force {x} 3'b000

force {y} 3'b010

force {end_point} 6'b000_000

force {direction} 3'b000


force {board[15:0]}    16'b0000_0000_0000_0011

force {board[31:16]}   16'b0000_0000_0000_0010

force {board[47:32]}   16'b0000_0000_0000_0011

force {board[63:48]}   16'b0000_0000_0000_0000

force {board[79:64]}   16'b0000_0000_0000_0000

force {board[95:80]}   16'b0000_0000_0000_0000

force {board[111:96]}  16'b0000_0000_0000_0000

force {board[127:112]} 16'b0000_0000_0000_0000

force {player_black} 1

force {reverse_enable} 1

run 60 ns