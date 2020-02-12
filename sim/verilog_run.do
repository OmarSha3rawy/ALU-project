# If existing work library, delete 
vmap -del work
vdel -all -lib work 

# create a new library
vlib work
vmap work work 

#elaborating the design 
vlog ALU.v
vlog tbench_top.sv

#Waveform 
vsim -t ns -novopt work.tbench_top

view objects
view locals
view source
view wave -undock

add wave sim:/tbench_top/*

run -a