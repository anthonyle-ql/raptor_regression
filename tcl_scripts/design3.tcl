compile_design /home/qlblue/anthony/raptor_regression/tests/design3/af512x16_512x16.v /home/qlblue/anthony/raptor_regression/tests/design3/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/design3/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/design3/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/design3/deci_filter_fir128coeff.v /home/qlblue/anthony/raptor_regression/tests/design3/fll_acslip.v /home/qlblue/anthony/raptor_regression/tests/design3/i2s_slave_Rx_FIFOs.v /home/qlblue/anthony/raptor_regression/tests/design3/i2s_slave_rx.v /home/qlblue/anthony/raptor_regression/tests/design3/i2s_slave_w_DMA_registers.v /home/qlblue/anthony/raptor_regression/tests/design3/i2s_slave_w_DMA_StateMachine.v /home/qlblue/anthony/raptor_regression/tests/design3/i2s_slave_w_DMA.v /home/qlblue/anthony/raptor_regression/tests/design3/r512x16_512x16.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/design3 --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/design3.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design3.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design3.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/design3} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till optimizer 
run_till placer
run_till router
run_sta  
run_pe  
save_project  
exit
