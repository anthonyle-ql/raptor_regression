compile_design /home/qlblue/anthony/raptor_regression/tests/al4s3b_counter32bit/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/al4s3b_counter32bit/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/al4s3b_counter32bit/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/al4s3b_counter32bit/AL4S3B_FPGA_Top.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/cnt32 --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/top.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/al4s3b_counter32bit.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/al4s3b_counter32bit.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/cnt32} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till router 
run_sta  
run_pe  
save_project
exit
