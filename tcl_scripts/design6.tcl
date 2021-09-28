compile_design /home/qlblue/anthony/raptor_regression/tests/design6/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/design6/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/design6/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/design6/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/design6/duty_cycle_count.v /home/qlblue/anthony/raptor_regression/tests/design6/freq_counter.v /home/qlblue/anthony/raptor_regression/tests/design6/pwm_counter.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/design6 --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/design6.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design6.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design6.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/design6} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till router 
run_sta  
run_pe  
save_project 
exit 
