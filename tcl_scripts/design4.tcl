compile_design /home/qlblue/anthony/raptor_regression/tests/design4/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/design4/AL4S3B_FPGA_Top.v /home/qlblue/anthony/raptor_regression/tests/design4/dma_ctrl.v /home/qlblue/anthony/raptor_regression/tests/design4/f_512_compute.v /home/qlblue/anthony/raptor_regression/tests/design4/f_512_wrapp.v /home/qlblue/anthony/raptor_regression/tests/design4/f_registers.v /home/qlblue/anthony/raptor_regression/tests/design4/ksa32.v /home/qlblue/anthony/raptor_regression/tests/design4/r2_bfly_p.v /home/qlblue/anthony/raptor_regression/tests/design4/r512x16_512x16.v /home/qlblue/anthony/raptor_regression/tests/design4/r512x32_512x32.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/design4 --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/design4.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design4.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/design4.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/design4} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till router 
run_sta  
run_pe  
save_project  
exit
