onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib fifo_generator_2048_32_no_lat_opt

do {wave.do}

view wave
view structure
view signals

do {fifo_generator_2048_32_no_lat.udo}

run -all

quit -force
