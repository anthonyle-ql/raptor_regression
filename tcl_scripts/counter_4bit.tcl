compile_design /home/qlblue/anthony/raptor_regression/tests/counter_4bit/counter_4bit.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/cnt4 --load_qdc /home/qlblue/anthony/raptor_regression/tests/counter_4bit/counter_4bit.qdc
run_till optimizer 
run_till placer 
run_till router 
run_sta  
run_pe  
save_project  
exit 
