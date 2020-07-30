vlog -work work -vopt -stats=none {C:\Users\Lenovo\Desktop\dsdProject\CORDIC\Verilog\testbench.v}

vsim -gui work.testbench -novopt

add wave  \
sim:/testbench/x \
sim:/testbench/y \
sim:/testbench/z \
sim:/testbench/mode \
sim:/testbench/clk \
sim:/testbench/reset \
sim:/testbench/res1 \
sim:/testbench/res2 


run 200 ns

