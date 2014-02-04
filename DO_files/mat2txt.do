*! 1.1.2 Ben Jann 24 Nov 2004
*! 1.1.1 M Blasnik 18 Feb 2004
*Modified by Robbie Richards, 10/2012
cap program define mat2txt
	version 8.2
	syntax , Matrix(name) SAVing(str) Rows(numlist max=1 >0 integer) Cols(numlist max=1 >0 integer) [ REPlace APPend Title(str) Format(str) NOTe(str) ]
	if "`format'"=="" local format "%10.0g"
	local formatn: word count `format'
	local saving: subinstr local saving "." ".", count(local ext)
	if !`ext' local saving "`saving'.csv"
	tempname myfile
	file open `myfile' using "`saving'", write text `append' `replace'
	local nrows=rowsof(`matrix')
	local ncols=colsof(`matrix')
	QuotedFullnames `matrix' row
	QuotedFullnames `matrix' col
	local countcols = 0
	file write `myfile' "Title,Notes,Cluster Labels,Bar Labels,%" _n //header column
	forvalues c=1/`ncols' {
		if (`c' == 1) file write `myfile' `"`title',`note',"' //title and note on first row of first two columns
		else file write `myfile' `",,"'

		local colname: word `c' of `colnames'
		file write `myfile' `"`colname',"' //row labels
		
		local countrows = 0
		forvalues r = 1/`nrows' { //label, value for the current row, col
			local rowname: word `r' of `rownames'
			if `r' <= `formatn' local fmt: word `r' of `format'
			if (`r' != 1) file write `myfile' ",,,"
			file write `myfile' `"`rowname',"' `fmt' (`matrix'[`r',`c']) "," _n //do we want the % sign, or not?
			local ++countcols
			local ++countrows
		}
		while (`countrows' < `rows') {
			file write `myfile' ",,,(no data yet),0" _n
			local ++countcols
			local ++countrows
		}
	}
	while (`countcols' < (`rows' * `cols')) {
		if (0 == mod(`countcols', `cols')) file write `myfile' ",,(no data yet),(no data yet),0" _n
		else file write `myfile' ",,,(no data yet),0" _n
		local ++countcols
	}
	file write `myfile' _n
	file close `myfile'
end

cap program define QuotedFullnames
	args matrix type
	tempname extract
	local one 1
	local i one
	local j one
	if "`type'"=="row" local i k
	if "`type'"=="col" local j k
	local K = `type'sof(`matrix')
	forv k = 1/`K' {
		mat `extract' = `matrix'[``i''..``i'',``j''..``j'']
		local name: `type'names `extract'
		local eq: `type'eq `extract'
		if `"`eq'"'=="_" local eq
		else local eq `"`eq':"'
		local names `"`names'`"`eq'`name'"' "'
	}
	c_local `type'names `"`names'"'
end
