vlib reversi

vlog -timescale 1ns/1ns place.v

vsim place


log {/*}

add wave {/*}

			


force {clk} 1 0, 0 5 -r 10
#reset
force {resetn} 1 0, 0 15



force {x} 3'b111

force {y} 3'b111

force {place_enable} 0 0, 1 40

force {player_black} 0 0, 1 20 -r 40

force {curr_board}  0;
 
run 200ns
