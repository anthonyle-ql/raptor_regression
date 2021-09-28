compile_design /home/qlblue/anthony/raptor_regression/tests/sfifo/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/sfifo/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/sfifo/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/sfifo/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/sfifo/f512x8_512x8.v /home/qlblue/anthony/raptor_regression/tests/sfifo/f512x32_512x32.v /home/qlblue/anthony/raptor_regression/tests/sfifo/f1024x16_1024x16.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/sfifo --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/sfifo.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/sfifo.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/sfifo.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/sfifo} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
save_project  
run_till router 
run_sta  
run_pe  
save_project
exit

