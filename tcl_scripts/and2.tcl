compile_design /home/qlblue/anthony/raptor_regression/tests/AND_gate/and2.v --part RAPIDMATRIX --pkg PU64 --top top --working_dir /home/qlblue/anthony/raptor_regression/result/and2 --load_qdc /home/qlblue/anthony/raptor_regression/tests/AND_gate/and2.qdc
run_till router 
run_sta  
run_pe  
save_project  
exit
