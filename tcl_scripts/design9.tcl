compile_design /home/qlblue/anthony/raptor_regression/tests/design9/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/design9/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/design9/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/design9/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/design9/i2c_master_bit_ctrl.v /home/qlblue/anthony/raptor_regression/tests/design9/i2c_master_byte_ctrl.v /home/qlblue/anthony/raptor_regression/tests/design9/i2c_master_defines.v /home/qlblue/anthony/raptor_regression/tests/design9/i2c_master_top.v /home/qlblue/anthony/raptor_regression/tests/design9/I2C_Master_w_CmdQueue.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/design9 --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/design9.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design9.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design9.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/design9} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till router 
run_sta  
run_pe  
save_project 
exit 

