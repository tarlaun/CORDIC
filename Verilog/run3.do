vlog -work work -vopt -stats=none {C:\Users\Lenovo\Desktop\dsdProject\CORDIC\Verilog\testbench3.v}

vsim -gui work.testbench3 -novopt

add wave  \
sim:/testbench3/x \
sim:/testbench3/y \
sim:/testbench3/z \
sim:/testbench3/mode \
sim:/testbench3/clk \
sim:/testbench3/reset \
sim:/testbench3/res1 \
sim:/testbench3/res2 


run 200 ns