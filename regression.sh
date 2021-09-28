#!/bin/bash

# record start time
date

# setup raptor_64 environment
export PATH=~/raptor_64/bin:$PATH

# remove exisitng result directory
sudo rm -r ~/raptor_64
sudo rm -r ~/Raptor/Raptor/build
rm -r ~/anthony/raptor_regression/result

# clone the tcl_scripts and tests directories
# adding git clone instructions here
cd ~/Raptor
git checkout master
git pull
#git checkout AU_1.2.3
#git pull
echo end_of_git_sync

cd ~/Raptor/Raptor
cmake -B build source -DCMAKE_BUILD_TYPE=Release
cd build
make install -j8
echo end_of_build

# setup directory for storing result
cd ~/anthony/raptor_regression
mkdir result
cd result
mkdir afifo
mkdir cnt32
mkdir and2
mkdir cnt4
mkdir design1
mkdir design2
mkdir design3
mkdir design4
mkdir design5
mkdir design6
mkdir design7
mkdir design8
mkdir design9
mkdir design10
mkdir fifo_hc
mkdir fifo_vc
mkdir infer_mult
mkdir infer_ram
mkdir io
mkdir mult16x16
mkdir mult32x32
mkdir mult
mkdir power
mkdir powerfifo
mkdir powerram
mkdir ram_hc
mkdir ram_vc
mkdir ram_init
mkdir ram_prd
mkdir fifo
mkdir sfifo
mkdir sta
mkdir breathe
mkdir sta1
cd ~/anthony/raptor_regression

# setup raptor_64 environment
export PATH=~/raptor_64/bin:$PATH
export quicklogic_LICENSE=~/anthony/raptor_licenses/raptor-40000.lic

# execute TCL scripts
# execute afifo
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/afifo.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/afifo/.

# execute cnt32
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/al4s3b_counter32bit.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/cnt32/.

# execute and2
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/and2.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/and2/.

# execute cnt4
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/counter_4bit.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/cnt4/.

# execute design1
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/design1.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/design1/.

# execute design2
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/design2.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/design2/.

# execute design3
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/design3.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/design3/.

# execute design4
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/design4.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/design4/.

# execute design5
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/design5.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/design5/.

# execute design6
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/design6.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/design6/.

# execute design7
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/design7.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/design7/.

# execute design8
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/design8.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/design8/.

# execute design9
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/design9.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/design9/.

# execute design10
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/design10.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/design10/.

# execute fifo_hc
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/fifo_hc.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/fifo_hc/.

# execute fifo_vc
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/fifo_vc.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/fifo_vc/.

# execute infer_mult
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/infer_mult.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/infer_mult/.

# execute infer_ram
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/infer_ram.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/infer_ram/.

# execute io_test
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/io.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/io/.

# execute mult_test
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/mult_test.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/mult/.

# execute power test
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/power.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/power/.

# execute ram and fifo power
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/powerfifo.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/powerfifo/.

# execute ram power
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/powerram.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/powerram/.

# execute ram_hc
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/ram_hc.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/ram_hc/.

# execute ram_vc
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/ram_vc.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/ram_vc/.

# execute ram_init
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/ram_init.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/ram_init/.

# execute ram_prd
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/ram_prd.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/ram_prd/.

# execute s3 fifo
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/fifo.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/fifo/.

# execute s3 sfifo
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/sfifo.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/sfifo/.

# execute sta
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/sta.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/sta/.

# execute sta1
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/sta1.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/sta1/.

# execute breathe
raptor --tcl ~/anthony/raptor_regression/tcl_scripts/breathe.tcl
mv ~/anthony/raptor_regression/*.log ~/anthony/raptor_regression/result/breathe/.

# parse thru the logs for error
# for design that passed raptor flow, check STA report
bash ~/anthony/raptor_regression/misc_scripts/check_log_error.sh
bash ~/anthony/raptor_regression/misc_scripts/gather_bit_files.sh
bash ~/anthony/raptor_regression/misc_scripts/make_evk_bin.sh
bash ~/anthony/raptor_regression/misc_scripts/testjlinkfiles.sh
bash ~/anthony/raptor_regression/misc_scripts/testbinfiles.sh

# copy results to archive
export DATE=`date +%y_%m_%d_%I_%m_%p`
cp -r result ~/anthony/Misc/regression_archive/raptor_result_$DATE

# record end time
date
















