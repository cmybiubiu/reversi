vlib work

vlog -timescale 1ns/1ns drawBoard.v

vsim drawBoard

log {/*}
add wave {/*}

force {drawBoardEn} 1 0
force {clk} 0 0, 1 10 -r 20
force {resetn} 1 0, 0 15
				
run 100ns