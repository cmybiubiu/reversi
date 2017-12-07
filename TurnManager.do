vlib work

vlog -timescale 1ns/1ns TurnManager.v

vsim TurnManager

log {/*}
add wave {/*}

force {TurnManagerEn} 0 0, 1 25, 0 35, 1 50
force {clk} 0 0, 1 10 -r 20
force {resetn} 0 0, 1 10, 0 30
				
run 100ns