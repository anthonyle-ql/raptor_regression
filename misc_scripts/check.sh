#!/bin/bash

# record start time
date > ~/anthony/raptor_regression/check.log

# setup test environment
export PATH=/opt/SEGGER/JLink_V60:$PATH
export JSCRIPTS=~/anthony/raptor_regression/jlink_scripts
export TSCRIPTS=~/anthony/raptor_regression/design3_precision/config_bit_gen
export COMPORT=/dev/ttyUSB0
export TINY=~/anthony/raptor_regression/TinyFPGA-Programmer-Application

# define functions
boot2jlink () {
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59301000 -If SWD -Speed 4000 -commandFile $JSCRIPTS/io_setup.jlink
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59301000 -If SWD -Speed 4000 -commandFile $JSCRIPTS/boot2jlink.jlink
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59301000 -If SWD -Speed 4000 -commandFile $JSCRIPTS/io_disable.jlink
}

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

load_run1 () {
cat $TSCRIPTS/$1.jlink $JSCRIPTS/$2.jlink > temp.jlink
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59303893 -If SWD -Speed 4000 -commandFile temp.jlink > temp.log
if grep -q "Could not read memory" temp.log;
then
echo "$1: jlink output [FAIL]" >> ~/anthony/raptor_regression/check.log
else
echo "$1: jlink output [PASS]" >> ~/anthony/raptor_regression/check.log
fi
rm temp.log
rm temp.jlink
}

load_run2 () {
python3 $TINY/tinyfpga-programmer-gui.py --port $COMPORT --mode fpga --appfpga $TSCRIPTS/$1_evk.bin
boot2app
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59303893 -If SWD -Speed 4000 -commandFile $JSCRIPTS/$2.jlink > temp.log
if grep -q "Could not read memory" temp.log;
then
echo "$1: bin_evk output [FAIL]" >> ~/anthony/raptor_regression/check.log
else
echo "$1: bin_evk output [PASS]" >> ~/anthony/raptor_regression/check.log
fi
rm temp.log
}
# end functions

# afifo
boot2jlink
load_run1 "QLAL4S3B_top" "assp"
boot2flash
load_run2 "QLAL4S3B_top" "assp"














