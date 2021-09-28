compile_design /home/qlblue/anthony/raptor_regression/tests/design5/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/design5/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/design5/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/design5/f_compute.v /home/qlblue/anthony/raptor_regression/tests/design5/fll_acslip.v /home/qlblue/anthony/raptor_regression/tests/design5/i2s_slave_rx.v /home/qlblue/anthony/raptor_regression/tests/design5/i2s_slave_RxRAMs.v /home/qlblue/anthony/raptor_regression/tests/design5/i2s_slave_w_DMA_registers.v /home/qlblue/anthony/raptor_regression/tests/design5/i2s_slave_w_DMA_StateMachine.v /home/qlblue/anthony/raptor_regression/tests/design5/i2s_slave_w_DMA.v /home/qlblue/anthony/raptor_regression/tests/design5/r2_bfly.v /home/qlblue/anthony/raptor_regression/tests/design5/r512x16_512x16.v /home/qlblue/anthony/raptor_regression/tests/design5/r1024x16_1024x16.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/design5 --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/design5.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design5.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design5.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/design5} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till router 
run_sta  
run_pe  
save_project  
exit

