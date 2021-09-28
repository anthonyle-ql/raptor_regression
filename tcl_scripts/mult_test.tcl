compile_design /home/qlblue/anthony/raptor_regression/tests/mult_test/mult.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/mult --load_qdc /home/qlblue/anthony/raptor_regression/tests/s3b_edif/mult_test.qdc
#load_design {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/mult_test.edf} --load_qdc {/home/qlblue/anthony/raptor_regression/tests/s3b_edif/mult_test.qdc} --working_dir {/home/qlblue/anthony/raptor_regression/result/mult} --part RAPIDMATRIX --pkg PU64 --foundry GF --node 40 
save_project  
run_till router 
run_sta  
run_pe  
save_project  
exit

