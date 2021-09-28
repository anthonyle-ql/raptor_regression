#!/bin/bash

# record start time
date > ~/anthony/raptor_regression/bin_result.log

# setup test environment
export PATH=/opt/SEGGER/JLink_V60:$PATH
export JSCRIPTS=~/anthony/raptor_regression/jlink_scripts
export TSCRIPTS=~/anthony/raptor_regression/result/bitfiles
export COMPORT=/dev/ttyUSB0
export TINY=~/anthony/raptor_regression/TinyFPGA-Programmer-Application

sudo -S <<< "Test&win!" chmod a+rw /dev/ttyUSB0

# define functions
boot2flash () {
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59301000 -If SWD -Speed 4000 -commandFile $JSCRIPTS/io_setup.jlink
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59301000 -If SWD -Speed 4000 -commandFile $JSCRIPTS/boot2flash.jlink
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59301000 -If SWD -Speed 4000 -commandFile $JSCRIPTS/io_disable.jlink
}

boot2app () {
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59301000 -If SWD -Speed 4000 -commandFile $JSCRIPTS/io_setup.jlink
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59301000 -If SWD -Speed 4000 -commandFile $JSCRIPTS/boot2app.jlink
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59301000 -If SWD -Speed 4000 -commandFile $JSCRIPTS/io_disable.jlink
}

load_run () {
python3 $TINY/tinyfpga-programmer-gui.py --port $COMPORT --mode fpga --appfpga ~/anthony/raptor_regression/result/bitfiles/$1_evk.bin
boot2app
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59303893 -If SWD -Speed 4000 -commandFile $JSCRIPTS/$2.jlink > temp.log
if grep -q "Could not read memory" temp.log;
then
echo "$1: bin_evk output [FAIL]" >> ~/anthony/raptor_regression/bin_result.log
else
echo "$1: bin_evk output [PASS]" >> ~/anthony/raptor_regression/bin_result.log
fi
rm temp.log
}
# end functions

# afifo
boot2flash
load_run "afifo" "no_assp"

# and
 boot2flash
load_run "and2" "no_assp"

# cnt4
 boot2flash
load_run "cnt4" "no_assp"

# cnt32
 boot2flash
load_run "cnt32" "assp"

# design1
 boot2flash
load_run "design1" "assp"

# design2
 boot2flash
load_run "design2" "assp"

# design3
 boot2flash
load_run "design3" "assp"

# design4
 boot2flash
load_run "design4" "assp"

# design6
 boot2flash
load_run "design6" "assp"

# design8
 boot2flash
load_run "design8" "assp"

# design9
 boot2flash
load_run "design9" "assp"

# design10
 boot2flash
load_run "design10" "assp"

# fifo
 boot2flash
load_run "fifo" "assp"

# fifo_hc
 boot2flash
load_run "fifo_hc" "assp"

# fifo_vc
 boot2flash
load_run "fifo_vc" "assp"

# infer_mult
 boot2flash
load_run "infer_mult" "no_assp"

# infer_ram
 boot2flash
load_run "infer_ram" "assp"

# io
 boot2flash
load_run "io" "assp"

# mult
 boot2flash
load_run "mult" "no_assp"

# power
 boot2flash
load_run "power" "assp"

# powerfifo
 boot2flash
load_run "powerfifo" "assp"

# powerram
 boot2flash
load_run "powerram" "assp"

# ram_hc
 boot2flash
load_run "ram_hc" "assp"

# ram_vc
 boot2flash
load_run "ram_vc" "assp"

# ram_init
 boot2flash
load_run "ram_init" "assp"

# ram_prd
 boot2flash
load_run "ram_prd" "assp"

# sfifo
 boot2flash
load_run "sfifo" "assp"

# sta
 boot2flash
load_run "sta" "no_assp"

# sta1
 boot2flash
load_run "sta1" "no_assp"

date >> ~/anthony/raptor_regression/bin_result.log
cp bin_result.log ~/anthony/raptor_regression/result/.
rm bin_result.log
















