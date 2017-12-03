vlib work

vlog -timescale 1ns/1ns ScoreManager.v

vsim ScoreManager

log {/*}
add wave {/*}

force {initialize} 1 0, 0 20
force {curr_board[191:0]} 0 0
force {clk} 0 0, 1 10 -r 20
force {resetn} 0 0
force {nextTurn} 0 0, 1 50

run 200ns