compile_design /home/qlblue/anthony/raptor_regression/tests/PowerramDesign/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/PowerramDesign/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/PowerramDesign/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/PowerramDesign/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/PowerramDesign/r512x16_512x16.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/powerram --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/powerram.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/powerram.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/powerram.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/powerram} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till router 
run_sta  
run_pe  
save_project 
exit 

