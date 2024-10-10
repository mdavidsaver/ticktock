#!/bin/sh
set -x -e

icepll -q -i 12 -o 124.5 -m -n pll -f pll.v

iverilog -tnull -Wall ticktock.v

yosys \
 -p "read_verilog ticktock.v" \
 -p "read_verilog pll.v" \
 -p "synth_ice40" \
 -p "write_verilog ticktock.out.v" \
 -p "write_json ticktock.json"

nextpnr-ice40 \
 --seed 1 \
 --hx1k --package tq144 \
 --pcf ticktock.pcf \
 --json ticktock.json \
 --asc ticktock.asc

icepack ticktock.asc ticktock.bin
