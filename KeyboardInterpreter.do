vlib work

vlog -timescale 1ns/1ns KeyBoardInterpreter.v

vsim KeyBoardInterpreter


log {/*}
add wave {/*}

force {clk} 0 0, 1 10 -r 20
#valid signal only lasts until the next posedge clk?
force {valid} 0 0, 1 55, 0 70, 1 110, 0 130

#enterEn = 1011010, moveRightEn = 1110100, moveLeftEn = 1101011, moveUpEn = 1110101, moveDownEn = 1110010
force {makeBreak} 0 0, 1 55, 0 80, 1 110, 0 160
force {outCode[7:0]} 0 0, 1110100 55, 1101011 110

run 300ns

