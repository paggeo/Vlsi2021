// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Mon May 31 22:24:23 2021
// Host        : Linux-pag running 64-bit Ubuntu 20.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/georgepag4028/Desktop/Sxoli/Vlsi2021/Ask5/dvlsi2021_lab5/dvlsi2021_ask5_prj/dvlsi2021_ask5_prj.srcs/sources_1/ip/fifo_generator_2048_32/fifo_generator_2048_32_stub.v
// Design      : fifo_generator_2048_32
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_2,Vivado 2018.2" *)
module fifo_generator_2048_32(clk, srst, din, wr_en, rd_en, dout, full, empty, valid, 
  data_count)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[31:0],wr_en,rd_en,dout[31:0],full,empty,valid,data_count[10:0]" */;
  input clk;
  input srst;
  input [31:0]din;
  input wr_en;
  input rd_en;
  output [31:0]dout;
  output full;
  output empty;
  output valid;
  output [10:0]data_count;
endmodule
