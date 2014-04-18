cap program drop tabmatrix
program define tabmatrix
	version 8
	syntax varlist [if] [in] [fweight aweight pweight] , matrix(string) [ sort ]
	preserve
	tokenize `varlist'
	local rowvar `1'
	cap local colvar `2'
	qui levelsof `rowvar' `if', local(rowvals)
	if ("`colvar'" != "") { //two-way tab
		qui levelsof `colvar' `if', local(vals)
		local colname ""
		
		foreach val of local vals {
			local value = `val'
			if (`val' == -9) local val = "skip"
			else if (`val' == -99) local val = "inappr"
			tempvar freq`val'
			
			qui gen freq`val' = (`colvar' == `value') if `rowvar' != . & `colvar' != .
			gsort -freq`val'
			local colname : label (`colvar') `= `colvar'[1]'
			if `"`colname'"' == "" local colname = `colvar'[1]
			if `"`colname'"' == "." local colname "missing"
			local colnames `"`colnames' `"`colname'"'"'

		}
		collapse (sum) freq* `if' `in' [`weight' `exp'], by(`rowvar')
		qui drop if `rowvar' == .
		foreach val of local vals {
			if (`val' == -9) local val = "skip"
			else if (`val' == -99) local val = "inappr"
			egen percent`val' = pc(freq`val')
		}
		mkmat percent*, mat(`matrix')
		sort `rowvar'
		local counter = 1
		foreach val of local rowvals {
			local name : label (`rowvar') `= `rowvar'[`counter']'
			if `"`name'"' == "" local name = `rowvar'[`counter']
			if `"`name'"' == "." local name "missing"
			local names `"`names' `"`name'"' "'
			local ++ counter
		}
	}
	else { //one-way tab
		//if "`sort'" != "" gsort -freq
		//local vals 1
		local colnames "Frequency Percent"
		//local colname ""
		
		tempvar freq
		qui gen freq = 1 if `rowvar' < .
		
		collapse (sum) freq `if' `in' [`weight' `exp'], by(`rowvar')
		qui drop if freq == 0
		qui egen percent = pc(freq)
		
		local obs = _N + 1
		qui sum freq
		qui set obs `obs'
		qui replace freq = r(sum) in `obs'
		qui replace percent = 100 in `obs'
		
		mkmat freq percent, mat(`matrix')
		sort `rowvar'
		local counter = 1
		foreach val of local rowvals {
			local name : label (`rowvar') `= `rowvar'[`counter']'
			if `"`name'"' == "" local name = `rowvar'[`counter']
			if `"`name'"' == ".d" local name "missing"
			local names `"`names' `"`name'"' "'
			local ++ counter
		}
		local names `"`names' Total"'
	}
	matrix rownames `matrix' = `names'
	matrix colnames `matrix' = `colnames'
end
