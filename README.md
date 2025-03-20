# Simple Icestorm project

A simple 1 Hz ticker for the
[iCEstick](https://www.latticesemi.com/icestick) iCE40 FPGA eval board
using the
[Project Icestrom](https://clifford.at/icestorm)
OSS toolchain.

Probably only useful as an example project...

## Building

```sh
git clone https://github.com/mdavidsaver/ticktock
cd ticktock
sudo apt-get install yosys nextpnr-ice40 fpga-icestorm iverilog
./make.sh
```

Then program with:

```sh
iceprog ticktock.bin
```
