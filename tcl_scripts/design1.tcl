compile_design /home/qlblue/anthony/raptor_regression/tests/design1/af512x32_512x32.v /home/qlblue/anthony/raptor_regression/tests/design1/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/design1/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/design1/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/design1/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/design1/Dma_Ctrl.v /home/qlblue/anthony/raptor_regression/tests/design1/f512x8_512x8.v /home/qlblue/anthony/raptor_regression/tests/design1/f512x16_512x16.v /home/qlblue/anthony/raptor_regression/tests/design1/Fsm_Top.v /home/qlblue/anthony/raptor_regression/tests/design1/Serializer_Deserializer_Test.v /home/qlblue/anthony/raptor_regression/tests/design1/Serializer_Deserializer.v /home/qlblue/anthony/raptor_regression/tests/design1/UART_16550_Interrupt_Control.v /home/qlblue/anthony/raptor_regression/tests/design1/UART_16550_Registers.v /home/qlblue/anthony/raptor_regression/tests/design1/UART_16550_Rx_FIFO.v /home/qlblue/anthony/raptor_regression/tests/design1/UART_16550_Rx_Logic.v /home/qlblue/anthony/raptor_regression/tests/design1/UART_16550_Tx_FIFO.v /home/qlblue/anthony/raptor_regression/tests/design1/UART_16550_Tx_Logic.v /home/qlblue/anthony/raptor_regression/tests/design1/UART_16550.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/design1 --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/design1.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design1.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design1.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/design1} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till router 
run_sta  
run_pe  
save_project
exit  
