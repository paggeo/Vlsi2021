#connect. Here, I am connecting remotely.
connect

#config the pl
targets 20
fpga -file ./dvlsi2021_lab5_top.bit

#config the ps7 with the ps7_init.tcl
targets 17
source ps7_init.tcl
ps7_init
ps7_post_config

# download processor executable
targets 18
rst -processor
dow ./lab5_app.elf

jtagterminal -start
con