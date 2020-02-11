# If existing work library, delete 
vmap -del work
vdel -all -lib work 

# create a new library
vlib work
vmap work work 

#elaborating the design 
vcom <DUT>.v
vcom <TESTBENCH>.v

#Waveform 
vsim -t ns -novopt work.<TESTBENCH_MODULE_NAME_WITHOUT_EXTENSION_OF_THE_FILE>

view objects
view locals
view source
view wave -undock

add wave sim:/<TESTBENCH_MODULE_NAME_WITHOUT_EXTENSION_OF_THE_FILE>/*

run -a