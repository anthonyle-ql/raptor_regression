compile_design /home/qlblue/anthony/raptor_regression/tests/IO_Test/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/IO_Test/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/IO_Test/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/IO_Test/AL4S3B_FPGA_Top.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/io --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/IO_Test.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/IO_Test.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/IO_Test.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/io} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till router 
run_sta  
run_pe  
save_project  
exit
