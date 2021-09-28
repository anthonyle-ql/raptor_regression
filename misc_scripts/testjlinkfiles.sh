#!/bin/bash

# record start time
date > ~/anthony/raptor_regression/jlink_result.log

# setup test environment
export PATH=/opt/SEGGER/JLink_V60:$PATH
export JSCRIPTS=~/anthony/raptor_regression/jlink_scripts
export TSCRIPTS=~/anthony/raptor_regression/result/bitfiles

# define functions
boot2jlink () {
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59301000 -If SWD -Speed 4000 -commandFile $JSCRIPTS/io_setup.jlink
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59301000 -If SWD -Speed 4000 -commandFile $JSCRIPTS/boot2jlink.jlink
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59301000 -If SWD -Speed 4000 -commandFile $JSCRIPTS/io_disable.jlink
}


load_run () {
cat $TSCRIPTS/$1.jlink $JSCRIPTS/$2.jlink > temp.jlink
JLinkExe -Device Cortex-M4 -SelectEmuBySN 59303893 -If SWD -Speed 4000 -commandFile temp.jlink > temp.log
if grep -q "Could not read memory" temp.log;
then
echo "$1: jlink output [FAIL]" >> ~/anthony/raptor_regression/jlink_result.log
else
echo "$1: jlink output [PASS]" >> ~/anthony/raptor_regression/jlink_result.log
fi
rm temp.log
rm temp.jlink
}
# end functions

# afifo
boot2jlink
load_run "afifo" "assp"

# and
boot2jlink
load_run "and2" "no_assp"

# cnt4
boot2jlink
load_run "cnt4" "no_assp"

# cnt32
boot2jlink
load_run "cnt32" "assp"

# design1
boot2jlink
load_run "design1" "assp"

# design2
boot2jlink
load_run "design2" "assp"

# design3
boot2jlink
load_run "design3" "assp"

# design4
boot2jlink
load_run "design4" "assp"

# design6
boot2jlink
load_run "design6" "assp"

# design8
boot2jlink
load_run "design8" "assp"

# design9
boot2jlink
load_run "design9" "assp"

# design10
boot2jlink
load_run "design10" "assp"

# fifo
boot2jlink
load_run "fifo" "assp"

# fifo_hc
boot2jlink
load_run "fifo_hc" "assp"

# fifo_vc
boot2jlink
load_run "fifo_vc" "assp"

# infer_mult
boot2jlink
load_run "infer_mult" "no_assp"

# infer_ram
boot2jlink
load_run "infer_ram" "assp"

# io
boot2jlink
load_run "io" "assp"

# mult
boot2jlink
load_run "mult" "no_assp"

# power
boot2jlink
load_run "power" "assp"

# powerfifo
boot2jlink
load_run "powerfifo" "assp"

# powerram
boot2jlink
load_run "powerram" "assp"

# ram_hc
boot2jlink
load_run "ram_hc" "assp"

# ram_vc
boot2jlink
load_run "ram_vc" "assp"

# ram_init
boot2jlink
load_run "ram_init" "assp"

# ram_prd
boot2jlink
load_run "ram_prd" "assp"

# sfifo
boot2jlink
load_run "sfifo" "assp"

# sta
boot2jlink
load_run "sta" "no_assp"

# sta1
boot2jlink
load_run "sta1" "no_assp"

date >> ~/anthony/raptor_regression/jlink_result.log
cp jlink_result.log ~/anthony/raptor_regression/result/.
rm jlink_result.log

















