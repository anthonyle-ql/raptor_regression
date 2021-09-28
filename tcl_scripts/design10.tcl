compile_design /home/qlblue/anthony/raptor_regression/tests/design10/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/design10/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/design10/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/design10/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/design10/Dma_Ctrl.v /home/qlblue/anthony/raptor_regression/tests/design10/Fsm_Top.v /home/qlblue/anthony/raptor_regression/tests/design10/Serializer_Deserializer_Test.v /home/qlblue/anthony/raptor_regression/tests/design10/Serializer_Deserializer.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/design10 --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/design10.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design10.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design10.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/design10} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till router 
run_sta  
run_pe  
save_project 
exit 
