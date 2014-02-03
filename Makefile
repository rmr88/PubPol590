raw_data.dta: DO\ files\dataset_raw.do
	StataSE-64 /e run "DO files\dataset_raw.do"

clean_data.dta: DO\ files\dataset.do raw_data.dta
	StataSE-64 /e run "DO files\dataset.do"

Descriptives\DV\ freqs.txt Descriptives\hist\ *.png: clean_data.dta DO\ files\descriptives.do
	StataSE-64 /e run "DO files\descriptives.do"