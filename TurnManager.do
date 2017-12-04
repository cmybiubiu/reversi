vlib work

vlog -timescale 1ns/1ns TurnManager.v

vsim TurnManager

log {/*}
add wave {/*}

force {initialize} 1 0, 0 20
force {nextTurn} 0 0, 1 25, 0 35, 1 60, 0 85
force {clk} 0 0, 1 10 -r 20
force {resetn} 0
				
run 100ns