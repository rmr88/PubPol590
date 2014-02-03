cap program define tabmatrix
	version 8
	syntax varlist [if] [in] [fweight aweight pweight] , matrix(string)
	preserve
	tokenize `varlist'
	local rowvar `1'
	cap local colvar `2'
	qui levelsof `rowvar' `if', local(rowvals)
	if ("`colvar'" != "") {
		qui levelsof `colvar' `if', local(vals)
	}
	else {
		local vals 1
		local colnames "Frequency"
	}
	local colname ""
	foreach val of local vals {
		local value = `val'
		if (`val' == -9) local val = "skip"
		else if (`val' == -99) local val = "inappr"
		tempvar freq`val'
		if ("`colvar'" != "") {
			qui gen freq`val' = (`colvar' == `value') if `rowvar' != . & `colvar' != .
			gsort -freq`val'
			local colname : label (`colvar') `= `colvar'[1]'
			if `"`colname'"' == "" local colname = `colvar'[1]
			if `"`colname'"' == "." local colname "missing"
			local colnames `"`colnames' `"`colname'"'"'
		}
		else {
			qui gen freq`val' = 1 if `rowvar' != .
		}
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

	matrix rownames `matrix' = `names'
	matrix colnames `matrix' = `colnames'
end
