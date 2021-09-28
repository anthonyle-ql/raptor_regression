#!/bin/bash

date
echo "collect bit files for validation"

# make directories to collect bit files

rm -r ~/anthony/raptor_regression/result/bitfiles
mkdir ~/anthony/raptor_regression/result/bitfiles

# define functions
check_file () {
File=~/anthony/raptor_regression/result/$1/config_bit_gen
if test -d "$File"; then
 echo "$1: found specified directory [PASS]"
 return 0
else
 echo "$1: can't find specified directory  [FAIL]"
 return 1
fi
}
copy_files () {
cp ~/anthony/raptor_regression/result/$1/config_bit_gen/RAPIDMATRIX_top.bin ~/anthony/raptor_regression/result/bitfiles/$1.bin
cp ~/anthony/raptor_regression/result/$1/config_bit_gen/RAPIDMATRIX_top.jlink ~/anthony/raptor_regression/result/bitfiles/$1.jlink
cp ~/anthony/raptor_regression/result/$1/config_bit_gen/ShiftPattern.RAPIDMATRIX.top ~/anthony/raptor_regression/result/bitfiles/$1.shiftpattern
}

# end functions


if check_file "afifo";
then 
copy_files "afifo" 
fi

if check_file "and2";
then 
copy_files "and2"
fi

if check_file "cnt4";
then 
copy_files "cnt4"
fi

if check_file "cnt32";
then 
copy_files "cnt32" 
fi

if check_file "design1";
then 
copy_files "design1"
fi

if check_file "design2";
then 
copy_files "design2" 
fi

if check_file "design3";
then 
copy_files "design3"
fi

if check_file "design4";
then 
copy_files "design4" 
fi

if check_file "design5";
then 
copy_files "design5" 
fi

if check_file "design6";
then 
copy_files "design6" 
fi

if check_file "design7";
then 
copy_files "design7" 
fi

if check_file "design8";
then 
copy_files "design8" 
fi

if check_file "design9";
then 
copy_files "design9" 
fi

if check_file "design10";
then 
copy_files "design10" 
fi

if check_file "fifo";
then 
copy_files "fifo" 
fi

if check_file "fifo_hc";
then 
copy_files "fifo_hc" 
fi

if check_file "fifo_vc";
then 
copy_files "fifo_vc" 
fi

if check_file "infer_mult";
then 
copy_files "infer_mult" 
fi

if check_file "infer_ram";
then 
copy_files "infer_ram"
fi

if check_file "io";
then 
copy_files "io"
fi

if check_file "mult";
then 
copy_files "mult"
fi

if check_file "power";
then 
copy_files "power"
fi

if check_file "powerfifo";
then 
copy_files "powerfifo"
fi

if check_file "powerram";
then 
copy_files "powerram"
fi

if check_file "ram_hc";
then 
copy_files "ram_hc"
fi

if check_file "ram_vc";
then 
copy_files "ram_vc"
fi

if check_file "ram_init";
then 
copy_files "ram_init"
fi

if check_file "ram_prd";
then 
copy_files "ram_prd"
fi

if check_file "sfifo";
then 
copy_files "sfifo"
fi

if check_file "sta";
then 
copy_files "sta"
fi

if check_file "sta1";
then 
copy_files "sta1"
fi





