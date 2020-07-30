vlog -work work -vopt -stats=none {C:\Users\Lenovo\Desktop\dsdProject\CORDIC\Verilog\testbench2.v}

vsim -gui work.testbench2 -novopt

add wave  \
sim:/testbench2/x \
sim:/testbench2/y \
sim:/testbench2/z \
sim:/testbench2/mode \
sim:/testbench2/clk \
sim:/testbench2/reset \
sim:/testbench2/res1 \
sim:/testbench2/res2 \
sim:/testbench2/fd \
sim:/testbench2/fw \
sim:/testbench2/status \
sim:/testbench2/counter 


run 5000 ns