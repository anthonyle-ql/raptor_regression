compile_design /home/qlblue/anthony/raptor_regression/tests/inferred_mult/inf_mult.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/infer_mult --load_qdc /home/qlblue/anthony/raptor_regression/tests/inferred_mult/inf_mult.qdc
run_till router 
run_sta  
run_pe  
save_project
exit  
