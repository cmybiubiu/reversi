vlib reversi

vlog -timescale 1ns/1ns node.v

vsim controll_node_state


log {/*}

add wave {/*}



force {clk} 1 0, 0 5 -r 10
#reset
force {resetn} 0 0, 1 15

force {curr} 3'b100

force {play} 0

force {reverse} 1

force {set_black} 0

 
run 200ns
