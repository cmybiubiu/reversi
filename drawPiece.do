vlib reversi

vlog -timescale 1ns/1ns DrawPiece.v

vsim drawPiece


log {/*}

add wave {/*}

force {clk} 0 0, 1 10 -r 20

force {resetn} 1 0, 0 20 

force {x} 3'b100 0, 3'b010 50 

force {y} 3'b100 0, 3'b010 50

force {colour} 2'b11 0, 2'b10 50

run 100 ns
