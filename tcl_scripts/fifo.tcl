compile_design /home/qlblue/anthony/raptor_regression/tests/s3_fifo_test/af512x16_512x16.v /home/qlblue/anthony/raptor_regression/tests/s3_fifo_test/af512x32_512x32.v /home/qlblue/anthony/raptor_regression/tests/s3_fifo_test/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/s3_fifo_test/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/s3_fifo_test/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/s3_fifo_test/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/s3_fifo_test/f1024x16_1024x16.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/fifo --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/s3_fifo_test.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/s3_fifo_test.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/s3_fifo_test.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/fifo} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till router 
run_sta  
run_pe  
save_project  
exit
