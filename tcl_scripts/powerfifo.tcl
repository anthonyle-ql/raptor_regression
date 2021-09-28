compile_design /home/qlblue/anthony/raptor_regression/tests/PowerfifoDesign/af512x16_512x16.v /home/qlblue/anthony/raptor_regression/tests/PowerfifoDesign/AL4S3B_FPGA_IP.v /home/qlblue/anthony/raptor_regression/tests/PowerfifoDesign/AL4S3B_FPGA_QL_Reserved.v /home/qlblue/anthony/raptor_regression/tests/PowerfifoDesign/AL4S3B_FPGA_Registers.v /home/qlblue/anthony/raptor_regression/tests/PowerfifoDesign/AL4S3B_FPGA_Top.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/powerfifo --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/powerfifo.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/powerfifo.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/powerfifo.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/powerfifo} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till optimizer 
run_till placer 
run_till router 
run_sta  
run_pe  
save_project
exit  

