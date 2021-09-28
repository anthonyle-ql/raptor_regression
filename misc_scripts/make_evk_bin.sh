#!/bin/bash

date
echo "Generate bin files for evk validation"

# make local copies of aurora generated bin files
cp ~/anthony/raptor_regression/result/bitfiles/*.bin ~/anthony/raptor_regression/fpgabincombiner/.
cd ~/anthony/raptor_regression/fpgabincombiner

# define functions
check_file () {
File=$1.bin
if test -f "$File"; then
 echo "$1: found bin file [PASS]"
 return 0
else
 echo "$1: can't find specified bin file [FAIL]"
fi
}
make_evk_bin () {
python3 ./fpgabincombiner.py --bitstream=./$1.bin --iomuxbin=default/generic.bin --fpgabin=./$1_evk.bin
rm $1.bin
}

# end functions


if check_file "afifo";
then 
make_evk_bin "afifo"
fi

if check_file "and2";
then 
make_evk_bin "and2"
fi

if check_file "cnt4";
then 
make_evk_bin "cnt4"
fi

if check_file "cnt32";
then 
make_evk_bin "cnt32" 
fi

if check_file "design1";
then 
make_evk_bin "design1"
fi

if check_file "design2";
then 
make_evk_bin "design2" 
fi

if check_file "design3";
then 
make_evk_bin "design3"
fi

if check_file "design4";
then 
make_evk_bin "design4" 
fi

if check_file "design5";
then 
make_evk_bin "design5" 
fi

if check_file "design6";
then 
make_evk_bin "design6" 
fi

if check_file "design7";
then 
make_evk_bin "design7" 
fi

if check_file "design8";
then 
make_evk_bin "design8" 
fi

if check_file "design9";
then 
make_evk_bin "design9" 
fi

if check_file "design10";
then 
make_evk_bin "design10" 
fi

if check_file "fifo";
then 
make_evk_bin "fifo" 
fi

if check_file "fifo_hc";
then 
make_evk_bin "fifo_hc" 
fi

if check_file "fifo_vc";
then 
make_evk_bin "fifo_vc" 
fi

if check_file "infer_mult";
then 
make_evk_bin "infer_mult" 
fi

if check_file "infer_ram";
then 
make_evk_bin "infer_ram"
fi

if check_file "io";
then 
make_evk_bin "io"
fi

if check_file "mult";
then 
make_evk_bin "mult"
fi

if check_file "power";
then 
make_evk_bin "power"
fi

if check_file "powerfifo";
then 
make_evk_bin "powerfifo"
fi

if check_file "powerram";
then 
make_evk_bin "powerram"
fi

if check_file "ram_hc";
then 
make_evk_bin "ram_hc"
fi

if check_file "ram_vc";
then 
make_evk_bin "ram_vc"
fi

if check_file "ram_init";
then 
make_evk_bin "ram_init"
fi

if check_file "ram_prd";
then 
make_evk_bin "ram_prd"
fi

if check_file "sfifo";
then 
make_evk_bin "sfifo"
fi

if check_file "sta";
then 
make_evk_bin "sta"
fi

if check_file "sta1";
then 
make_evk_bin "sta1"
fi

cp ~/anthony/raptor_regression/fpgabincombiner/*.bin ~/anthony/raptor_regression/result/bitfiles/.
rm ~/anthony/raptor_regression/fpgabincombiner/*.bin

