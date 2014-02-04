raw_data.dta: DO_files\dataset_raw.do DO_files\missing_data.do 
	StataSE-64 /e run "DO_files\dataset_raw.do"

clean_data.dta: DO_files\dataset.do raw_data.dta
	StataSE-64 /e run "DO_files\dataset.do"

Descriptives\DV\ freqs.txt Descriptives\hist\ *.png: clean_data.dta DO_files\descriptives.do
	StataSE-64 /e run "DO_files\descriptives.do"