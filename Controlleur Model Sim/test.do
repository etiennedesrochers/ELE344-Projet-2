vlib work 
vcom -93 -work work mux2.vhd
vcom -93 -work work pc.vhd
vcom -93 -work work addpclus4signext.vhd
vcom -93 -work work regfile.vhd
vcom -93 -work work ual.vhd
vcom -93 -work work datapath.vhd
vcom -93 -work work control.vhd
vcom -93 -work work mips.vhd
vcom -93 -work work imem.vhd
vcom -93 -work work dmem.vhd
vcom -93 -work work top.vhd

vsim Top
add wave -position end  sim:/top/clk
add wave -position end  sim:/top/reset
add wave -position end  sim:/top/PC(9:2)
add wave -position end  sim:/top/AluResult
add wave -position end  sim:/top/WRITEDATA



force /top/clk 1,0 10 ns -repeat 20 ns
force /top/reset 1,0 15 ns
run 650 ns



