vlib reversi

vlog -timescale 1ns/1ns node.v

vsim controll_node_state


log {/*}

add wave {/*}



force {clk} 1 0, 0 5 -r 10
#reset
force {resetn} 0 0, 1 15

force {curr[0]} 0 0, 1 30 -r 60 

force {curr[1]} 0 0, 1 20 -r 40 

force {curr[2]} 0 0, 1 10

force {play} 1

force {reverse} 1

force {set_black} 0 0, 1 10 -r 20

 
run 200ns
