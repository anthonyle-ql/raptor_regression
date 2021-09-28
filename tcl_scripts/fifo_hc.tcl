compile_design /home/qlblue/anthony/raptor_regression/tests/fifo_hc/af512x32_512x32.v /home/qlblue/anthony/raptor_regression/tests/fifo_hc/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/fifo_hc/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/fifo_hc/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/fifo_hc/AL4S3B_FPGA_Top.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/fifo_hc --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/fifo_hc.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/fifo_hc.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/fifo_hc.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/fifo_hc} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till router 
run_sta  
run_pe  
save_project 
exit 
