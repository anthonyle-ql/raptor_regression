compile_design /home/qlblue/anthony/raptor_regression/tests/StaDesign/sta_counters.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/sta --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/sta_counters.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/sta_counters.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/sta_counters.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/sta} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40  
run_till optimizer 
run_till placer 
run_till router 
run_sta  
run_pe  
save_project 
exit 
