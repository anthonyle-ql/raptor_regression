compile_design /home/qlblue/anthony/raptor_regression/tests/ram_prd/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/ram_prd/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/ram_prd/AL4S3B_FPGA_RAMs.v /home/qlblue/anthony/raptor_regression/tests/ram_prd/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/ram_prd/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/ram_prd/r512x16_512x16.v /home/qlblue/anthony/raptor_regression/tests/ram_prd/r512x32_512x32.v /home/qlblue/anthony/raptor_regression/tests/ram_prd/r1024x8_1024x8.v /home/qlblue/anthony/raptor_regression/tests/ram_prd/r1024x16_1024x16.v /home/qlblue/anthony/raptor_regression/tests/ram_prd/r2048x8_2048x8.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/ram_prd --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/ram_prd.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/ram_prd.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/ram_prd.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/ram_prd} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
save_project  
run_till router 
run_sta  
run_pe  
save_project
exit  

