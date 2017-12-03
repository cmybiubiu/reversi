vlib work

vlog -timescale 1ns/1ns PlayerLocation.v

vsim PlayerLocation

log {/*}
add wave {/*}

force {clk} 0 0, 1 10 -r 20
force {moveEn} 0 0, 1 40
force {moveRightEn} 0 0, 1 40, 0 60, 1 80, 0 100
force {moveLeftEn} 0 0
force {moveUpEn} 0 0
force {moveDownEn} 0 0 
force {reset} 0 0, 1 5, 0 20

run 300ns