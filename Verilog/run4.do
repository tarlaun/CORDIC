vlog -work work -vopt -stats=none {C:\Users\Lenovo\Desktop\dsdProject\CORDIC\Verilog\testbench4.v}

vsim -gui work.testbench4 -novopt

add wave  \
sim:/testbench4/x \
sim:/testbench4/y \
sim:/testbench4/z \
sim:/testbench4/mode \
sim:/testbench4/clk \
sim:/testbench4/reset \
sim:/testbench4/res1 \
sim:/testbench4/res2 


run 200 ns