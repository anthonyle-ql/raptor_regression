compile_design /home/qlblue/anthony/raptor_regression/tests/ram_vc/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/ram_vc/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/ram_vc/AL4S3B_FPGA_RAMs.v /home/qlblue/anthony/raptor_regression/tests/ram_vc/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/ram_vc/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/ram_vc/r1024x16_1024x16.v /home/qlblue/anthony/raptor_regression/tests/ram_vc/r2048x8_2048x8.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/ram_vc --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/ram_vc.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/ram_vc.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/ram_vc.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/ram_vc} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
save_project  
run_till router 
run_sta  
run_pe  
save_project 
exit 

