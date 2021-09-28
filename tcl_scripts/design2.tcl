compile_design /home/qlblue/anthony/raptor_regression/tests/design2/af512x16_512x16.v /home/qlblue/anthony/raptor_regression/tests/design2/af1024x16_1024x16.v /home/qlblue/anthony/raptor_regression/tests/design2/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/design2/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/design2/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/design2/i2s_slave_Rx_FIFOs.v /home/qlblue/anthony/raptor_regression/tests/design2/i2s_slave_rx.v /home/qlblue/anthony/raptor_regression/tests/design2/i2s_slave_w_DMA_registers.v /home/qlblue/anthony/raptor_regression/tests/design2/i2s_slave_w_DMA_StateMachine.v /home/qlblue/anthony/raptor_regression/tests/design2/i2s_slave_w_DMA.v /home/qlblue/anthony/raptor_regression/tests/design2/ir_counters.v /home/qlblue/anthony/raptor_regression/tests/design2/ir_reg_if.v /home/qlblue/anthony/raptor_regression/tests/design2/ir_rx_ctrl.v /home/qlblue/anthony/raptor_regression/tests/design2/ir_tx_ctrl.v /home/qlblue/anthony/raptor_regression/tests/design2/ir_tx_rx_wrap.v /home/qlblue/anthony/raptor_regression/tests/design2/ir_tx_rx.v /home/qlblue/anthony/raptor_regression/tests/design2/r1024x8_1024x8.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/design2 --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/design2.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design2.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design2.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/design2} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till optimizer 
run_till placer 
run_till router 
run_sta  
run_pe  
save_project 
exit 

