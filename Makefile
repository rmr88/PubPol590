all: raw_data.dta clean_data.dta Results\mlogit_results.png Results\predicted_probabilities.png Results\table1.txt Results\table1.xml Results\table2.txt Results\table2.xml Results\table3.txt Results\table3.xml

raw_data.dta: DO_files\dataset_raw.do DO_files\missing_data.do 
	StataSE-64 /e run "DO_files\dataset_raw.do"

clean_data.dta: DO_files\dataset.do DO_files\missing_data.do raw_data.dta
	StataSE-64 /e run "DO_files\dataset.do"

Results\mlogit_results.png Results\predicted_probabilities.png Results\table1.txt Results\table1.xml Results\table2.txt Results\table2.xml Results\table3.txt Results\table3.xml: clean_data.dta DO_files\models.do
	StataSE-64 /e run "DO_files\models.do"
