#!/bin/bash

date > ~/anthony/raptor_regression/result/flow_result.log
echo "check raptor run logs for errors" >> ~/anthony/raptor_regression/result/flow_result.log
echo >> ~/anthony/raptor_regression/result/flow_result.log

# define functions
check_error () {
File=~/anthony/raptor_regression/result/$1/tclRaptor.log
if test -f "$File"; then
 if grep -q error "$File"; then
  echo "$1: raptor flow [FAIL]" >> ~/anthony/raptor_regression/result/flow_result.log
  return 1
 else
  echo "$1: raptor flow [PASS]" >> ~/anthony/raptor_regression/result/flow_result.log
  return 0
 fi
else
 echo "$File does not exist" >> ~/anthony/raptor_regression/result/flow_result.log
 return 1
fi
}
check_sta () {
File=~/anthony/raptor_regression/result/$1/sta/$2_Max_STA_Typical.rpt
if grep -q "StartPoint" "$File";
then
echo "$1: raptor STA max [PASS]" >> ~/anthony/raptor_regression/result/flow_result.log
else
echo "$1: raptor STA max [FAIL] NO PATH" >> ~/anthony/raptor_regression/result/flow_result.log
fi

File=~/anthony/raptor_regression/result/$1/sta/$2_Min_STA_Typical.rpt
if grep -q "StartPoint" "$File";
then
echo "$1: raptor STA min [PASS]" >> ~/anthony/raptor_regression/result/flow_result.log
else
echo "$1: raptor STA min [FAIL] NO PATH" >> ~/anthony/raptor_regression/result/flow_result.log
fi
}
# end functions


if check_error "afifo";
then 
check_sta "afifo" "top" 
fi

if check_error "and2";
then 
check_sta "and2" "top" 
fi

if check_error "cnt4";
then 
check_sta "cnt4" "top" 
fi

if check_error "cnt32";
then 
check_sta "cnt32" "top" 
fi

if check_error "design1";
then 
check_sta "design1" "top" 
fi

if check_error "design2";
then 
check_sta "design2" "top" 
fi

if check_error "design3";
then 
check_sta "design3" "top" 
fi

if check_error "design4";
then 
check_sta "design4" "top" 
fi

if check_error "design5";
then 
check_sta "design5" "top" 
fi

if check_error "design6";
then 
check_sta "design6" "top" 
fi

if check_error "design7";
then 
check_sta "design7" "top" 
fi

if check_error "design8";
then 
check_sta "design8" "top" 
fi

if check_error "design9";
then 
check_sta "design9" "top" 
fi

if check_error "design10";
then 
check_sta "design10" "top" 
fi

if check_error "fifo";
then 
check_sta "fifo" "top" 
fi

if check_error "fifo_hc";
then 
check_sta "fifo_hc" "top" 
fi

if check_error "fifo_vc";
then 
check_sta "fifo_vc" "top" 
fi

if check_error "infer_mult";
then 
check_sta "infer_mult" "top" 
fi

if check_error "infer_ram";
then 
check_sta "infer_ram" "top" 
fi

if check_error "io";
then 
check_sta "io" "top" 
fi

if check_error "mult";
then 
check_sta "mult" "top" 
fi

if check_error "power";
then 
check_sta "power" "top" 
fi

if check_error "powerfifo";
then 
check_sta "powerfifo" "top" 
fi

if check_error "powerram";
then 
check_sta "powerram" "top" 
fi

if check_error "ram_hc";
then 
check_sta "ram_hc" "top" 
fi

if check_error "ram_vc";
then 
check_sta "ram_vc" "top" 
fi

if check_error "ram_init";
then 
check_sta "ram_init" "top" 
fi

if check_error "ram_prd";
then 
check_sta "ram_prd" "top" 
fi

if check_error "sfifo";
then 
check_sta "sfifo" "top" 
fi

if check_error "sta";
then 
check_sta "sta" "top" 
fi

if check_error "sta1";
then 
check_sta "sta1" "top" 
fi












