compile_design /home/qlblue/anthony/raptor_regression/tests/fifo_vc/af2048x8_2048x8.v /home/qlblue/anthony/raptor_regression/tests/fifo_vc/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/fifo_vc/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/fifo_vc/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/fifo_vc/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/fifo_vc/f1024x16_1024x16.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/fifo_vc --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/fifo_vc.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/fifo_vc.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/fifo_vc.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/fifo_vc} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till router 
run_sta  
run_pe  
save_project
exit  
